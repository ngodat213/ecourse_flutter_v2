import 'package:easy_localization/easy_localization.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            AppImage.svgLogo,
            width: 50.w,
            height: 50.w,
            colorFilter: ColorFilter.mode(AppColor.primary, BlendMode.srcIn),
          ),
          SizedBox(width: 8.w),
          Text(
            'Brainy'.tr(),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 30.sp,
              color: AppColor.primary,
            ),
          ),
        ],
      ),
    );
  }
}
