import 'package:ecourse_flutter_v2/core/services/base_api.dart';

class UserProgressRepository {
  final BaseAPI _api;

  UserProgressRepository({BaseAPI? api}) : _api = api ?? BaseAPI();

  // Lấy tất cả tiến độ của khóa học
  Future<ApiResponse> getAllProgress(String courseId) async {
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

  // Cập nhật tiến độ bài học
  Future<ApiResponse> updateProgress(
    String lessonId,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _api.fetchData(
        '/progress/lesson/$lessonId',
        method: ApiMethod.PUT,
        body: data,
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  // Đánh dấu bài học đã hoàn thành
  Future<ApiResponse> markLessonComplete(String lessonId) async {
    try {
      final response = await _api.fetchData(
        '/progress/lesson/$lessonId/complete',
        method: ApiMethod.PUT,
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  // Lấy tiến độ của một bài học cụ thể
  Future<ApiResponse> getProgressByLesson(String lessonId) async {
    try {
      final response = await _api.fetchData(
        '/progress/lesson/$lessonId',
        method: ApiMethod.GET,
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  // Tạo tiến độ mới cho bài học
  Future<ApiResponse> createProgress(String courseId, String lessonId) async {
    try {
      final response = await _api.fetchData(
        '/progress/course/$courseId/lesson/$lessonId',
        method: ApiMethod.POST,
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }
}
