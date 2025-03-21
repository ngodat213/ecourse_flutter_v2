import 'package:animated_read_more_text/animated_read_more_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecourse_flutter_v2/core/base/base_view.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_constants.dart';
import 'package:ecourse_flutter_v2/core/config/app_image.dart';
import 'package:ecourse_flutter_v2/core/widgets/buttons/elevated_button.dart';
import 'package:ecourse_flutter_v2/core/widgets/smart_image.dart';
import 'package:ecourse_flutter_v2/models/teacher_model.dart';
import 'package:ecourse_flutter_v2/view_models/teacher_profile_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class TeacherProfileView extends BaseView<TeacherProfileVM> {
  const TeacherProfileView({super.key});

  @override
  TeacherProfileVM createViewModel(
    BuildContext context,
    Map<String, dynamic>? arguments,
  ) {
    final TeacherModel teacherProfile = TeacherModel.fromJson(arguments!);
    return TeacherProfileVM(context, teacherProfile: teacherProfile);
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, TeacherProfileVM vm) {
    return AppBar(
      title: Column(
        children: [
          Text(
            'profile'.tr(),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 18.sp,
            ),
          ),
        ],
      ),
      backgroundColor: AppColor.background,
    );
  }

  @override
  Widget buildView(BuildContext context, TeacherProfileVM viewModel) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 0.26.sh,
            width: 1.sw,
            child: Stack(
              children: [
                SmartImage(
                  source: AppImage.imageThumnail,
                  width: 1.sw,
                  height: 0.2.sh,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 0.15.sh,
                  left: 0.05.sw,
                  child: Container(
                    width: 0.25.sw,
                    height: 0.25.sw,
                    decoration: BoxDecoration(
                      color: AppColor.cardColor,
                      shape: BoxShape.circle,

                      border: Border.all(color: AppColor.background, width: 3),
                    ),
                    child: SmartImage(
                      source:
                          viewModel.teacherProfile?.profilePicture ??
                          AppConstants.defaultAvatar,
                      width: 0.25.sw,
                      height: 0.25.sw,
                      fit: BoxFit.cover,
                      isCircle: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${viewModel.teacherProfile?.firstName ?? ''} ${viewModel.teacherProfile?.lastName ?? ''}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                  ),
                ),
                Text(
                  viewModel.teacherProfile?.level ?? '',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColor.textSecondary,
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  viewModel.teacherProfile?.address ?? '',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColor.textSecondary,
                    fontSize: 10.sp,
                  ),
                ),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    Text(
                      '${viewModel.teacherProfile?.followersCount ?? 0} Followers, ',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColor.textSecondary,
                        fontSize: 10.sp,
                      ),
                    ),
                    Text(
                      'Work at ${viewModel.teacherProfile?.workingAt ?? ''}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColor.textSecondary,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Visibility(
                  visible: !viewModel.isInstructor(),
                  child: Row(
                    children: [
                      CustomElevatedButton(
                        height: 30.h,
                        context: context,
                        leading: Container(
                          padding: EdgeInsets.only(right: 3.w),
                          child: SvgPicture.asset(
                            AppImage.svgPlus,
                            color: AppColor.textPrimaryDark,
                          ),
                        ),
                        text: 'Follow',
                        textStyle: Theme.of(
                          context,
                        ).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColor.textPrimaryDark,
                          fontSize: 10.sp,
                        ),
                        onPressed: () {},
                      ),
                      SizedBox(width: 12.w),
                      CustomElevatedButton(
                        context: context,
                        height: 30.h,
                        backgroundColor: AppColor.background,
                        textStyle: Theme.of(
                          context,
                        ).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColor.textPrimary,
                          fontSize: 10.sp,
                        ),
                        text: 'More',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Container(width: 1.sw, height: 3.h, color: AppColor.border),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Text(
              'about_me'.tr(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 18.sp,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: AnimatedReadMoreText(
              viewModel.teacherProfile?.about ?? ' ',
              maxLines: 5,
              textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColor.textSecondary,
                fontSize: 10.sp,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          // _myCourse(context, viewModel),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  // Widget _myCourse(BuildContext context, TeacherProfileVM vm) {
  //   return Visibility(
  //     visible: vm.userProfile?.teachingCourses?.isNotEmpty ?? false,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Container(width: 1.sw, height: 3.h, color: AppColor.border),
  //         SeeAllWidget(
  //           title: 'my_courses'.tr(),
  //           onSeeAll: () {
  //             AppRoutes.push(context, AppRoutes.myCourse);
  //           },
  //         ),
  //         SizedBox(height: 16.h),
  //         // SizedBox(
  //         //   height: 252.h,
  //         //   child: ListView.builder(
  //         //     shrinkWrap: true,
  //         //     scrollDirection: Axis.horizontal,
  //         //     itemBuilder: (context, index) {
  //         //       return CourseCard(course: vm.userProfile?.user?.enrolledCourses?[index]);
  //         //     },
  //         //     itemCount: vm.userProfile?.user?.enrolledCourses?.length ?? 0,
  //         //   ),
  //         // ),
  //       ],
  //     ),
  //   );
  // }
}
