import 'package:ecourse_flutter_v2/app/data/models/user_profile.dart';
import 'package:ecourse_flutter_v2/core/base/base_view_model.dart';
import 'package:ecourse_flutter_v2/view_models/user_vm.dart';
import 'package:provider/provider.dart';

class StreakVM extends BaseVM {
  StreakVM(super.context);

  UserProfile? get userProfile => context.read<UserVM>().userProfile;
}
