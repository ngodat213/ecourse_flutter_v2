import 'package:ecourse_flutter_v2/core/config/app_config.dart';
import 'package:ecourse_flutter_v2/core/services/base_api.dart';

class UserRepository {
  final BaseAPI _baseAPI = BaseAPI();
  Future<ApiResponse> getUserProfile() async {
    final response = await _baseAPI.fetchData(
      AppConfig.userProfile,
      method: ApiMethod.get,
    );

    return ApiResponse.fromResponse(response.data);
  }
}
