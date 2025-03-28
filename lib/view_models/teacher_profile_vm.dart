import 'package:ecourse_flutter_v2/core/base/base_view_model.dart';
import 'package:ecourse_flutter_v2/app/data/models/teacher_model.dart';
import 'package:ecourse_flutter_v2/app/data/models/user_profile.dart';
import 'package:ecourse_flutter_v2/view_models/user_vm.dart';
import 'package:provider/provider.dart';

class TeacherProfileVM extends BaseVM {
  TeacherProfileVM(super.context, {this.teacherProfile});

  final TeacherModel? teacherProfile;
  String? teacherId;
  UserProfile? get userProfile => context.read<UserVM>().userProfile;

  Future<void> getUserProfile() async {
    if (teacherId == null) {
      return;
    }
    setLoading(true);
    // try {
    //   final response = await _userRepository.getTeacherById(teacherId!);
    //   if (response.allGood) {
    //     teacherProfile = TeacherModel.fromJson(response.body);
    //     notifyListeners();
    //   } else {
    //     setError(response.message);
    //   }
    // } catch (e) {
    //   setError(e.toString());
    // } finally {
    //   setLoading(false);
    // }
  }

  bool isInstructor() {
    return teacherProfile?.sId == userProfile?.user?.sId;
  }
}
