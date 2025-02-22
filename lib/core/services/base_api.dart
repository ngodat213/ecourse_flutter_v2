import 'package:dio/dio.dart';
import '../config/app_config.dart';
import 'package:easy_localization/easy_localization.dart';

class BaseApi {
  late Dio _dio;
  final String? token;

  BaseApi({this.token}) {
    _initDio();
  }

  void _initDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        connectTimeout: const Duration(milliseconds: AppConfig.connectTimeout),
        receiveTimeout: const Duration(milliseconds: AppConfig.receiveTimeout),
        headers: _getHeaders(),
      ),
    );

    _dio.interceptors.addAll([_getAuthInterceptor(), _getLogInterceptor()]);
  }

  Map<String, dynamic> _getHeaders() {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  Interceptor _getAuthInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        // Add auth token if available
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          // Handle token expired
          // You can implement token refresh logic here
        }
        return handler.next(error);
      },
    );
  }

  Interceptor _getLogInterceptor() {
    return LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    );
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return Exception('connection_timeout'.tr());
        case DioExceptionType.sendTimeout:
          return Exception('send_timeout'.tr());
        case DioExceptionType.receiveTimeout:
          return Exception('receive_timeout'.tr());
        case DioExceptionType.badResponse:
          return _handleBadResponse(error.response);
        case DioExceptionType.cancel:
          return Exception('request_cancelled'.tr());
        default:
          return Exception('network_error'.tr());
      }
    }
    return Exception('something_went_wrong'.tr());
  }

  Exception _handleBadResponse(Response? response) {
    switch (response?.statusCode) {
      case 400:
        return Exception(response?.data['message'] ?? 'bad_request'.tr());
      case 401:
        return Exception(response?.data['message'] ?? 'unauthorized'.tr());
      case 403:
        return Exception(response?.data['message'] ?? 'forbidden'.tr());
      case 404:
        return Exception(response?.data['message'] ?? 'not_found'.tr());
      case 500:
        return Exception(response?.data['message'] ?? 'server_error'.tr());
      default:
        return Exception('something_went_wrong'.tr());
    }
  }
}
