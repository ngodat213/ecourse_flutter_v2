import 'package:ecourse_flutter_v2/app/data/models/user_progress_model.dart';
import 'package:ecourse_flutter_v2/core/services/base_api.dart';

abstract class UserProgressRepository {
  Future<ApiResponse> createContentProgress(String courseId, String contentId);
  Future<ApiResponse> getCourseProgress(String courseId);
  Future<ApiResponse> getLessonContentsProgress(String lessonId);
  Future<ApiResponse> getContentProgress(String contentId);
  Future<ApiResponse> updateContentProgress(String contentId, String status);
  Future<ApiResponse> markContentComplete(String contentId);
  List<UserProgressModel> parseProgressList(Map<String, dynamic> body);
  UserProgressModel? parseProgress(Map<String, dynamic> body);
}
