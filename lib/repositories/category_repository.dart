import 'package:ecourse_flutter_v2/core/services/base_api.dart';

class CategoryRepository {
  final BaseAPI _api;

  CategoryRepository({BaseAPI? api}) : _api = api ?? BaseAPI();

  Future<ApiResponse> getCategories() async {
    try {
      final response = await _api.fetchData(
        '/categories',
        method: ApiMethod.GET,
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }
}
