import 'package:ecourse_flutter_v2/core/services/base_api.dart';

abstract class LessonRepository {
  Future<ApiResponse> getLessons(String courseId);
  Future<ApiResponse> getLessonById(String lessonId);
  Future<ApiResponse> getLessonVideo(String lessonId);
}
