import 'package:ecourse_flutter_v2/core/routes/app_routes.dart';
import 'package:ecourse_flutter_v2/models/user_profile.dart';
import 'package:ecourse_flutter_v2/models/course_model.dart';
import 'package:ecourse_flutter_v2/repositories/course_repository.dart';
import 'package:ecourse_flutter_v2/view_models/user_vm.dart';
import 'package:provider/provider.dart';

import '../core/base/base_view_model.dart';

class HomeVM extends BaseVM {
  final CourseRepository _courseRepository;

  int carouselIndex = 0;
  String? userRole;
  UserProfile? userProfile;
  // Popular courses state
  final List<CourseModel> _popularCourses = [];
  bool _isLoadingCourses = false;
  String? _courseError;

  // Getters
  List<CourseModel> get popularCourses => _popularCourses;
  bool get isLoadingCourses => _isLoadingCourses;
  String? get courseError => _courseError;

  HomeVM(super.context, {CourseRepository? courseRepository})
    : _courseRepository = courseRepository ?? CourseRepository();

  void _initFromSharedPrefs() {
    final userData = context.read<UserVM>().userProfile;
    if (userData != null) {
      try {
        userProfile = userData;
        userRole = userData.user?.role;
      } catch (e) {
        print('Error parsing user data: $e');
      }
    }
  }

  @override
  void onInit() {
    _loadPopularCourses();
    _initFromSharedPrefs();
    notifyListeners();
  }

  void changeCarouselIndex(int index) {
    carouselIndex = index;
    notifyListeners();
  }

  void redirectToAdmin() {
    if (userRole == 'admin') {
      AppRoutes.push(context, AppRoutes.adminDashboard);
    }
  }

  Future<void> _loadPopularCourses() async {
    try {
      _setLoadingCourses(true);

      // Build filters cho popular courses
      final filters = _courseRepository.buildFilters(
        status: 'published',
        limit: 2,
        sort: '-rating', // Sắp xếp theo rating giảm dần
      );

      final response = await _courseRepository.getCourses(filters);

      if (response.allGood) {
        for (var e in response.body) {
          _popularCourses.add(CourseModel.fromJson(e));
        }
        notifyListeners();
        _setCourseError(null);
      } else {
        _setCourseError(response.message);
      }
    } catch (e) {
      _setCourseError(e.toString());
    } finally {
      _setLoadingCourses(false);
    }
  }

  // State management methods
  void _setLoadingCourses(bool value) {
    _isLoadingCourses = value;
    notifyListeners();
  }

  void _setCourseError(String? value) {
    _courseError = value;
    notifyListeners();
  }
}
