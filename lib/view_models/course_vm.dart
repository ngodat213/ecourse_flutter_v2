import 'package:ecourse_flutter_v2/core/base/base_view_model.dart';
import 'package:ecourse_flutter_v2/core/repository/course_reponsitory.dart';
import 'package:ecourse_flutter_v2/models/course.dart';

class CourseVM extends BaseVM {
  CourseVM(super.context);
  final CourseRepository _courseRepository = CourseRepository();

  // Data
  List<Course> courseList = [];
}
