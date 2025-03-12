import 'package:ecourse_flutter_v2/core/base/base_view_model.dart';
import 'package:ecourse_flutter_v2/models/teacher_model.dart';
import 'package:ecourse_flutter_v2/repositories/user_repository.dart';

class TeacherProfileVM extends BaseVM {
  TeacherProfileVM(super.context, {this.teacherProfile});

  final UserRepository _userRepository = UserRepository();

  final TeacherModel? teacherProfile;
  String? teacherId;

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
    // return teacherProfile?.sId == teacherId;
    return true;
  }
}
