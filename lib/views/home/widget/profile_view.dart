import 'package:easy_localization/easy_localization.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_constants.dart';
import 'package:ecourse_flutter_v2/core/config/app_image.dart';
import 'package:ecourse_flutter_v2/core/routes/app_routes.dart';
import 'package:ecourse_flutter_v2/core/widgets/elevated_button.dart';
import 'package:ecourse_flutter_v2/core/widgets/svg_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/base/base_view.dart';
import '../../../view_models/home_vm.dart';

class ProfileView extends BaseView<HomeVM> {
  const ProfileView({super.key});

  @override
  HomeVM createViewModel(BuildContext context) {
    return HomeVM(context);
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, HomeVM vm) {
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
  Widget buildView(BuildContext context, HomeVM vm) {
    final settingAccount = [
      {'title': 'name_phone_email'.tr(), 'onPressed': () {}},
      {'title': 'password_security'.tr(), 'onPressed': () {}},
      {'title': 'transaction_history'.tr(), 'onPressed': () {}},
      {'title': 'contact_us'.tr(), 'onPressed': () {}},
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
                            'John Doe',
                            style: Theme.of(
                              context,
                            ).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 18.sp,
                            ),
                          ),
                          Text(
                            'UI/UX Designer',
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
                      Text(
                        'edit_profile'.tr(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColor.primary,
                        ),
                      ),
                      SvgIconButton(
                        assetName: AppImage.svgRightArrow,
                        onPressed: () {},
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
                onPressed: () {},
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
