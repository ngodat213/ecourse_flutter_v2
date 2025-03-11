import 'package:easy_localization/easy_localization.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_constants.dart';
import 'package:ecourse_flutter_v2/core/config/app_image.dart';
import 'package:ecourse_flutter_v2/core/routes/app_routes.dart';
import 'package:ecourse_flutter_v2/core/widgets/elevated_button.dart';
import 'package:ecourse_flutter_v2/core/widgets/see_all.dart';
import 'package:ecourse_flutter_v2/core/widgets/svg_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/base/base_view.dart';
import '../../../view_models/home_vm.dart';

class TeacherHomeView extends BaseView<HomeVM> {
  const TeacherHomeView({super.key});

  @override
  HomeVM createViewModel(BuildContext context) {
    return HomeVM(context);
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, HomeVM vm) {
    return AppBar(
      title: GestureDetector(
        onTap: () {
          AppRoutes.push(context, AppRoutes.profile);
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 20.r,
              backgroundImage: AssetImage(
                vm.userProfile?.user?.profilePicture ??
                    AppConstants.defaultAvatar,
              ),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, ${vm.userProfile?.user?.firstName ?? ''} ${vm.userProfile?.user?.lastName ?? ''}',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  'Mobile Developer',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ],
        ),
      ),
      centerTitle: false,
      backgroundColor: AppColor.background,
      actions: [SvgIconButton(assetName: AppImage.svgBell, onPressed: () {})],
    );
  }

  @override
  Widget buildView(BuildContext context, HomeVM vm) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [TeacherOverview(), TeacherCourseProgress()],
        ),
      ),
    );
  }
}

class TeacherCourseProgress extends StatelessWidget {
  const TeacherCourseProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SeeAllWidget(
          title: 'course_creation'.tr(),
          onSeeAll: () {},
          seeAllText: 'sort_by'.tr(),
        ),
        Column(
          children: List.generate(
            3,
            (index) => Container(
              width: 1.sw - 32.w,
              margin: EdgeInsets.only(bottom: 8.r, left: 16.w, right: 16.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      width: 50.w,
                      height: 100.h - 18.h,
                      decoration: BoxDecoration(
                        color: AppColor.info,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4.r),
                          bottomLeft: Radius.circular(4.r),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '3D',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            color: AppColor.textPrimaryDark,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: AppColor.cardColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(4.r),
                        bottomRight: Radius.circular(4.r),
                      ),
                      border: Border(
                        top: BorderSide(color: AppColor.border),
                        bottom: BorderSide(color: AppColor.border),
                        right: BorderSide(color: AppColor.border),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Learn 3D Basics with Blender',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColor.textPrimary,
                            fontSize: 13.sp,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Text(
                              'Course Progess',
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColor.textPrimary,
                                fontSize: 10.sp,
                              ),
                            ),
                            Container(
                              width: 84.w,
                              margin: EdgeInsets.symmetric(horizontal: 8.w),
                              child: LinearProgressIndicator(
                                value: 0.5,
                                color: AppColor.primary,
                              ),
                            ),
                            Text(
                              '90%',
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColor.textPrimary,
                                fontSize: 10.sp,
                              ),
                            ),
                            Text(
                              'Completion',
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppColor.textPrimary,
                                fontSize: 10.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Artificial Intelligence ',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.textPrimary,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Support',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.copyWith(
                                      color: AppColor.textPrimary,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Status ',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.textPrimary,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Declined',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.copyWith(
                                      color: AppColor.textPrimary,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Draft',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.textPrimary,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              Expanded(
                child: CustomElevatedButton(
                  onPressed: () {},
                  height: 30.h,
                  textStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 10.sp,
                    color: AppColor.textPrimaryDark,
                  ),
                  context: context,
                  text: 'New course',
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: CustomElevatedButton(
                  context: context,
                  text: 'Try Creating AI-Course',
                  onPressed: () {},
                  height: 30.h,
                  textStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 10.sp,
                    color: AppColor.textPrimaryDark,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TeacherOverview extends StatelessWidget {
  const TeacherOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'overview'.tr(),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 18.sp,
            ),
          ),
          Text(
            'overview_description'.tr(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColor.textSecondary,
              fontSize: 10.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            width: 1.sw,
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.border),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ItemOverview(
                  title: 'total_revenue'.tr(),
                  value: '\$20.00',
                  subValue: '\$10.00 Paid this month',
                ),
                ItemOverview(
                  title: 'total_enrolls'.tr(),
                  value: '21',
                  subValue: '7 Enrolled this month',
                ),
                ItemOverview(
                  title: 'your_ratings'.tr(),
                  value: '8/10',
                  subValue: '17 ratings this month',
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'view_full_report'.tr(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColor.primary,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class ItemOverview extends StatelessWidget {
  const ItemOverview({
    super.key,
    required this.title,
    required this.value,
    required this.subValue,
  });
  final String title;
  final String value;
  final String subValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw / 3 - 32.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 10.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 13.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            subValue,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}
