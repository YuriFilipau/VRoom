import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const backendServerNotFoundMessage =
    'Сервер не найден. Проверьте, что телефон подключён к корректной сети, и попробуйте ещё раз.';

class BackendDiscoveryException implements Exception {
  const BackendDiscoveryException([
    this.message = backendServerNotFoundMessage,
  ]);

  final String message;

  @override
  String toString() => message;
}

class BackendDiscoveryService {
  BackendDiscoveryService({required SharedPreferences sharedPreferences})
    : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  static const _savedBaseUrlKey = 'backend_base_url';
  static const _discoveryToken = 'VRQ_DISCOVER';
  static const _serviceName = 'vr-quest-backend';
  static const _apiPort = 8000;
  static const _discoveryPort = 37020;
  static const _udpAttempts = 2;
  static const _scanBatchSize = 32;
  static const _healthCheckTimeout = Duration(seconds: 2);
  static const _udpReceiveTimeout = Duration(seconds: 2);
  static const _scanHealthTimeout = Duration(milliseconds: 600);
  static const _emulatorBaseUrl = 'http://10.0.2.2:8000';

  Future<String> resolveBaseUrl() async {
    final savedBaseUrl = await getSavedBaseUrl();
    if (savedBaseUrl != null && await checkHealth(savedBaseUrl)) {
      await saveResolvedBaseUrl(savedBaseUrl);
      return savedBaseUrl;
    }

    final discoveredUrls = await discoverByUdpBroadcast();
    for (final baseUrl in discoveredUrls) {
      if (await checkHealth(baseUrl)) {
        await saveResolvedBaseUrl(baseUrl);
        return baseUrl;
      }
    }

    final scannedBaseUrl = await scanLocalSubnet();
    if (scannedBaseUrl != null) {
      await saveResolvedBaseUrl(scannedBaseUrl);
      return scannedBaseUrl;
    }

    throw const BackendDiscoveryException();
  }

  Future<bool> checkHealth(
    String baseUrl, {
    Duration timeout = _healthCheckTimeout,
  }) async {
    final normalizedBaseUrl = _normalizeBaseUrl(baseUrl);
    if (normalizedBaseUrl == null) {
      return false;
    }

    final healthUri = Uri.tryParse('$normalizedBaseUrl/api/health');
    if (healthUri == null) {
      return false;
    }

    final dio = Dio(
      BaseOptions(
        connectTimeout: timeout,
        receiveTimeout: timeout,
        sendTimeout: timeout,
        validateStatus: (status) =>
            status != null && status >= 200 && status < 300,
      ),
    );

    try {
      final response = await dio.getUri<dynamic>(healthUri).timeout(timeout);
      return response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300;
    } catch (_) {
      return false;
    }
  }

  Future<List<String>> discoverByUdpBroadcast() async {
    final resolvedUrls = <String>{};
    final payload = utf8.encode(
      jsonEncode(const {'type': 'vrq_discover', 'token': _discoveryToken}),
    );

    for (var attempt = 0; attempt < _udpAttempts; attempt++) {
      RawDatagramSocket? socket;
      StreamSubscription<RawSocketEvent>? subscription;
      Timer? timer;
      final completer = Completer<void>();

      try {
        socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);
        socket.broadcastEnabled = true;

        subscription = socket.listen((event) {
          if (event != RawSocketEvent.read) {
            return;
          }

          Datagram? datagram;
          while ((datagram = socket?.receive()) != null) {
            final response = utf8.decode(datagram!.data, allowMalformed: true);
            resolvedUrls.addAll(_parseDiscoveryBaseUrls(response));
          }

          if (resolvedUrls.isNotEmpty && !completer.isCompleted) {
            completer.complete();
          }
        });

        timer = Timer(_udpReceiveTimeout, () {
          if (!completer.isCompleted) {
            completer.complete();
          }
        });

        for (final address in await _broadcastAddresses()) {
          try {
            socket.send(payload, address, _discoveryPort);
          } catch (_) {
            continue;
          }
        }

        await completer.future;
      } catch (_) {
        // UDP discovery is best-effort. Resolver will continue with subnet scan.
      } finally {
        timer?.cancel();
        await subscription?.cancel();
        socket?.close();
      }

      if (resolvedUrls.isNotEmpty) {
        break;
      }
    }

    return resolvedUrls.toList(growable: false);
  }

  Future<String?> scanLocalSubnet() async {
    final prefixes = await _localSubnetPrefixes();

    for (final prefix in prefixes) {
      final foundBaseUrl = await _scanPrefix(prefix);
      if (foundBaseUrl != null) {
        return foundBaseUrl;
      }
    }

    if (kDebugMode &&
        await checkHealth(_emulatorBaseUrl, timeout: _scanHealthTimeout)) {
      return _emulatorBaseUrl;
    }

    return null;
  }

  Future<void> saveResolvedBaseUrl(String baseUrl) async {
    final normalizedBaseUrl = _normalizeBaseUrl(baseUrl);
    if (normalizedBaseUrl == null) {
      return;
    }
    await _sharedPreferences.setString(_savedBaseUrlKey, normalizedBaseUrl);
  }

  Future<String?> getSavedBaseUrl() async {
    final savedBaseUrl = _sharedPreferences.getString(_savedBaseUrlKey);
    return savedBaseUrl == null ? null : _normalizeBaseUrl(savedBaseUrl);
  }

  Future<String?> _scanPrefix(String prefix) async {
    final hosts = List<int>.generate(254, (index) => index + 1);

    for (var offset = 0; offset < hosts.length; offset += _scanBatchSize) {
      final batch = hosts.skip(offset).take(_scanBatchSize);
      final results = await Future.wait(
        batch.map((host) async {
          final baseUrl = 'http://$prefix.$host:$_apiPort';
          final isHealthy = await checkHealth(
            baseUrl,
            timeout: _scanHealthTimeout,
          );
          return isHealthy ? baseUrl : null;
        }),
      );

      for (final result in results) {
        if (result != null) {
          return result;
        }
      }
    }

    return null;
  }

  List<String> _parseDiscoveryBaseUrls(String response) {
    try {
      final decoded = jsonDecode(response);
      if (decoded is! Map<String, dynamic>) {
        return const [];
      }

      final service = decoded['service'];
      if (service != null && service != _serviceName) {
        return const [];
      }

      final apiPort = decoded['api_port'] is int
          ? decoded['api_port'] as int
          : _apiPort;
      final urls = <String>{};
      final baseUrls = decoded['base_urls'];
      if (baseUrls is List) {
        for (final value in baseUrls) {
          final normalizedBaseUrl = _normalizeBaseUrl(value.toString());
          if (normalizedBaseUrl != null) {
            urls.add(normalizedBaseUrl);
          }
        }
      }

      final localIps = decoded['local_ips'];
      if (localIps is List) {
        for (final value in localIps) {
          final ip = value.toString().trim();
          if (_isUsableIpv4(ip)) {
            urls.add('http://$ip:$apiPort');
          }
        }
      }

      return urls.toList(growable: false);
    } catch (_) {
      return const [];
    }
  }

  Future<List<InternetAddress>> _broadcastAddresses() async {
    final addresses = <String>{'255.255.255.255'};

    for (final ip in await _localIpv4Addresses()) {
      final parts = ip.address.split('.');
      if (parts.length == 4) {
        addresses.add('${parts[0]}.${parts[1]}.${parts[2]}.255');
      }
    }

    return addresses.map(InternetAddress.new).toList(growable: false);
  }

  Future<List<String>> _localSubnetPrefixes() async {
    final prefixes = <String>{};

    for (final ip in await _localIpv4Addresses()) {
      final parts = ip.address.split('.');
      if (parts.length == 4) {
        prefixes.add('${parts[0]}.${parts[1]}.${parts[2]}');
      }
    }

    return prefixes.toList(growable: false);
  }

  Future<List<InternetAddress>> _localIpv4Addresses() async {
    try {
      final interfaces = await NetworkInterface.list(
        includeLoopback: false,
        type: InternetAddressType.IPv4,
      );

      return interfaces
          .expand((interface) => interface.addresses)
          .where((address) => _isUsableIpv4(address.address))
          .toList(growable: false);
    } catch (_) {
      return const [];
    }
  }

  bool _isUsableIpv4(String address) {
    final parts = address.split('.').map(int.tryParse).toList();
    if (parts.length != 4 || parts.any((part) => part == null)) {
      return false;
    }

    final first = parts[0]!;
    final second = parts[1]!;
    if (first == 10) {
      return true;
    }
    if (first == 172 && second >= 16 && second <= 31) {
      return true;
    }
    if (first == 192 && second == 168) {
      return true;
    }
    return false;
  }

  String? _normalizeBaseUrl(String raw) {
    var value = raw.trim();
    while (value.endsWith('/')) {
      value = value.substring(0, value.length - 1);
    }

    final uri = Uri.tryParse(value);
    if (uri == null ||
        !uri.hasScheme ||
        uri.host.isEmpty ||
        (uri.scheme != 'http' && uri.scheme != 'https')) {
      return null;
    }

    return value;
  }
}
