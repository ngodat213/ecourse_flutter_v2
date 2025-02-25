import 'package:ecourse_flutter_v2/core/repository/user_repository.dart';
import 'package:ecourse_flutter_v2/models/user_profile.dart';

import '../core/base/base_view_model.dart';

class HomeVM extends BaseVM {
  final UserRepository _userRepository = UserRepository();

  UserProfile? userProfile;

  HomeVM(super.context);

  @override
  void onInit() {
    super.onInit();
    getUser();
    notifyListeners();
  }

  Future<void> getUser() async {
    setLoading(true);
    final response = await _userRepository.getUserProfile();

    if (response.allGood) {
      userProfile = UserProfile.fromJson(response.body);
    }
    setLoading(false);
  }
}
