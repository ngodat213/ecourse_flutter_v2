import 'package:animated_read_more_text/animated_read_more_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/app/data/models/course_model.dart';
import 'package:ecourse_flutter_v2/views/course_learn/widget/instructor_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OverviewTab extends StatelessWidget {
  const OverviewTab({super.key, required this.course});
  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          // ClaimCerificationCard(progress: course.progressPercentage),
          SizedBox(height: 16.h),
          Text(
            'description'.tr(),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
            ),
          ),
          AnimatedReadMoreText(
            course.description ?? '',
            maxLines: 6,
            textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColor.textSecondary,
              fontSize: 10.sp,
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'about_instructor'.tr(),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
            ),
          ),
          InstructorInfoWidget(instructor: course.instructor!),
          AnimatedReadMoreText(
            course.instructor?.about ?? '',
            maxLines: 6,
            textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColor.textSecondary,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}
