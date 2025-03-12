import 'package:ecourse_flutter_v2/core/services/base_api.dart';

class AuthRepository {
  final BaseAPI _api;

  AuthRepository({BaseAPI? api}) : _api = api ?? BaseAPI();

  // Đăng ký tài khoản qua email
  Future<ApiResponse> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    final response = await _api.fetchData(
      '/auth/register',
      method: ApiMethod.POST,
      body: {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
      },
    );
    return ApiResponse.fromResponse(response.data);
  }

  // Đăng ký qua mobile (OTP)
  Future<ApiResponse> registerMobile({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    final response = await _api.fetchData(
      '/auth/register/mobile',
      method: ApiMethod.POST,
      body: {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
      },
    );
    return ApiResponse.fromResponse(response.data);
  }

  // Xác thực OTP
  Future<ApiResponse> verifyOTP({
    required String email,
    required String otp,
  }) async {
    final response = await _api.fetchData(
      '/auth/verify-otp',
      method: ApiMethod.POST,
      body: {'email': email, 'otp': otp},
    );
    return ApiResponse.fromResponse(response.data);
  }

  // Gửi lại OTP
  Future<ApiResponse> resendOTP({
    required String userId,
    String type = 'verification',
  }) async {
    final response = await _api.fetchData(
      '/auth/resend-otp',
      method: ApiMethod.POST,
      body: {'userId': userId, 'type': type},
    );
    return ApiResponse.fromResponse(response.data);
  }

  // Đăng nhập
  Future<ApiResponse> login({
    required String email,
    required String password,
  }) async {
    final response = await _api.fetchData(
      '/auth/login',
      method: ApiMethod.POST,
      body: {'email': email, 'password': password},
    );
    return ApiResponse.fromResponse(response.data);
  }

  // Quên mật khẩu qua email
  Future<ApiResponse> forgotPassword({required String email}) async {
    final response = await _api.fetchData(
      '/auth/forgot-password',
      method: ApiMethod.POST,
      body: {'email': email},
    );
    return ApiResponse.fromResponse(response.data);
  }

  // Quên mật khẩu qua mobile (OTP)
  Future<ApiResponse> forgotPasswordMobile({required String email}) async {
    final response = await _api.fetchData(
      '/auth/forgot-password/mobile',
      method: ApiMethod.POST,
      body: {'email': email},
    );
    return ApiResponse.fromResponse(response.data);
  }

  // Đặt lại mật khẩu với token
  Future<ApiResponse> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    final response = await _api.fetchData(
      '/auth/reset-password/$token',
      method: ApiMethod.POST,
      body: {'password': newPassword},
    );
    return ApiResponse.fromResponse(response.data);
  }

  // Đặt lại mật khẩu với OTP
  Future<ApiResponse> resetPasswordWithOTP({
    required String userId,
    required String otp,
    required String newPassword,
  }) async {
    final response = await _api.fetchData(
      '/auth/reset-password/otp',
      method: ApiMethod.POST,
      body: {'userId': userId, 'otp': otp, 'newPassword': newPassword},
    );
    return ApiResponse.fromResponse(response.data);
  }

  // Refresh token
  Future<ApiResponse> refreshToken({required String refreshToken}) async {
    final response = await _api.fetchData(
      '/auth/refresh-token',
      method: ApiMethod.POST,
      body: {'refresh_token': refreshToken},
    );
    return ApiResponse.fromResponse(response.data);
  }

  // Đăng xuất
  Future<ApiResponse> logout({required String refreshToken}) async {
    final response = await _api.fetchData(
      '/auth/logout',
      method: ApiMethod.POST,
      body: {'refresh_token': refreshToken},
    );
    return ApiResponse.fromResponse(response.data);
  }
}
