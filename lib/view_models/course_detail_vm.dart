import 'package:ecourse_flutter_v2/core/base/base_view_model.dart';
import 'package:ecourse_flutter_v2/models/course_model.dart';

class CourseDetailVM extends BaseVM {
  CourseDetailVM(super.context, {this.course});

  final CourseModel? course;
}
