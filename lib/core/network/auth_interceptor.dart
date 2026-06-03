import 'package:dio/dio.dart';
import 'package:vroom/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:vroom/features/auth/data/models/user_model.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required Dio dio,
    required AuthLocalDatasource authLocalDatasource,
  }) : _dio = dio,
       _authLocalDatasource = authLocalDatasource,
       _refreshDio = Dio(
         BaseOptions(
           baseUrl: dio.options.baseUrl,
           connectTimeout: dio.options.connectTimeout,
           receiveTimeout: dio.options.receiveTimeout,
           sendTimeout: dio.options.sendTimeout,
         ),
       );

  final Dio _dio;
  final Dio _refreshDio;
  final AuthLocalDatasource _authLocalDatasource;

  Future<void> _attachAccessToken(RequestOptions options) async {
    final token = await _authLocalDatasource.getCachedToken();
    if (token == null || token.isEmpty) {
      return;
    }
    options.headers['Authorization'] = 'Bearer $token';
  }

  bool _isAuthRequest(RequestOptions options) {
    final path = options.path;
    return path.contains('/api/auth/login') ||
        path.contains('/api/auth/refresh');
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final skipAuth = options.extra['skipAuth'] == true;
    if (!skipAuth && !_isAuthRequest(options)) {
      await _attachAccessToken(options);
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final statusCode = err.response?.statusCode;
    final options = err.requestOptions;
    final wasRetried = options.extra['authRetried'] == true;

    if (statusCode != 401 || wasRetried || _isAuthRequest(options)) {
      handler.next(err);
      return;
    }

    final refreshToken = await _authLocalDatasource.getCachedRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      await _authLocalDatasource.clearToken();
      handler.next(err);
      return;
    }

    try {
      _refreshDio.options.baseUrl = _dio.options.baseUrl;
      final refreshResponse = await _refreshDio.post<Map<String, dynamic>>(
        '/api/auth/refresh',
        data: {'refresh': refreshToken},
        options: Options(extra: const {'skipAuth': true}),
      );

      final data = refreshResponse.data ?? const <String, dynamic>{};
      final nextAccessToken = data['access'] as String?;
      final nextRefreshToken =
          (data['refresh'] as String?)?.trim().isNotEmpty == true
          ? data['refresh'] as String
          : refreshToken;

      if (nextAccessToken == null || nextAccessToken.isEmpty) {
        await _authLocalDatasource.clearToken();
        handler.next(err);
        return;
      }

      await _authLocalDatasource.cacheTokens(
        accessToken: nextAccessToken,
        refreshToken: nextRefreshToken,
      );

      final userJson = data['user'];
      if (userJson is Map<String, dynamic>) {
        await _authLocalDatasource.cacheUser(User.fromJson(userJson));
      }

      final retryOptions = Options(
        method: options.method,
        headers: Map<String, dynamic>.from(options.headers)
          ..['Authorization'] = 'Bearer $nextAccessToken',
        responseType: options.responseType,
        contentType: options.contentType,
        sendTimeout: options.sendTimeout,
        receiveTimeout: options.receiveTimeout,
        extra: Map<String, dynamic>.from(options.extra)..['authRetried'] = true,
        followRedirects: options.followRedirects,
        receiveDataWhenStatusError: options.receiveDataWhenStatusError,
        listFormat: options.listFormat,
        validateStatus: options.validateStatus,
      );

      final response = await _dio.request<dynamic>(
        options.path,
        data: options.data,
        queryParameters: options.queryParameters,
        cancelToken: options.cancelToken,
        onReceiveProgress: options.onReceiveProgress,
        onSendProgress: options.onSendProgress,
        options: retryOptions,
      );

      handler.resolve(response);
    } catch (_) {
      await _authLocalDatasource.clearToken();
      handler.next(err);
    }
  }
}
