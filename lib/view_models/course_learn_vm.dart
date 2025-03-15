import 'package:ecourse_flutter_v2/core/base/base_view_model.dart';
import 'package:ecourse_flutter_v2/models/course_model.dart';
import 'package:ecourse_flutter_v2/repositories/course_repository.dart';

class CourseLearnVM extends BaseVM {
  final CourseRepository _courseRepository = CourseRepository();

  CourseLearnVM(super.context, this.course) {
    getCourse(course?.sId ?? '');
  }

  CourseModel? course;

  Future<void> getCourse(String courseId) async {
    setLoading(true);
    final response = await _courseRepository.getCourseById(courseId);
    if (response.allGood) {
      CourseModel course = CourseModel.fromJson(response.body);
      this.course = course;
      notifyListeners();
    }
    setLoading(false);
  }
}
