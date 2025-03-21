import 'package:ecourse_flutter_v2/core/services/base_api.dart';

abstract class AuthRepository {
  Future<ApiResponse> login({required String email, required String password});
  Future<ApiResponse> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  });
  Future<ApiResponse> registerMobile({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  });
  Future<ApiResponse> verifyOTP({required String email, required String otp});
  Future<ApiResponse> resendOTP({required String userId, required String type});
  Future<ApiResponse> forgotPassword({required String email});
  Future<ApiResponse> forgotPasswordMobile({required String email});
  Future<ApiResponse> resetPassword({
    required String token,
    required String newPassword,
  });
  Future<ApiResponse> resetPasswordWithOTP({
    required String userId,
    required String otp,
    required String newPassword,
  });
  Future<ApiResponse> refreshToken({required String refreshToken});
  Future<ApiResponse> logout({required String refreshToken});
}
