import '../core/base/base_view_model.dart';
import '../models/user.dart';
import '../services/home_service.dart';

class HomeVM extends BaseVM {
  final HomeService _homeService;
  List<User> users = [];

  HomeVM(this._homeService);

  Future<void> loadUsers() async {
    try {
      setLoading(true);
      users = await _homeService.getUsers();
      setLoading(false);
    } catch (e) {
      setError(e.toString());
    }
  }
}
