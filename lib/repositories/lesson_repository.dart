import 'package:ecourse_flutter_v2/core/config/app_config.dart';
import 'package:ecourse_flutter_v2/core/services/base_api.dart';

class LessonRepository {
  final BaseAPI _api;

  LessonRepository({BaseAPI? api}) : _api = api ?? BaseAPI();

  // Lấy danh sách bài học của khóa học
  Future<ApiResponse> getLessons(String courseId) async {
    try {
      final response = await _api.fetchData(
        '${AppConfig.lessons}/$courseId',
        method: ApiMethod.GET,
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  // Lấy chi tiết một bài học
  Future<ApiResponse> getLessonById(String lessonId) async {
    try {
      final response = await _api.fetchData(
        '/lessons/$lessonId',
        method: ApiMethod.GET,
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  // Lấy nội dung video của bài học
  Future<ApiResponse> getLessonVideo(String lessonId) async {
    try {
      final response = await _api.fetchData(
        '/lessons/$lessonId/video',
        method: ApiMethod.GET,
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }
}
