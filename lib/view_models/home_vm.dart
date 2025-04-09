import 'package:ecourse_flutter_v2/core/routes/app_routes.dart';
import 'package:ecourse_flutter_v2/app/data/models/course_progress_model.dart';
import 'package:ecourse_flutter_v2/app/data/models/user_profile.dart';
import 'package:ecourse_flutter_v2/app/data/models/course_model.dart';
import 'package:ecourse_flutter_v2/app/data/models/user_progress_model.dart';
import 'package:ecourse_flutter_v2/app/data/repositories/course_repository_imp.dart';
import 'package:ecourse_flutter_v2/app/data/repositories/user_progress_repository_impl.dart';
import 'package:ecourse_flutter_v2/view_models/user_vm.dart';
import 'package:provider/provider.dart';

import '../core/base/base_view_model.dart';

class HomeVM extends BaseVM {
  final CourseRepositoryImpl _courseRepository = CourseRepositoryImpl();
  final UserProgressRepositoryImpl _progressRepository =
      UserProgressRepositoryImpl();

  int carouselIndex = 0;
  String? userRole;
  UserProfile? userProfile;
  // Popular courses state
  final List<CourseModel> popularCourses = [];
  final List<CourseProgressModel> courseProgress = [];
  bool _isLoadingCourses = false;
  String? _courseError;

  // Getters
  bool get isLoadingCourses => _isLoadingCourses;
  String? get courseError => _courseError;

  HomeVM(super.context) {
    _initFromSharedPrefs();
  }

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
    _initFromSharedPrefs();
    _getCourseProgress();
    _loadPopularCourses();
    notifyListeners();
  }

  void changeCarouselIndex(int index) {
    carouselIndex = index;
    notifyListeners();
  }

  void redirectToCart() {
    AppRoutes.push(context, AppRoutes.cart);
  }

  void redirectToNotification() {
    AppRoutes.push(context, AppRoutes.notification);
  }

  Future<void> _getCourseProgress() async {
    try {
      if (userProfile?.user?.enrolledCourses != null) {
        // Clear courseProgress trước khi thêm mới
        courseProgress.clear();

        for (var course in userProfile!.user!.enrolledCourses ?? []) {
          final response = await _progressRepository.getCourseProgress(
            course.sId!,
          );
          if (response.allGood) {
            int finishedLesson = 0;
            for (var progress in response.body) {
              final progressModel = UserProgressModel.fromJson(progress);
              if (progressModel.status == 'completed') {
                finishedLesson++;
              }
            }
            courseProgress.add(
              CourseProgressModel(
                courseId: course.sId!,
                progress: finishedLesson / (course.lessons?.length ?? 1),
              ),
            );
          }
        }
        notifyListeners();
      }
    } catch (e) {
      setError(e.toString());
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
        popularCourses.clear();
        for (var e in response.body['data']) {
          popularCourses.add(CourseModel.fromJson(e));
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
