import 'package:ecourse_flutter_v2/core/base/base_view_model.dart';
import 'package:ecourse_flutter_v2/models/course_model.dart';
import 'package:ecourse_flutter_v2/models/teacher_model.dart';
import 'package:ecourse_flutter_v2/repositories/course_repository.dart';
import 'package:ecourse_flutter_v2/repositories/user_repository.dart';

class ExploreVM extends BaseVM {
  final UserRepository _userRepository;
  final CourseRepository _courseRepository;
  ExploreVM(super.context)
    : _userRepository = UserRepository(),
      _courseRepository = CourseRepository();

  final List<TeacherModel> teachers = [];
  final List<CourseModel> courses = [];
  @override
  void onInit() {
    _getTeachers();
    _loadCourses();
  }

  Future<void> _getTeachers() async {
    try {
      final response = await _userRepository.getTeachers();
      if (response.allGood) {
        for (var teacher in response.body['data']) {
          teachers.add(TeacherModel.fromJson(teacher));
        }
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _loadCourses() async {
    try {
      // Build filters cho popular courses
      final filters = _courseRepository.buildFilters(
        status: 'published',
        limit: 5,
        sort: '-rating',
      );

      final response = await _courseRepository.getCourses(filters);

      if (response.allGood) {
        for (var e in response.body) {
          courses.add(CourseModel.fromJson(e));
        }
        notifyListeners();
      } else {
        setError(response.message);
      }
    } finally {
      setLoading(false);
    }
  }
}
