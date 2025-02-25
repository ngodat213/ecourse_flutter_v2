import 'package:ecourse_flutter_v2/core/base/base_view_model.dart';
import 'package:ecourse_flutter_v2/core/services/shared_prefs.dart';
import 'package:ecourse_flutter_v2/core/repository/user_repository.dart';
import 'package:ecourse_flutter_v2/models/user_profile.dart';

class UserVM extends BaseVM {
  final UserRepository _userRepository = UserRepository();

  UserVM(super.context);

  Future<void> getUser() async {
    setLoading(true);
    final response = await _userRepository.getUserProfile();

    if (response.allGood) {
      final userProfile = UserProfile.fromJson(response.body);
      await SharedPrefs.setUser(userProfile);
    }
    setLoading(false);
  }
}
