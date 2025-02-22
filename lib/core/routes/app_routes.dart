import 'package:flutter/material.dart';
import '../../views/home/home_view.dart';
import '../../views/auth/login_view.dart';
import '../../views/onboarding/onboarding_view.dart';

class AppRoutes {
  // Route names
  static const String login = '/login';
  static const String home = '/home';
  static const String onboarding = '/onboarding';
  // Route map
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      onboarding: (context) => const OnboardingView(),
      login: (context) => const LoginView(),
      home: (context) => const HomeView(),
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
