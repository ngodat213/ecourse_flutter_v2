import 'package:animated_read_more_text/animated_read_more_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecourse_flutter_v2/core/base/base_view.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_constants.dart';
import 'package:ecourse_flutter_v2/core/config/app_image.dart';
import 'package:ecourse_flutter_v2/core/routes/app_routes.dart';
import 'package:ecourse_flutter_v2/core/widgets/elevated_button.dart';
import 'package:ecourse_flutter_v2/core/widgets/see_all.dart';
import 'package:ecourse_flutter_v2/view_models/profile_vm.dart';
import 'package:ecourse_flutter_v2/views/home/widget/event_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProfileView extends BaseView<ProfileVM> {
  const ProfileView({super.key});

  @override
  ProfileVM createViewModel(BuildContext context) {
    return ProfileVM(context);
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, ProfileVM vm) {
    return AppBar(
      title: Column(
        children: [
          Text(
            'Profile',
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
  Widget buildView(BuildContext context, ProfileVM viewModel) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 0.26.sh,
            width: 1.sw,
            child: Stack(
              children: [
                Container(
                  width: 1.sw,
                  height: 0.2.sh,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImage.imageThumnail),
                      fit: BoxFit.cover,
                    ),
                  ),
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
                  'Hydra Coder',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                  ),
                ),
                Text(
                  'Flutter Developer Expert',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColor.textSecondary,
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Thu Duc District, Ho Chi Minh City, Viet Nam',
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
                      '11.111 Followers, ',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColor.textSecondary,
                        fontSize: 10.sp,
                      ),
                    ),
                    Text(
                      'Work at Amazon',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColor.textSecondary,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
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
              'Tempor est officia sunt dolore et proident ullamco est voluptate laboris laborum laborum sit. Ullamco minim dolor cillum cillum eiusmod minim amet tempor anim. Dolore pariatur ipsum ad ullamco consectetur quis dolore. Excepteur ullamco deserunt occaecat quis enim aliqua excepteur reprehenderit irure ad ullamco. Magna laboris in tempor do cillum nisi. Laboris duis veniam labore veniam.',
              maxLines: 5,
              textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColor.textSecondary,
                fontSize: 10.sp,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Container(width: 1.sw, height: 3.h, color: AppColor.border),
          SeeAllWidget(
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
                return CourseCard();
              },
              itemCount: 5,
            ),
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}
