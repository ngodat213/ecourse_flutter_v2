import 'package:flutter/material.dart';
import '../services/shared_prefs.dart';
import 'app_routes.dart';

class RouteGuard extends NavigatorObserver {
  final List<String> publicRoutes = [
    AppRoutes.splash,
    AppRoutes.login,
    AppRoutes.onboarding,
    AppRoutes.home,
    AppRoutes.courseDetail,
    AppRoutes.verifyOtp,
    AppRoutes.forgetPw,
    AppRoutes.examDetail,
    AppRoutes.examTaking,
    AppRoutes.courseLearn,
    AppRoutes.adminDashboard,
    AppRoutes.profile,
    AppRoutes.myCourse,
    AppRoutes.myCertificates,
  ];

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _checkAuth(route);
    super.didPush(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute != null) {
      _checkAuth(newRoute);
    }
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  void _checkAuth(Route<dynamic> route) {
    final routeName = route.settings.name;
    if (routeName == null) return;

    final token = SharedPrefs.getToken();
    final isPublicRoute = publicRoutes.contains(routeName);

    if (token == null && !isPublicRoute) {
      navigator?.pushNamedAndRemoveUntil(
        AppRoutes.onboarding,
        (route) => false,
      );
    }
  }
}
