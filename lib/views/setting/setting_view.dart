import 'package:easy_localization/easy_localization.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_constants.dart';
import 'package:ecourse_flutter_v2/core/config/app_image.dart';
import 'package:ecourse_flutter_v2/core/routes/app_routes.dart';
import 'package:ecourse_flutter_v2/core/widgets/buttons/elevated_button.dart';
import 'package:ecourse_flutter_v2/core/widgets/buttons/svg_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/base/base_view.dart';
import 'package:ecourse_flutter_v2/view_models/profile_vm.dart';

class SettingView extends BaseView<ProfileVM> {
  const SettingView({super.key});

  @override
  ProfileVM createViewModel(
    BuildContext context,
    Map<String, dynamic>? arguments,
  ) {
    return ProfileVM(context);
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, ProfileVM vm) {
    return AppBar(
      toolbarHeight: 80.h,
      title: Text(
        'profile'.tr(),
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 24.sp,
        ),
      ),
      centerTitle: false,
      backgroundColor: AppColor.background,
    );
  }

  @override
  Widget buildView(BuildContext context, ProfileVM vm) {
    final settingAccount = [
      {
        'title': 'password_security'.tr(),
        'onPressed': () {
          AppRoutes.push(context, AppRoutes.passwordSecurity);
        },
      },
      {
        'title': 'transaction_history'.tr(),
        'onPressed': () {
          AppRoutes.push(context, AppRoutes.transactionHistory);
        },
      },
      {
        'title': 'contact_us'.tr(),
        'onPressed': () {
          AppRoutes.push(context, AppRoutes.contactUs);
        },
      },
    ];

    final settingUser = [
      {
        'title': 'my_courses'.tr(),
        'onPressed': () {
          AppRoutes.push(context, AppRoutes.myCourse);
        },
      },
      {
        'title': 'achievements'.tr(),
        'onPressed': () {
          AppRoutes.push(context, AppRoutes.myCertificates);
        },
      },
      {'title': 'calender'.tr(), 'onPressed': () {}},
    ];
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 1.sw,
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                top: 16.h,
                bottom: 8.h,
              ),
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: AppColor.cardColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 22.r,
                        backgroundImage: AssetImage(AppConstants.defaultAvatar),
                      ),
                      SizedBox(width: 8.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${vm.userProfile?.user?.firstName} ${vm.userProfile?.user?.lastName}',
                            style: Theme.of(
                              context,
                            ).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 18.sp,
                            ),
                          ),
                          Text(
                            vm.userProfile?.user?.level ?? '',
                            style: Theme.of(
                              context,
                            ).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 10.sp,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Container(
                            height: 1.h,
                            width: 1.sw - 103.w - 22.r,
                            color: Color(0xffECEFF5),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: vm.redirectToProfile,
                        child: Text(
                          'edit_profile'.tr(),
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColor.primary,
                          ),
                        ),
                      ),
                      SvgIconButton(
                        assetName: AppImage.svgRightArrow,
                        onPressed: vm.redirectToProfile,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            ListTitleProfile(settingAccount: settingAccount),
            SizedBox(height: 16.h),
            ListTitleProfile(settingAccount: settingUser),
            SizedBox(height: 16.h),
            Center(
              child: CustomElevatedButton(
                context: context,
                width: 1.sw - 32.w,
                height: 48.h,
                backgroundColor: AppColor.error,
                text: 'sign_out'.tr(),
                onPressed: vm.logout,
              ),
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}

class ListTitleProfile extends StatelessWidget {
  const ListTitleProfile({super.key, required this.settingAccount});

  final List<Map<String, Object>> settingAccount;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: settingAccount.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: ShapeDecoration(
            color: AppColor.cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: index == 0 ? Radius.circular(8.r) : Radius.zero,
                topRight: index == 0 ? Radius.circular(8.r) : Radius.zero,
                bottomLeft:
                    index == settingAccount.length - 1
                        ? Radius.circular(8.r)
                        : Radius.zero,
                bottomRight:
                    index == settingAccount.length - 1
                        ? Radius.circular(8.r)
                        : Radius.zero,
              ),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  settingAccount[index]['title'] as String,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColor.textSecondary,
                    fontSize: 13.sp,
                  ),
                ),
                onTap: settingAccount[index]['onPressed'] as VoidCallback,
                trailing: SvgPicture.asset(
                  AppImage.svgRightArrow,
                  width: 16.w,
                  height: 16.h,
                ),
              ),
              if (index != settingAccount.length - 1)
                const Divider(
                  height: 1,
                  thickness: 1,
                  indent: 16, // Thụt lề trái
                  endIndent: 16, // Thụt lề phải
                  color: Colors.grey, // Tùy chỉnh màu sắc
                ),
            ],
          ),
        );
      },
    );
  }
}
