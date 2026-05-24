import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class PrettyDioLogger extends Interceptor {
  PrettyDioLogger({this.enabled = kDebugMode});

  final bool enabled;

  static const _reset = '\x1B[0m';
  static const _cyan = '\x1B[36m';
  static const _green = '\x1B[32m';
  static const _yellow = '\x1B[33m';
  static const _red = '\x1B[31m';
  static const _magenta = '\x1B[35m';
  static const _blue = '\x1B[34m';
  static const _gray = '\x1B[90m';
  static const _bold = '\x1B[1m';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (enabled) {
      _printBox(
        title: 'DIO REQUEST',
        color: _cyan,
        lines: [
          '${_label('METHOD', _blue)} ${_highlight(options.method, _bold)}',
          '${_label('URI', _blue)} ${_highlight(options.uri.toString(), _magenta)}',
          '${_label('QUERY', _blue)} ${_pretty(options.queryParameters)}',
          '${_label('HEADERS', _blue)} ${_pretty(options.headers)}',
          '${_label('BODY', _blue)} ${_pretty(options.data)}',
        ],
      );
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (enabled) {
      final statusColor = _statusColor(response.statusCode ?? 0);
      _printBox(
        title: 'DIO RESPONSE',
        color: statusColor,
        lines: [
          '${_label('METHOD', _blue)} ${_highlight(response.requestOptions.method, _bold)}',
          '${_label('URI', _blue)} ${_highlight(response.requestOptions.uri.toString(), _magenta)}',
          '${_label('STATUS', _blue)} ${_highlight('${response.statusCode} ${response.statusMessage ?? ''}'.trim(), statusColor + _bold)}',
          '${_label('DATA', _blue)} ${_pretty(response.data)}',
        ],
      );
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (enabled) {
      final response = err.response;
      final statusCode = response?.statusCode;
      _printBox(
        title: 'DIO ERROR',
        color: _red,
        lines: [
          '${_label('TYPE', _blue)} ${_highlight(err.type.name, _red + _bold)}',
          '${_label('METHOD', _blue)} ${_highlight(err.requestOptions.method, _bold)}',
          '${_label('URI', _blue)} ${_highlight(err.requestOptions.uri.toString(), _magenta)}',
          if (statusCode != null)
            '${_label('STATUS', _blue)} ${_highlight('$statusCode ${response?.statusMessage ?? ''}'.trim(), _yellow + _bold)}',
          '${_label('MESSAGE', _blue)} ${_highlight(err.message ?? 'Unknown Dio error', _red)}',
          '${_label('RESPONSE', _blue)} ${_pretty(response?.data)}',
        ],
      );
    }
    handler.next(err);
  }

  void _printBox({
    required String title,
    required String color,
    required List<String> lines,
  }) {
    final top = '$color+${'-' * 24} $title ${'-' * 24}+$_reset';
    final bottom = '$color+${'-' * (50 + title.length)}+$_reset';
    debugPrint(top);
    for (final line in lines) {
      final sanitized = line.isEmpty ? '-' : line;
      for (final chunk in _chunk(sanitized, 140)) {
        debugPrint('$color|$_reset $chunk');
      }
    }
    debugPrint(bottom);
  }

  List<String> _chunk(String input, int maxLength) {
    final normalized = input.replaceAll('\n', '\n  ');
    final lines = normalized.split('\n');
    final chunks = <String>[];
    for (final line in lines) {
      if (line.length <= maxLength) {
        chunks.add(line);
        continue;
      }
      var start = 0;
      while (start < line.length) {
        final end = (start + maxLength < line.length)
            ? start + maxLength
            : line.length;
        chunks.add(line.substring(start, end));
        start = end;
      }
    }
    return chunks;
  }

  String _pretty(Object? value) {
    if (value == null) {
      return _highlight('null', _gray);
    }
    if (value is String) {
      return value;
    }
    const encoder = JsonEncoder.withIndent('  ');
    try {
      return encoder.convert(value);
    } catch (_) {
      return value.toString();
    }
  }

  String _label(String label, String color) {
    return '$color$label:$_reset';
  }

  String _highlight(String text, String color) {
    return '$color$text$_reset';
  }

  String _statusColor(int statusCode) {
    if (statusCode >= 200 && statusCode < 300) {
      return _green;
    }
    if (statusCode >= 300 && statusCode < 400) {
      return _cyan;
    }
    if (statusCode >= 400 && statusCode < 500) {
      return _yellow;
    }
    return _red;
  }
}
