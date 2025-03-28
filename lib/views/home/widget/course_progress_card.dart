import 'package:easy_localization/easy_localization.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_image.dart';
import 'package:ecourse_flutter_v2/core/routes/app_routes.dart';
import 'package:ecourse_flutter_v2/core/widgets/buttons/see_all_button.dart';
import 'package:ecourse_flutter_v2/app/data/models/course_model.dart';
import 'package:ecourse_flutter_v2/app/data/models/course_progress_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CourseProgressCard extends StatelessWidget {
  const CourseProgressCard({
    super.key,
    required this.enrolledCourses,
    required this.courseProgress,
  });
  final List<CourseModel> enrolledCourses;
  final List<CourseProgressModel>? courseProgress;

  @override
  Widget build(BuildContext context) {
    if (enrolledCourses.isEmpty) {
      return Container();
    }

    return Column(
      children: [
        SeeAllButton(title: 'inprogress'.tr(), onSeeAll: () {}),
        SizedBox(
          height: 116.h,
          child: Align(
            alignment: Alignment.centerLeft,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                if (courseProgress != null) {
                  final progress = courseProgress!.firstWhere(
                    (element) => element.courseId == enrolledCourses[index].sId,
                    orElse:
                        () => CourseProgressModel(
                          courseId: enrolledCourses[index].sId!,
                          progress: 0,
                        ),
                  );

                  return ProgressCourseCard(
                    course: enrolledCourses[index],
                    courseProgress: progress,
                  );
                }
                return Container();
              },
              itemCount: enrolledCourses.length,
            ),
          ),
        ),
      ],
    );
  }
}

class ProgressCourseCard extends StatelessWidget {
  const ProgressCourseCard({
    super.key,
    required this.course,
    required this.courseProgress,
  });
  final CourseModel course;
  final CourseProgressModel courseProgress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppRoutes.push(
          context,
          AppRoutes.courseLearn,
          arguments: course.toJson(),
        );
      },
      child: Card(
        elevation: 2,
        margin: EdgeInsets.only(left: 16.w, bottom: 16.h),
        color: AppColor.cardColor,
        child: Container(
          width: 0.6.sw,
          height: 100.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course.title ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    AppImage.svgProfile,
                    width: 8.w,
                    height: 8.h,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '${course.instructor?.firstName} ${course.instructor?.lastName}',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Progress',
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${(courseProgress.progress * 100).toInt()}%',
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  LinearProgressIndicator(
                    value: courseProgress.progress,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(AppColor.primary),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                  SizedBox(height: 8.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
