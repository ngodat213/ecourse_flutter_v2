import 'package:animated_read_more_text/animated_read_more_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecourse_flutter_v2/core/base/base_view.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_constants.dart';
import 'package:ecourse_flutter_v2/core/config/app_image.dart';
import 'package:ecourse_flutter_v2/core/routes/app_routes.dart';
import 'package:ecourse_flutter_v2/core/widgets/buttons/elevated_button.dart';
import 'package:ecourse_flutter_v2/core/widgets/buttons/see_all_button.dart';
import 'package:ecourse_flutter_v2/core/widgets/smart_image.dart';
import 'package:ecourse_flutter_v2/models/course_model.dart';
import 'package:ecourse_flutter_v2/view_models/my_profile_vm.dart';
import 'package:ecourse_flutter_v2/views/explore/explore_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MyProfileView extends BaseView<MyProfileVM> {
  const MyProfileView({super.key});

  @override
  MyProfileVM createViewModel(
    BuildContext context,
    Map<String, dynamic>? arguments,
  ) {
    return MyProfileVM(context);
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, MyProfileVM vm) {
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
  Widget buildView(BuildContext context, MyProfileVM viewModel) {
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
                      image: DecorationImage(
                        image: AssetImage(AppConstants.defaultAvatar),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(color: AppColor.background, width: 3),
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
                  '${viewModel.userProfile?.user?.firstName} ${viewModel.userProfile?.user?.lastName}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                  ),
                ),
                Text(
                  viewModel.userProfile?.user?.level ?? '',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColor.textSecondary,
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  viewModel.userProfile?.user?.address ?? '',
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
                      '${viewModel.userProfile?.user?.followersCount} Followers, ',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColor.textSecondary,
                        fontSize: 10.sp,
                      ),
                    ),
                    Text(
                      'Work at ${viewModel.userProfile?.user?.workingAt}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColor.textSecondary,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
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
              viewModel.userProfile?.user?.about ?? ' ',
              maxLines: 5,
              textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColor.textSecondary,
                fontSize: 10.sp,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          _myCourse(context, viewModel),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  Widget _myCourse(BuildContext context, MyProfileVM vm) {
    return Visibility(
      visible: vm.userProfile?.user?.enrolledCourses?.isNotEmpty ?? false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: 1.sw, height: 3.h, color: AppColor.border),
          SeeAllButton(
            title: 'my_courses'.tr(),
            onSeeAll: () {
              AppRoutes.push(context, AppRoutes.myCourse);
            },
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 252.h,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return CourseCard(
                  isEnrolled: true,
                  course:
                      vm.userProfile?.user?.enrolledCourses?[index] ??
                      CourseModel(),
                );
              },
              itemCount: vm.userProfile?.user?.enrolledCourses?.length ?? 0,
            ),
          ),
        ],
      ),
    );
  }
}
