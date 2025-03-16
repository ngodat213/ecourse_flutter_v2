import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecourse_flutter_v2/core/base/base_view.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_image.dart';
import 'package:ecourse_flutter_v2/models/course_model.dart';
import 'package:ecourse_flutter_v2/view_models/my_profile_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyCourseView extends BaseView<MyProfileVM> {
  const MyCourseView({super.key});

  @override
  MyProfileVM createViewModel(
    BuildContext context,
    Map<String, dynamic>? arguments,
  ) {
    return MyProfileVM(context);
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, MyProfileVM vm) {
    return AppBar(backgroundColor: AppColor.background);
  }

  @override
  Widget buildView(BuildContext context, MyProfileVM viewModel) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'my_courses'.tr(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 18.sp,
              ),
            ),
            Text(
              '${viewModel.userProfile?.user?.enrolledCourses?.length} ${'courses_enrolled'.tr()}',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 10.sp,
              ),
            ),
            SizedBox(height: 32.h),

            SizedBox(
              height: 1.sh,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return _myCourseWidget(
                    context,
                    viewModel.userProfile?.user?.enrolledCourses?[index] ??
                        CourseModel(),
                  );
                },
                itemCount:
                    viewModel.userProfile?.user?.enrolledCourses?.length ?? 0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card _myCourseWidget(BuildContext context, CourseModel course) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Container(
        width: 1.sw,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColor.cardColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        course.thumnail?.url ?? '',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                SizedBox(
                  width: 1.sw - 50.w - 16.w - 32.w - 8.w - 32.w - 24.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.title ?? '',
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp,
                        ),
                      ),
                      Text(
                        '${course.instructor?.firstName} ${course.instructor?.lastName}',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16.w),
                SvgPicture.asset(AppImage.svgMore, width: 16.w, height: 16.h),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              'Overall progress 99%',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 10.sp,
              ),
            ),
            LinearProgressIndicator(
              value: 0.99,
              color: AppColor.primary,
              backgroundColor: AppColor.border,
            ),
          ],
        ),
      ),
    );
  }
}
