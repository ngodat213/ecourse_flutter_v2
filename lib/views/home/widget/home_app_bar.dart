import 'package:ecourse_flutter_v2/core/config/app_constants.dart';
import 'package:ecourse_flutter_v2/core/widgets/smart_image.dart';
import 'package:ecourse_flutter_v2/view_models/home_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key, required this.vm});
  final HomeVM vm;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SmartImage(
          source:
              vm.userProfile?.user?.profilePicture ??
              AppConstants.defaultAvatar,
          width: 40.w,
          height: 40.h,
          fit: BoxFit.cover,
          borderRadius: BorderRadius.circular(20.r),
        ),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, ${vm.userProfile?.user?.firstName ?? ''} ${vm.userProfile?.user?.lastName ?? ''}',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            Text(
              vm.userProfile?.user?.level ?? '',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ],
    );
  }
}
