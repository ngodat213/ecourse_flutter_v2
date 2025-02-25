import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecourse_flutter_v2/core/services/shared_prefs.dart';

enum ApiStatus { succeeded, failed, internetUnavailable }

enum ApiMethod { get, post, put, delete }

const Map<ApiMethod, String> apiMethod = {
  ApiMethod.get: 'GET',
  ApiMethod.post: 'POST',
  ApiMethod.put: 'PUT',
  ApiMethod.delete: 'DELETE',
};

class ApiResponse {
  final int? code;
  final String? message;
  final dynamic body;
  final bool? success;
  final String? error;

  ApiResponse({this.code, this.message, this.body, this.success, this.error});

  bool get allGood => success ?? false;
  bool hasError() => error?.isNotEmpty ?? false;
  bool hasData() => body != null;

  factory ApiResponse.fromResponse(dynamic response) {
    return ApiResponse(
      code: response['statusCode'],
      message: response['message'] ?? '',
      body: response['data'],
      success: response['success'],
      error: response['error'] ?? '',
    );
  }
}

class BaseAPI {
  static String domain = 'http://192.168.0.108:3000/api';
  final Dio _dio = Dio();

  Future<Map<String, String>> getHeaders() async {
    final userToken = SharedPrefs.getToken();
    return {"Authorization": "Bearer $userToken"};
  }

  Future<Response> fetchData(
    String url, {
    dynamic body,
    bool includeHeaders = false,
    bool forceRefresh = false,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
    ApiMethod method = ApiMethod.get,
  }) async {
    try {
      final options = Options(
        method: apiMethod[method],
        headers: includeHeaders ? headers : await getHeaders(),
      );

      var data = await _dio.request(
        '$domain$url',
        data: body,
        queryParameters: params,
        options: options,
      );
      return data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response> fileUpload(
    String url, {
    required Uint8List file,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    required ApiMethod method,
    dynamic body,
  }) async {
    if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
      throw ApiStatus.internetUnavailable;
    }

    try {
      final options = Options(
        method: apiMethod[method],
        headers: headers ?? await getHeaders(),
      );

      final formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(file, filename: 'upload.png'),
        if (body != null) ...body,
      });

      return await _dio.request(
        '$domain$url',
        data: formData,
        queryParameters: params,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  String _handleDioError(DioException ex) {
    switch (ex.type) {
      case DioExceptionType.cancel:
        return 'Request to server was cancelled.';
      case DioExceptionType.connectionTimeout:
        return 'Connection timed out.';
      case DioExceptionType.receiveTimeout:
        return 'Receiving timeout occurred.';
      case DioExceptionType.sendTimeout:
        return 'Request send timeout.';
      case DioExceptionType.badResponse:
        return _handleStatusCode(ex.response?.statusCode);
      case DioExceptionType.unknown:
        return ex.message?.contains('SocketException') ?? false
            ? 'No Internet.'
            : 'Unexpected error occurred.';
      default:
        return 'Something went wrong.';
    }
  }

  String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request.';
      case 401:
        return 'Authentication failed.';
      case 403:
        return 'Not authorized to access this endpoint.';
      case 404:
        return 'Requested resource not found.';
      case 500:
        return 'Internal server error.';
      default:
        return 'An error occurred.';
    }
  }
}
