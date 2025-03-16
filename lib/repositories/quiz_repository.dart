import 'package:ecourse_flutter_v2/core/services/base_api.dart';

class QuizRepository {
  final BaseAPI _api;

  QuizRepository({BaseAPI? api}) : _api = api ?? BaseAPI();

  Future<ApiResponse> startQuiz(String examId) async {
    try {
      final response = await _api.fetchData(
        '/exams/$examId/start',
        method: ApiMethod.POST,
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  Future<ApiResponse> submitQuiz(
    String examId,
    Map<String, String> answers,
  ) async {
    try {
      final response = await _api.fetchData(
        '/exams/$examId/submit',
        method: ApiMethod.POST,
        body: {'answers': answers},
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }
}
