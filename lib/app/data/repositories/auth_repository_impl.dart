import 'package:ecourse_flutter_v2/app/domain/repositories/auth_repository.dart';
import 'package:ecourse_flutter_v2/core/services/base_api.dart';

class AuthRepositoryImpl implements AuthRepository {
  final BaseAPI _api;

  AuthRepositoryImpl({BaseAPI? api}) : _api = api ?? BaseAPI();

  // Đăng ký tài khoản qua email
  @override
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
  @override
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
  @override
  Future<ApiResponse> verifyOTP({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await _api.fetchData(
        '/auth/verify-otp',
        method: ApiMethod.POST,
        body: {'email': email, 'otp': otp},
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  // Gửi lại OTP
  @override
  Future<ApiResponse> resendOTP({
    required String userId,
    required String type,
  }) async {
    try {
      final response = await _api.fetchData(
        '/auth/resend-otp',
        method: ApiMethod.POST,
        body: {'userId': userId, 'type': type},
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  // Đăng nhập
  @override
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
  @override
  Future<ApiResponse> forgotPassword({required String email}) async {
    final response = await _api.fetchData(
      '/auth/forgot-password',
      method: ApiMethod.POST,
      body: {'email': email},
    );
    return ApiResponse.fromResponse(response.data);
  }

  // Quên mật khẩu qua mobile (OTP)
  @override
  Future<ApiResponse> forgotPasswordMobile({required String email}) async {
    final response = await _api.fetchData(
      '/auth/forgot-password/mobile',
      method: ApiMethod.POST,
      body: {'email': email},
    );
    return ApiResponse.fromResponse(response.data);
  }

  // Đặt lại mật khẩu với token
  @override
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
  @override
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
  @override
  Future<ApiResponse> refreshToken({required String refreshToken}) async {
    final response = await _api.fetchData(
      '/auth/refresh-token',
      method: ApiMethod.POST,
      body: {'refresh_token': refreshToken},
    );
    return ApiResponse.fromResponse(response.data);
  }

  // Đăng xuất
  @override
  Future<ApiResponse> logout({required String refreshToken}) async {
    final response = await _api.fetchData(
      '/auth/logout',
      method: ApiMethod.POST,
      body: {'refresh_token': refreshToken},
    );
    return ApiResponse.fromResponse(response.data);
  }
}
