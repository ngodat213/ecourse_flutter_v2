import 'package:ecourse_flutter_v2/core/config/app_config.dart';
import 'package:ecourse_flutter_v2/core/services/base_api.dart';

class AuthRepository {
  Future<ApiResponse> login(String email, String password) async {
    final response = await BaseAPI().fetchData(
      AppConfig.login,
      method: ApiMethod.POST,
      body: {'email': email, 'password': password},
    );

    return ApiResponse.fromResponse(response.data);
  }

  Future<ApiResponse> register(
    String name,
    String email,
    String password,
    String passwordConfirmation,
  ) async {
    final response = await BaseAPI().fetchData(
      AppConfig.register,
      method: ApiMethod.POST,
      body: {'name': name, 'email': email, 'password': password},
    );

    return ApiResponse.fromResponse(response.data);
  }
}
