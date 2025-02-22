import '../core/services/api_service.dart';
import '../models/user.dart';

class HomeService {
  final ApiService _apiService;

  HomeService(this._apiService);

  Future<List<User>> getUsers() async {
    try {
      final response = await _apiService.get('/users');
      return (response.data as List)
          .map((json) => User.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch users');
    }
  }
}
