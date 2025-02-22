import 'package:ecourse_flutter_v2/core/base/base_view_model.dart';
import 'package:ecourse_flutter_v2/core/routes/app_routes.dart';
import 'package:ecourse_flutter_v2/core/services/shared_prefs.dart';
import 'package:flutter/material.dart';

class OnboardingVM extends BaseVM {
  final BuildContext context;
  final PageController pageController = PageController();
  OnboardingVM(this.context);

  Future<void> skipOnboarding() async {
    await SharedPrefs.setBool('is_onboarding_skipped', true);
    AppRoutes.pushAndRemoveUntil(context, AppRoutes.login);
  }

  Future<void> nextOnboarding() async {
    if (pageController.page == onboardingList.length - 1) {
      await skipOnboarding();
      return;
    }
    await pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }

  final List<Onboarding> onboardingList = [
    Onboarding(
      image: 'assets/images/onboarding/onboarding1.png',
      title: 'First See Learning',
      description: 'Forget about a for of paper all knowledge in one leaming!',
    ),
    Onboarding(
      image: 'assets/images/onboarding/onboarding2.png',
      title: 'Connect With Everyone',
      description:
          'Always keep in touch with your tutor & friend let\'s get connected!',
    ),
    Onboarding(
      image: 'assets/images/onboarding/onboarding3.png',
      title: 'Always Fascinated Learning',
      description:
          'Anywhere, anytime. The time is at your discretion so study whenever you want.',
    ),
  ];
}

class Onboarding {
  final String image;
  final String title;
  final String description;

  Onboarding({
    required this.image,
    required this.title,
    required this.description,
  });
}
