import 'package:ecourse_flutter_v2/views/auth/forget_pw_view.dart';
import 'package:ecourse_flutter_v2/views/auth/verify_otp_view.dart';
import 'package:ecourse_flutter_v2/views/course/course_detail_view.dart';
import 'package:ecourse_flutter_v2/views/exam/exam_detail_view.dart';
import 'package:ecourse_flutter_v2/views/exam/exam_taking_view.dart';
import 'package:ecourse_flutter_v2/views/splash/splash_view.dart';
import 'package:flutter/material.dart';
import '../../views/home/home_view.dart';
import '../../views/auth/login_view.dart';
import '../../views/onboarding/onboarding_view.dart';

class AppRoutes {
  // Route names
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String onboarding = '/onboarding';
  static const String verifyOtp = '/verify-otp';
  static const String forgetPw = '/forget-pw';
  static const String courseDetail = '/course-detail';
  static const String examDetail = '/exam-detail';
  static const String examTaking = '/exam-taking';
  // Route map
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashView(),
      onboarding: (context) => const OnboardingView(),
      login: (context) => const LoginView(),
      home: (context) => const HomeView(),
      verifyOtp: (context) => const VerifyOtpView(),
      forgetPw: (context) => const ForgetPwView(),
      courseDetail: (context) => const CourseDetailView(),
      examDetail: (context) => const ExamDetailView(),
      examTaking: (context) => const ExamTakingView(),
    };
  }

  // Navigation methods
  static Future<T?> push<T>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  static Future<T?> pushReplacement<T>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushReplacementNamed(
      context,
      routeName,
      arguments: arguments,
    );
  }

  static Future<T?> pushAndRemoveUntil<T>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushNamedAndRemoveUntil(
      context,
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  static void pop<T>(BuildContext context, [T? result]) {
    Navigator.pop(context, result);
  }
}
