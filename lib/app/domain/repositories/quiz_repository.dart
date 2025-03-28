import 'package:ecourse_flutter_v2/core/services/base_api.dart';

abstract class QuizRepository {
  Future<ApiResponse> startQuiz(String examId);
  Future<ApiResponse> submitQuiz(String examId, Map<String, String> answers);
}
