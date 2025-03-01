import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_image.dart';
import 'package:ecourse_flutter_v2/core/routes/app_routes.dart';
import 'package:ecourse_flutter_v2/utils/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class PopularCard extends StatelessWidget {
  const PopularCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppRoutes.push(context, AppRoutes.courseDetail),
      child: Container(
        height: ResponsiveLayout.isDesktop(context) ? 0.1.sw : 0.3.sw,
        width: ResponsiveLayout.isDesktop(context) ? 0.3.sw : 1.sw,
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: AppColor.cardColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            Container(
              width: ResponsiveLayout.isDesktop(context) ? 0.1.sw : 0.3.sw,
              height: ResponsiveLayout.isDesktop(context) ? 0.1.sw : 0.3.sw,
              decoration: BoxDecoration(
                color: AppColor.border.withOpacity(0.5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  bottomLeft: Radius.circular(16.r),
                ),
              ),
              child: Image.asset(
                'assets/images/home/computer.png',
                height: 0.1.sw,
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.w),
              height: ResponsiveLayout.isDesktop(context) ? 0.1.sw : 0.3.sw,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Computer Science',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '25 Lessons',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '4hr 30min',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColor.primary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                ],
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.all(12.h),
              decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.circular(100.r),
              ),
              child: SvgPicture.asset(
                AppImage.svgPlay,
                height: 12.h,
                width: 12.w,
                color: AppColor.accent,
              ),
            ),
            SizedBox(width: 16.w),
          ],
        ),
      ),
    );
  }
}
