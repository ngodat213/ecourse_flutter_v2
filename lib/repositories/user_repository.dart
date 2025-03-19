import 'package:ecourse_flutter_v2/core/config/app_config.dart';
import 'package:ecourse_flutter_v2/core/services/base_api.dart';
import 'package:ecourse_flutter_v2/core/services/file_utils.dart';

class UserRepository extends BaseAPI {
  final BaseAPI _api = BaseAPI();

  Future<ApiResponse> getUserProfile() async {
    try {
      final response = await fetchData(
        AppConfig.userProfile,
        method: ApiMethod.GET,
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  Future<ApiResponse> updateProfile(Map<String, dynamic> data) async {
    try {
      final response = await fetchData(
        AppConfig.userProfile,
        method: ApiMethod.PUT,
        body: data,
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  Future<ApiResponse> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final response = await fetchData(
        AppConfig.changePassword,
        method: ApiMethod.PUT,
        body: {'currentPassword': currentPassword, 'newPassword': newPassword},
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  Future<ApiResponse> uploadAvatar(String filePath) async {
    try {
      // Kiểm tra file có tồn tại và là ảnh không
      if (!isImageFile(filePath)) {
        return ApiResponse(success: false, message: 'File không phải là ảnh');
      }

      // Kiểm tra kích thước file (tối đa 5MB)
      if (!await isFileSizeValid(filePath, 5)) {
        return ApiResponse(
          success: false,
          message: 'Kích thước file không được vượt quá 5MB',
        );
      }

      // Đọc file thành bytes
      final file = await filePathToBytes(filePath);

      // Tạo tên file unique
      final fileName = generateUniqueFileName(getFileName(filePath));

      final response = await fileUpload(
        AppConfig.uploadAvatar,
        file: file,
        method: ApiMethod.POST,
        body: {'fileName': fileName},
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  // Admin only
  Future<ApiResponse> getAllUsers({
    int page = 1,
    int limit = 10,
    String? search,
    String sort = '-createdAt',
  }) async {
    try {
      final response = await fetchData(
        AppConfig.adminUsers,
        method: ApiMethod.GET,
        params: {
          'page': page.toString(),
          'limit': limit.toString(),
          'sort': sort,
          if (search != null) 'search': search,
        },
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  Future<ApiResponse> getUserById(String id) async {
    try {
      final response = await fetchData(
        '${AppConfig.adminUsers}/$id',
        method: ApiMethod.GET,
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  Future<ApiResponse> updateUser(String id, Map<String, dynamic> data) async {
    try {
      final response = await fetchData(
        '${AppConfig.adminUsers}/$id',
        method: ApiMethod.PUT,
        body: data,
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  Future<ApiResponse> deleteUser(String id) async {
    try {
      final response = await fetchData(
        '${AppConfig.adminUsers}/$id',
        method: ApiMethod.DELETE,
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  Future<ApiResponse> setUserRole(String userId, String role) async {
    try {
      final response = await fetchData(
        AppConfig.setUserRole,
        method: ApiMethod.PUT,
        body: {'userId': userId, 'role': role},
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  Future<ApiResponse> getTeachers() async {
    try {
      final response = await fetchData(
        AppConfig.teachers,
        method: ApiMethod.GET,
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  Future<ApiResponse> getTeacherById(String id) async {
    try {
      final response = await fetchData(
        '${AppConfig.teachers}/$id',
        method: ApiMethod.GET,
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  /// Cập nhật streak khi học đủ thời gian
  Future<ApiResponse> updateStreak({
    required int duration,
    required String type,
  }) async {
    try {
      final response = await _api.fetchData(
        '/users/streak/increment',
        method: ApiMethod.POST,
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  /// Lấy thông tin streak của user
  Future<ApiResponse> getStreakInfo() async {
    try {
      final response = await _api.fetchData(
        '/user/streak',
        method: ApiMethod.GET,
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }
}
