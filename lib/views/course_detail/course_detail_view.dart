import 'package:animated_read_more_text/animated_read_more_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecourse_flutter_v2/core/base/base_view.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_constants.dart';
import 'package:ecourse_flutter_v2/core/config/app_image.dart';
import 'package:ecourse_flutter_v2/core/routes/app_routes.dart';
import 'package:ecourse_flutter_v2/core/widgets/buttons/elevated_button.dart';
import 'package:ecourse_flutter_v2/core/widgets/buttons/svg_icon_button.dart';
import 'package:ecourse_flutter_v2/app/data/models/course_model.dart';
import 'package:ecourse_flutter_v2/app/data/models/user_profile.dart';
import 'package:ecourse_flutter_v2/view_models/user_vm.dart';
import 'package:ecourse_flutter_v2/view_models/course_detail_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CourseDetailView extends BaseView<CourseDetailVM> {
  const CourseDetailView({super.key});

  @override
  CourseDetailVM createViewModel(
    BuildContext context,
    Map<String, dynamic>? arguments,
  ) {
    final CourseModel course = CourseModel.fromJson(arguments!);
    return CourseDetailVM(context, course: course);
  }

  @override
  Widget buildView(BuildContext context, CourseDetailVM vm) {
    final UserProfile? userProfile = context.read<UserVM>().userProfile;
    return Scaffold(
      appBar: AppBar(
        title: Text('course_detail'.tr()),
        backgroundColor: AppColor.background,
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 33.h),
        child: Row(
          children: [
            Expanded(
              child: CustomElevatedButton(
                onPressed: () {},
                text: '${'buy_course'.tr()} for ${vm.course?.price}',
                context: context,
              ),
            ),
            SizedBox(width: 8.w),
            SvgIconButton(
              assetName: AppImage.svgCart,
              onPressed: () {
                vm.addToCart();
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 1.sw,
                height: 200.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      vm.course?.thumnail?.url ?? '',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                vm.course?.title ?? '',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  SvgPicture.asset(
                    AppImage.svgClock,
                    width: 16.w,
                    height: 16.h,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '${vm.course?.totalDuration}h ${vm.course?.totalDuration != null ? vm.course?.totalDuration! : 0}min',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  SvgPicture.asset(AppImage.svgInfo, width: 16.w, height: 16.h),
                  SizedBox(width: 4.w),
                  Text(
                    '${vm.course?.lessonCount} ${'lessons'.tr()}',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                    ),
                  ),
                  Spacer(),
                  SvgPicture.asset(
                    AppImage.svgStar,
                    color: Colors.yellow,
                    width: 16.w,
                    height: 16.h,
                  ),
                  Text(
                    '${vm.course?.rating}',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '(',
                          style: Theme.of(
                            context,
                          ).textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                          ),
                        ),
                        TextSpan(
                          text: '${vm.course?.reviewCount} ${'rattings'.tr()}',
                          style: Theme.of(
                            context,
                          ).textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                          ),
                        ),
                        TextSpan(
                          text: ')',
                          style: Theme.of(
                            context,
                          ).textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ListTile(
                onTap: () {
                  AppRoutes.push(
                    context,
                    AppRoutes.teacherProfile,
                    arguments: vm.course?.instructor?.toJson(),
                  );
                },
                contentPadding: EdgeInsets.symmetric(horizontal: 0.w),
                leading: CircleAvatar(
                  backgroundImage: AssetImage(AppConstants.defaultAvatar),
                ),
                title: Text(
                  '${vm.course?.instructor?.firstName} ${vm.course?.instructor?.lastName}',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '${vm.course?.instructor?.level}',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 10.sp,
                    color: AppColor.textSecondary,
                  ),
                ),
                trailing: Visibility(
                  visible: userProfile?.user?.sId != vm.course?.instructor?.sId,
                  child: CustomElevatedButton(
                    onPressed: () {},
                    height: 30.h,
                    textStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                      color: AppColor.textPrimaryDark,
                    ),
                    context: context,
                    text: 'follow'.tr(),
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'about_this_course'.tr(),
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
              AnimatedReadMoreText(
                vm.course?.description ?? '',
                maxLines: 6,
                textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColor.textSecondary,
                  fontSize: 10.sp,
                ),
              ),

              SizedBox(height: 16),
              Row(
                children: [
                  SvgPicture.asset(AppImage.svgWarning),
                  SizedBox(width: 8.w),
                  Text(
                    vm.course?.updatedAtString ?? '',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
