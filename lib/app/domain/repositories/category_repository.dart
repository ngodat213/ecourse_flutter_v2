import 'package:ecourse_flutter_v2/core/services/base_api.dart';

abstract class CategoryRepository {
  Future<ApiResponse> getCategories();
}
