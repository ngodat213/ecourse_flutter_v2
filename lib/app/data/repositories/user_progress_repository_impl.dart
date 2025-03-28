import 'package:ecourse_flutter_v2/app/data/models/user_progress_model.dart';
import 'package:ecourse_flutter_v2/app/domain/repositories/user_progress_repository.dart';
import 'package:ecourse_flutter_v2/core/services/base_api.dart';

class UserProgressRepositoryImpl implements UserProgressRepository {
  final BaseAPI _api;

  UserProgressRepositoryImpl({BaseAPI? api}) : _api = api ?? BaseAPI();

  /// Tạo progress mới cho một content
  @override
  Future<ApiResponse> createContentProgress(
    String courseId,
    String contentId,
  ) async {
    try {
      final response = await _api.fetchData(
        '/progress/course/$courseId/content/$contentId',
        method: ApiMethod.POST,
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  /// Lấy tất cả progress của user trong một khóa học
  @override
  Future<ApiResponse> getCourseProgress(String courseId) async {
    try {
      final response = await _api.fetchData(
        '/progress/course/$courseId',
        method: ApiMethod.GET,
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  /// Lấy tất cả content và progress của một lesson
  @override
  Future<ApiResponse> getLessonContentsProgress(String lessonId) async {
    try {
      final response = await _api.fetchData(
        '/progress/lesson/$lessonId/contents',
        method: ApiMethod.GET,
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  /// Lấy progress của một content cụ thể
  @override
  Future<ApiResponse> getContentProgress(String contentId) async {
    try {
      final response = await _api.fetchData(
        '/progress/content/$contentId',
        method: ApiMethod.GET,
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  /// Cập nhật progress của một content
  @override
  Future<ApiResponse> updateContentProgress(
    String contentId,
    String status,
  ) async {
    try {
      final response = await _api.fetchData(
        '/progress/content/$contentId',
        method: ApiMethod.PUT,
        body: {'status': status},
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  /// Đánh dấu content đã hoàn thành
  @override
  Future<ApiResponse> markContentComplete(String contentId) async {
    try {
      final response = await _api.fetchData(
        '/progress/content/$contentId/complete',
        method: ApiMethod.POST,
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  /// Chuyển đổi response body thành danh sách UserProgressModel
  @override
  List<UserProgressModel> parseProgressList(Map<String, dynamic> body) {
    final List<dynamic> progressList = body['progress'] ?? [];
    return progressList
        .map((progress) => UserProgressModel.fromJson(progress))
        .toList();
  }

  /// Chuyển đổi response body thành UserProgressModel
  @override
  UserProgressModel? parseProgress(Map<String, dynamic> body) {
    final dynamic progress = body['progress'];
    return progress != null ? UserProgressModel.fromJson(progress) : null;
  }
}
