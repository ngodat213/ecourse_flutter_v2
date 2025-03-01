import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppRoutes.push(context, AppRoutes.examDetail),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColor.cardColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColor.border, width: 1.w),
        ),
        child: Column(
          children: [
            Container(
              width: 75.w,
              height: 75.w,
              padding: EdgeInsets.all(8.h),
              decoration: BoxDecoration(
                color: AppColor.accent,
                borderRadius: BorderRadius.circular(100.r),
              ),
              child: Image.asset(
                'assets/images/home/flutter.png',
                height: 75.h,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              'Flutter',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            Text(
              '3 Courses',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColor.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
