import 'package:ecourse_flutter_v2/core/services/base_api.dart';

abstract class UserRepository {
  Future<ApiResponse> getUserProfile();
  Future<ApiResponse> updateProfile(Map<String, dynamic> data);
  Future<ApiResponse> changePassword({
    required String currentPassword,
    required String newPassword,
  });
  Future<ApiResponse> uploadAvatar(String filePath);
  Future<ApiResponse> getAllUsers({
    int page = 1,
    int limit = 10,
    String? search,
    String sort = '-createdAt',
  });
  Future<ApiResponse> getUserById(String id);
  Future<ApiResponse> updateUser(String id, Map<String, dynamic> data);
  Future<ApiResponse> deleteUser(String id);
  Future<ApiResponse> setUserRole(String userId, String role);
  Future<ApiResponse> getTeachers();
  Future<ApiResponse> getTeacherById(String id);
  Future<ApiResponse> updateStreak({
    required int duration,
    required String type,
  });
  Future<ApiResponse> getStreakInfo();
}
