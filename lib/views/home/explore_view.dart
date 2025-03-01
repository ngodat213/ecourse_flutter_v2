import 'package:easy_localization/easy_localization.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_constants.dart';
import 'package:ecourse_flutter_v2/core/config/app_image.dart';
import 'package:ecourse_flutter_v2/core/widgets/base_text_field.dart';
import 'package:ecourse_flutter_v2/core/widgets/see_all.dart';
import 'package:ecourse_flutter_v2/core/widgets/svg_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/base/base_view.dart';
import '../../view_models/home_vm.dart';

class ExploreView extends BaseView<HomeVM> {
  const ExploreView({super.key});

  @override
  HomeVM createViewModel(BuildContext context) {
    return HomeVM(context);
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, HomeVM vm) {
    return AppBar(
      toolbarHeight: 80.h,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                'Explore',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 24.sp,
                ),
              ),
              Spacer(),
              SvgIconButton(assetName: AppImage.svgBell, onPressed: () {}),
              SvgIconButton(assetName: AppImage.svgCart, onPressed: () {}),
            ],
          ),
          Row(
            children: [
              BaseTextField(
                height: 35.h,
                width: 1.sw - 76.w,
                hintText: 'search'.tr(),
                prefixIcon: const Icon(Icons.search),
                obscureText: false,
                textInputAction: TextInputAction.done,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
              ),
              Spacer(),
              SvgIconButton(assetName: AppImage.svgFilter, onPressed: () {}),
            ],
          ),
          SizedBox(height: 16.h),
        ],
      ),
      centerTitle: false,
      backgroundColor: AppColor.background,
    );
  }

  @override
  Widget buildView(BuildContext context, HomeVM vm) {
    final List<Map<String, dynamic>> items = [
      {"icon": Icons.design_services, "label": "UI/UX"},
      {"icon": Icons.code, "label": "Coding"},
      {"icon": Icons.block, "label": "3D Design"},
      {"icon": Icons.adobe, "label": "Adobe"},
      {"icon": Icons.brush, "label": "Art"},
      {"icon": Icons.video_library, "label": "Editing"},
      {"icon": Icons.camera, "label": "Photograph"},
      {"icon": Icons.animation, "label": "Animate"},
    ];
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200.h,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ExploreCourses();
                },
                itemCount: 5,
              ),
            ),
            SeeAllWidget(title: 'find_subjects'.tr(), onSeeAll: () {}),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return CategoryCard(
                    icon: items[index]['icon'],
                    label: items[index]['label'],
                  );
                },
              ),
            ),
            SeeAllWidget(title: 'find_teachers'.tr(), onSeeAll: () {}),
            SizedBox(
              height: 200.h,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return TeacherAvatar();
                },
                itemCount: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const CategoryCard({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.3.sw - 24.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8.h),
            decoration: BoxDecoration(
              color: AppColor.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(icon, size: 32.h, color: AppColor.primary),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  const CourseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16.w),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
      width: 0.5.sw - 24.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            AppImage.imgCourse1,
            fit: BoxFit.cover,
            width: 0.5.sw - 24.w,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: AppColor.cardColor,
            ),
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.h),
                Text(
                  'Adobe Premiere Pro: Complete Course...',
                  maxLines: 2,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Michael Curry, Editor Expert',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 9.sp,
                  ),
                ),
                SizedBox(height: 6.h),
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 2.h),
                  child: Text(
                    'Video Editing',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 9.sp,
                      color: AppColor.textPrimaryDark,
                    ),
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Text(
                      '\$99.999',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      '\$99.999',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp,
                        decoration: TextDecoration.lineThrough,
                        color: AppColor.textSecondaryDark,
                        decorationColor: AppColor.textSecondaryDark,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TeacherAvatar extends StatelessWidget {
  const TeacherAvatar({super.key, this.avatar});
  final String? avatar;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.3.sw - 16.w,
      child: Column(
        children: [
          CircleAvatar(
            radius: 35.r,
            backgroundImage: AssetImage(avatar ?? AppConstants.defaultAvatar),
          ),
          Text(
            'Taufok Jim',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 10.sp,
            ),
          ),
          Text(
            'Expert Flutter',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w300,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class ExploreCourses extends StatelessWidget {
  const ExploreCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12.w),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        elevation: 5,
        child: Container(
          width: 0.72.sw,
          height: 150.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            image: DecorationImage(
              image: AssetImage(AppImage.imageThumnail),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Container(
                width: 0.72.sw,
                height: 150.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF202020), Color(0x00202020)],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 16.w, top: 16.h, right: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'UI/UX Design: Make a Great Application With Design...',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColor.textPrimaryDark,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'By ',
                              style: Theme.of(
                                context,
                              ).textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 10.sp,
                                color: AppColor.textPrimaryDark,
                              ),
                            ),
                            TextSpan(
                              text: 'Hydra Coder',
                              style: Theme.of(
                                context,
                              ).textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 10.sp,
                                color: AppColor.textPrimaryDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.h,
                          vertical: 2.h,
                        ),
                        child: Text(
                          'Video Editing',
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 9.sp,
                            color: AppColor.textPrimaryDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 16.h,
                left: 16.w,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppImage.svgClock,
                      width: 16.w,
                      height: 16.h,
                      color: AppColor.textPrimaryDark,
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: ' 7 ',
                            style: Theme.of(
                              context,
                            ).textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 10.sp,
                              color: AppColor.textPrimaryDark,
                            ),
                          ),
                          TextSpan(
                            text: 'Weeks',
                            style: Theme.of(
                              context,
                            ).textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 10.sp,
                              color: AppColor.textPrimaryDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 16.h,
                right: 16.w,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '\$ ',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 10.sp,
                          color: AppColor.textPrimaryDark,
                        ),
                      ),
                      TextSpan(
                        text: '9.99',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 10.sp,
                          color: AppColor.textPrimaryDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
