import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_constants.dart';
import 'package:ecourse_flutter_v2/core/config/app_image.dart';
import 'package:ecourse_flutter_v2/core/routes/app_routes.dart';
import 'package:ecourse_flutter_v2/core/widgets/buttons/elevated_button.dart';
import 'package:ecourse_flutter_v2/core/widgets/buttons/see_all_button.dart';
import 'package:ecourse_flutter_v2/core/widgets/smart_image.dart';
import 'package:ecourse_flutter_v2/core/widgets/buttons/svg_icon_button.dart';
import 'package:ecourse_flutter_v2/models/course_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/base/base_view.dart';
import '../../view_models/home_vm.dart';

class HomeView extends BaseView<HomeVM> {
  const HomeView({super.key});

  @override
  HomeVM createViewModel(
    BuildContext context,
    Map<String, dynamic>? arguments,
  ) {
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
            SmartImage(
              source:
                  vm.userProfile?.user?.profilePicture ??
                  AppConstants.defaultAvatar,
              width: 40.w,
              height: 40.h,
              fit: BoxFit.cover,
              borderRadius: BorderRadius.circular(20.r),
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
                  vm.userProfile?.user?.level ?? '',
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
      actions: [
        SvgIconButton(assetName: AppImage.svgBell, onPressed: () {}),
        SvgIconButton(assetName: AppImage.svgCart, onPressed: () {}),
      ],
    );
  }

  @override
  Widget buildView(BuildContext context, HomeVM vm) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NotificationSchedule(),
            // PromotionSliderWidget(vm: vm),
            UserStreak(),
            SizedBox(height: 16.h),
            CourseProgressCard(),
            SeeAllButton(title: 'popular_courses'.tr(), onSeeAll: () {}),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    vm.popularCourses
                        .map((e) => CourseCard(course: e))
                        .toList(),
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}

class NotificationSchedule extends StatelessWidget {
  const NotificationSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.w),
      child: Card(
        elevation: 2,
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        color: AppColor.cardColor,
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.cardColor,
            borderRadius: BorderRadius.circular(16.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: SvgPicture.asset(
                  AppImage.svgClock,
                  width: 16.w,
                  height: 16.w,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'schedule_learning_time'.tr(),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'make_learning_a_daily_habit'.tr(),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 10.sp,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        CustomElevatedButton(
                          context: context,
                          text: 'get_started'.tr(),
                          height: 32.h,
                          textStyle: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 10.sp,
                            color: AppColor.textPrimaryDark,
                          ),
                          onPressed: () {},
                        ),
                        SizedBox(width: 8.w),
                        CustomElevatedButton(
                          context: context,
                          text: 'dismiss'.tr(),
                          height: 32.h,
                          textStyle: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 10.sp,
                            color: AppColor.textPrimaryDark,
                          ),
                          onPressed: () {},
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
    );
  }
}

class UserStreak extends StatelessWidget {
  const UserStreak({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            'Start a weekly streak',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 18.sp,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            'One ring down! Now, watch your course(s)',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Card(
          elevation: 2,
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          color: AppColor.cardColor,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Image.asset(AppImage.imgStreak, width: 50.w, height: 50.w),
                    Text(
                      '0 days',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Current streak',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    CircularProgressIndicator(
                      value: 0.5,
                      color: AppColor.primary,
                    ),
                    SizedBox(width: 16.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '0 days',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Current streak',
                          style: Theme.of(
                            context,
                          ).textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CourseProgressCard extends StatelessWidget {
  const CourseProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SeeAllButton(title: 'inprogress'.tr(), onSeeAll: () {}),
        SizedBox(
          height: 116.h,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return ProgressCourseCard();
            },
            itemCount: 5,
          ),
        ),
      ],
    );
  }
}

class ProgressCourseCard extends StatelessWidget {
  const ProgressCourseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppRoutes.push(context, AppRoutes.courseLearn);
      },
      child: Card(
        elevation: 2,
        margin: EdgeInsets.only(left: 16.w, bottom: 16.h),
        color: AppColor.cardColor,
        child: Container(
          width: 0.6.sw,
          height: 100.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Flutter for beginners',
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    AppImage.svgProfile,
                    width: 8.w,
                    height: 8.h,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'Hydra coder',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Progress',
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '60%',
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  LinearProgressIndicator(
                    value: 0.6,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(AppColor.primary),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                  SizedBox(height: 8.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PromotionSliderWidget extends StatelessWidget {
  const PromotionSliderWidget({super.key, required this.vm});
  final HomeVM vm;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16.w),
          child: Text(
            'Brainy Promos'.tr(),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 18.sp,
            ),
          ),
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: 150.h,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.7,
            onPageChanged: (index, reason) => vm.changeCarouselIndex(index),
          ),
          items:
              [1, 2, 3, 4, 5].map((i) {
                return PromoCard();
              }).toList(),
        ),
        Center(
          child: DotsIndicator(
            dotsCount: 5,
            position: vm.carouselIndex.toDouble(),
            decorator: DotsDecorator(
              color: AppColor.textPrimary,
              activeColor: AppColor.primary,
              spacing: EdgeInsets.only(bottom: 10.h, top: 10.h, right: 6.w),
            ),
          ),
        ),
      ],
    );
  }
}

class CourseCard extends StatelessWidget {
  const CourseCard({super.key, required this.course});
  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppRoutes.push(
          context,
          AppRoutes.courseDetail,
          arguments: course.toJson(),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        margin: EdgeInsets.only(left: 16.w),
        elevation: 2,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
          width: 0.5.sw - 24.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.r),
                  topRight: Radius.circular(8.r),
                ),
                child: CachedNetworkImage(
                  imageUrl: course.thumnail?.url ?? '',
                  fit: BoxFit.cover,
                  width: 0.5.sw - 24.w,
                  height: 100.h,
                ),
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
                      course.title ?? '',
                      maxLines: 2,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${course.instructor?.firstName} ${course.instructor?.lastName}, ${course.instructor?.level}',
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.h,
                        vertical: 2.h,
                      ),
                      child: Text(
                        course.type ?? '',
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
                          '${course.price}',
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          '${course.price}',
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
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
        ),
      ),
    );
  }
}

class PromoCard extends StatelessWidget {
  const PromoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      color: const Color(0xff6587DD),
      elevation: 5,
      child: SizedBox(
        width: 0.72.sw,
        height: 150.h,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: SvgPicture.asset(AppImage.vectorPromo, fit: BoxFit.cover),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 16.w, top: 16.h, right: 24.w),
                child: Text(
                  'Super Sale This Year!!',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 16.h,
              left: 16.w,
              child: CustomElevatedButton(
                context: context,
                text: 'claim_promo'.tr(),
                textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 10.sp,
                  color: AppColor.textPrimaryDark,
                ),
                onPressed: () {},
              ),
            ),
            Positioned(
              bottom: 0.h,
              right: 0.w,
              child: Image.asset(
                AppImage.imgPromo,
                width: 120.w,
                height: 120.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
