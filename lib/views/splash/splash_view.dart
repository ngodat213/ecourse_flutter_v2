import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/base/base_view.dart';
import 'splash_view_model.dart';

class SplashView extends BaseView<SplashVM> {
  const SplashView({super.key});

  @override
  SplashVM createViewModel(BuildContext context) {
    return SplashVM(context);
  }

  @override
  Widget buildView(BuildContext context, SplashVM viewModel) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          'assets/svgs/logo.svg',
          width: 100,
          height: 100,
          colorFilter: ColorFilter.mode(AppColor.primary, BlendMode.srcIn),
        ),
      ),
    );
  }
}
