import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/widgets/elevated_button.dart';
import 'package:ecourse_flutter_v2/utils/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ResponsiveLayout.isDesktop(context) ? 0.2.sw : 1.sw,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColor.cardColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Image.asset(
              'assets/images/home/banner.png',
              height: 130.h,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '20/30 Lessons',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColor.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 32.h),
              Text(
                'Online Virtual Course',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 8.h),
              Text(
                '1000+ Students',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColor.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 12.h),
              CustomElevatedButton(
                context: context,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                text: 'Enroll Now',
                textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColor.accent,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
