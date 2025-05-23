import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_image.dart';
import 'package:ecourse_flutter_v2/core/widgets/smart_image.dart';
import 'package:ecourse_flutter_v2/services/streak_service.dart';
import 'package:ecourse_flutter_v2/view_models/learning_streak_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class UserStreak extends StatelessWidget {
  const UserStreak({super.key, required this.currentStreak});
  final int currentStreak;

  @override
  Widget build(BuildContext context) {
    return Consumer<LearningStreakVM>(
      builder: (context, vm, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'Start a weekly streak',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 18.sp,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'One ring down! Now, watch your course(s)',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Stack(
              children: [
                Center(
                  child: SizedBox(
                    width: 100.w,
                    height: 100.w,
                    child: CircularProgressIndicator(
                      value:
                          vm.watchTimeInMinutes /
                          (StreakService.TIME_LIMIT ~/ 60),
                      color: AppColor.primary,
                      backgroundColor: Colors.grey[300],
                    ),
                  ),
                ),
                Center(
                  child: SmartImage(
                    source: AppImage.imgStreak,
                    width: 100.w,
                    height: 100.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            Text(
              '$currentStreak days',
              style: Theme.of(
                context,
              ).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              'Current streak',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 10.sp,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${vm.watchTimeInMinutes}/${StreakService.TIME_LIMIT ~/ 60} Course minutes',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 10.sp,
                  ),
                ),
                Text(
                  'Current streak',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
