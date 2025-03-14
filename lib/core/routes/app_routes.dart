import 'package:ecourse_flutter_v2/views/admin/admin_view.dart';
import 'package:ecourse_flutter_v2/views/cart/cart_view.dart';
import 'package:ecourse_flutter_v2/views/forgot_pw/forget_pw_view.dart';
import 'package:ecourse_flutter_v2/views/verify_otp/verify_otp_view.dart';
import 'package:ecourse_flutter_v2/views/exam/exam_detail_view.dart';
import 'package:ecourse_flutter_v2/views/exam/exam_taking_view.dart';
import 'package:ecourse_flutter_v2/views/course_detail/course_detail_view.dart';
import 'package:ecourse_flutter_v2/views/course/course_learn_view.dart';
import 'package:ecourse_flutter_v2/views/my_profile/widget/my_certificates.dart';
import 'package:ecourse_flutter_v2/views/my_profile/widget/my_course.dart';
import 'package:ecourse_flutter_v2/views/my_profile/my_profile_view.dart';
import 'package:ecourse_flutter_v2/views/my_profile/teacher_profile_view.dart';
import 'package:ecourse_flutter_v2/views/splash/splash_view.dart';
import 'package:flutter/material.dart';
import '../../views/auth/login_view.dart';
import '../../views/onboarding/onboarding_view.dart';
import '../../views/main/main_view.dart';

class AppRoutes {
  // Route names
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String onboarding = '/onboarding';
  static const String verifyOtp = '/verify-otp';
  static const String forgetPw = '/forget-pw';
  static const String courseDetail = '/course-detail';
  static const String courseLearn = '/course-learn';
  static const String examDetail = '/exam-detail';
  static const String examTaking = '/exam-taking';
  static const String adminDashboard = '/admin-dashboard';
  static const String profile = '/profile';
  static const String teacherProfile = '/teacher-profile';
  static const String myCourse = '/my-course';
  static const String myCertificates = '/my-certificates';
  static const String cart = '/cart';
  // Route map
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashView(),
      onboarding: (context) => const OnboardingView(),
      login: (context) => const LoginView(),
      home: (context) => const MainView(),
      verifyOtp: (context) => const VerifyOtpView(),
      forgetPw: (context) => const ForgetPwView(),
      courseDetail: (context) => const CourseDetailView(),
      courseLearn: (context) => const CourseLearnView(),
      examDetail: (context) => const ExamDetailView(),
      examTaking: (context) => const ExamTakingView(),
      adminDashboard: (context) => const AdminView(),
      profile: (context) => const MyProfileView(),
      myCourse: (context) => const MyCourseView(),
      myCertificates: (context) => const MyCertificatesView(),
      teacherProfile: (context) => const TeacherProfileView(),
      cart: (context) => const CartView(),
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
