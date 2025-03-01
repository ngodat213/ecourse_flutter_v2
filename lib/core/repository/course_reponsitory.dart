import 'package:ecourse_flutter_v2/core/config/app_config.dart';
import 'package:ecourse_flutter_v2/core/services/base_api.dart';

class CourseRepository {
  final BaseAPI _baseAPI = BaseAPI();
  Future<ApiResponse> getCourses() async {
    final response = await _baseAPI.fetchData(
      AppConfig.courses,
      method: ApiMethod.GET,
    );

    return ApiResponse.fromResponse(response.data);
  }
}
