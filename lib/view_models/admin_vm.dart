import 'package:ecourse_flutter_v2/core/base/base_view_model.dart';
import 'package:ecourse_flutter_v2/models/course.dart';
import 'package:ecourse_flutter_v2/repositories/course_repository.dart';
import 'package:flutter/material.dart';

class AdminVM extends BaseVM {
  AdminVM(super.context);

  final CourseRepository _courseRepository = CourseRepository();

  // Data
  List<Course> courseList = [];
  List<DataRow> rowCourseList = [];
  @override
  void onInit() {
    getCourses();
  }

  Future<void> getCourses() async {
    setLoading(true);
    final response = await _courseRepository.getCourses();
    if (response.allGood) {
      for (var e in response.body['data']) {
        courseList.add(Course.fromJson(e));
        rowCourseList.add(Course.toRow(Course.fromJson(e)));
      }
      notifyListeners();
    }
    setLoading(false);
  }
}
