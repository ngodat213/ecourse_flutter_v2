import 'package:ecourse_flutter_v2/core/base/base_view_model.dart';
import 'package:ecourse_flutter_v2/core/routes/app_routes.dart';
import 'package:ecourse_flutter_v2/app/data/models/course_model.dart';
import 'package:ecourse_flutter_v2/app/data/models/teacher_model.dart';
import 'package:ecourse_flutter_v2/app/data/repositories/category_repository_impl.dart';
import 'package:ecourse_flutter_v2/app/data/repositories/course_repository_imp.dart';
import 'package:ecourse_flutter_v2/app/data/repositories/user_repository_impl.dart';
import 'package:ecourse_flutter_v2/view_models/category_model.dart';

class ExploreVM extends BaseVM {
  final UserRepositoryImpl _userRepository = UserRepositoryImpl();
  final CourseRepositoryImpl _courseRepository = CourseRepositoryImpl();
  final CategoryRepositoryImpl _categoryRepository = CategoryRepositoryImpl();
  ExploreVM(super.context);

  final List<TeacherModel> teachers = [];
  final List<CourseModel> courses = [];
  final List<CategoryModel> categories = [];
  final List<CourseModel> coursesOnSeeAll = [];
  bool onSeeAll = false;

  @override
  void onInit() {
    _getCategories();
    _getTeachers();
    _loadCourses();
  }

  void redirectToCart() {
    AppRoutes.push(context, AppRoutes.cart);
  }

  void setOnSeeAll(List<CourseModel> courses) {
    onSeeAll = !onSeeAll;
    if (onSeeAll) {
      coursesOnSeeAll.addAll(courses);
    } else {
      coursesOnSeeAll.clear();
    }
    notifyListeners();
  }

  Future<void> _getCategories() async {
    try {
      final response = await _categoryRepository.getCategories();
      if (response.allGood) {
        categories.clear();
        for (var e in response.body) {
          categories.add(CategoryModel.fromJson(e, includeCourses: true));
        }
        notifyListeners();
      } else {
        setError(response.message);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _getTeachers() async {
    try {
      final response = await _userRepository.getTeachers();
      if (response.allGood) {
        teachers.clear();
        for (var teacher in response.body['data']) {
          teachers.add(TeacherModel.fromJson(teacher));
        }
        notifyListeners();
      } else {
        setError(response.message);
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
        courses.clear();
        for (var e in response.body['data']) {
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

  Future<List<CourseModel>> searchCourses(String query) async {
    try {
      final filters = _courseRepository.buildFilters(
        status: 'published',
        search: query,
        limit: 10,
      );

      final response = await _courseRepository.getCourses(filters);

      if (response.allGood) {
        final List<CourseModel> searchResults = [];
        for (var e in response.body['data']) {
          searchResults.add(CourseModel.fromJson(e));
        }
        return searchResults;
      } else {
        setError(response.message);
        return [];
      }
    } catch (e) {
      setError(e.toString());
      return [];
    }
  }
}
