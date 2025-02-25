import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/routes/app_routes.dart';
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
        height: 0.3.sw,
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: AppColor.cardColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            Container(
              width: 0.3.sw,
              height: 0.3.sw,
              decoration: BoxDecoration(
                color: AppColor.border.withOpacity(0.5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  bottomLeft: Radius.circular(16.r),
                ),
              ),
              child: Image.asset(
                'assets/images/home/computer.png',
                height: 0.3.sw,
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.w),
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
                'assets/svgs/play.svg',
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
