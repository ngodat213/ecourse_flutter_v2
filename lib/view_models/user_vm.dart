import 'package:ecourse_flutter_v2/core/base/base_view_model.dart';
import 'package:ecourse_flutter_v2/app/data/models/user_profile.dart';

class UserVM extends BaseVM {
  UserVM(super.context);

  UserProfile? _userProfile;

  UserProfile? get userProfile => _userProfile;

  void setUserProfile(UserProfile newUserProfile) {
    _userProfile = newUserProfile;
    notifyListeners();
  }

  void clearUserProfile() {
    _userProfile = null;
    notifyListeners();
  }
}
