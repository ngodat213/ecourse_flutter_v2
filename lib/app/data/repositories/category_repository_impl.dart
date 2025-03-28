import 'package:ecourse_flutter_v2/app/domain/repositories/category_repository.dart';
import 'package:ecourse_flutter_v2/core/services/base_api.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final BaseAPI _api;

  CategoryRepositoryImpl({BaseAPI? api}) : _api = api ?? BaseAPI();

  @override
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
