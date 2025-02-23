import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecourse_flutter_v2/core/base/base_view.dart';
import 'package:ecourse_flutter_v2/core/base/base_view_model.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import '../../view_models/onboarding_vm.dart';

class OnboardingView extends BaseView<OnboardingVM> {
  const OnboardingView({super.key});

  @override
  OnboardingVM createViewModel(BuildContext context) {
    return OnboardingVM(context);
  }

  @override
  Widget buildView(BuildContext context, OnboardingVM viewModel) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          controller: viewModel.pageController,
          itemCount: viewModel.onboardingList.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _buildOnboardingItem(
              context,
              viewModel.onboardingList[index],
              viewModel,
            );
          },
        ),
      ),
    );
  }

  Widget _buildOnboardingItem(
    BuildContext context,
    Onboarding onboarding,
    OnboardingVM viewModel,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Skip button
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                viewModel.skipOnboarding();
              },
              child: const Text("Skip"),
            ),
          ),
          Image.asset(onboarding.image),
          const SizedBox(height: 32),
          Text(
            onboarding.title,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            onboarding.description,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 32),
          DotsIndicator(
            dotsCount: viewModel.onboardingList.length,
            position: viewModel.pageController.page?.toDouble() ?? 0,
            animationDuration: const Duration(milliseconds: 300),
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeSize: const Size(30.0, 9.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
          CustomElevatedButton(
            context: context,
            onPressed: () {
              viewModel.nextOnboarding();
            },
            text:
                viewModel.pageController.page ==
                        viewModel.onboardingList.length - 1
                    ? "Get Started"
                    : "Next",
          ),
        ],
      ),
    );
  }
}
