import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_constants.dart';
import 'package:ecourse_flutter_v2/app/data/models/course_model.dart';
import 'package:ecourse_flutter_v2/app/data/models/lesson_model.dart';
import 'package:ecourse_flutter_v2/app/data/models/user_progress_model.dart';
import 'package:ecourse_flutter_v2/app/data/models/lesson_content_model.dart';
import 'package:ecourse_flutter_v2/views/course_learn/widget/content_tab.dart';
import 'package:ecourse_flutter_v2/views/course_learn/widget/overview_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseTabBar extends StatelessWidget {
  const CourseTabBar({
    super.key,
    required this.tabController,
    required this.lessons,
    required this.lessonProgress,
    required this.currentLessonContentId,
    required this.onContentSelected,
    required this.course,
  });

  final TabController tabController;
  final List<LessonModel> lessons;
  final List<UserProgressModel> lessonProgress;
  final Function(LessonContentModel) onContentSelected;
  final String currentLessonContentId;
  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
            controller: tabController,
            indicatorColor: AppColor.primary,
            dividerHeight: 1,
            padding: EdgeInsets.zero,
            isScrollable: true,
            labelPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w400,
              color: AppColor.secondary,
              fontSize: 13.sp,
            ),
            unselectedLabelStyle: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w400,
              color: AppColor.accent,
              fontSize: 13.sp,
            ),
            tabs: [Text('Content'), Text('Overview')],
          ),
          SizedBox(
            height: 1.sw,
            child: Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  ContentTab(
                    lessons: lessons,
                    lessonProgress: lessonProgress,
                    currentProgressId: currentLessonContentId,
                    onContentSelected: (content) => onContentSelected(content),
                  ),
                  OverviewTab(course: course),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DiscussionTabBar extends StatelessWidget {
  const DiscussionTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundImage: AssetImage(AppConstants.defaultAvatar),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                margin: EdgeInsets.only(left: 6.w),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.accent),
                  color: AppColor.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.r),
                    bottomRight: Radius.circular(8.r),
                    topRight: Radius.circular(8.r),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Discussion $index',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 1.sw - 107.w,
                      child: Text(
                        'Eu et magna nulla ipsum ad commodo. Proident proident do tempor consequat velit dolore anim non do cupidatat ad tempor. Eiusmod et veniam mollit minim eu magna exercitation do reprehenderit mollit.',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(fontSize: 12.sp),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
