import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_constants.dart';
import 'package:ecourse_flutter_v2/core/config/app_image.dart';
import 'package:ecourse_flutter_v2/core/widgets/banner.dart';
import 'package:ecourse_flutter_v2/core/widgets/category_item.dart';
import 'package:ecourse_flutter_v2/core/widgets/elevated_button.dart';
import 'package:ecourse_flutter_v2/core/widgets/popular_card.dart';
import 'package:ecourse_flutter_v2/core/widgets/see_all.dart';
import 'package:ecourse_flutter_v2/core/widgets/svg_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/base/base_view.dart';
import '../../view_models/home_vm.dart';

class HomeView extends BaseView<HomeVM> {
  const HomeView({super.key});

  @override
  HomeVM createViewModel(BuildContext context) {
    return HomeVM(context);
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, HomeVM vm) {
    return AppBar(
      title: Row(
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
      centerTitle: false,
      backgroundColor: AppColor.background,
      actions: [
        SvgIconButton(assetName: AppImage.svgBell, onPressed: () {}),
        SvgIconButton(assetName: AppImage.svgCart, onPressed: () {}),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(24.0),
        child: Divider(height: 1, thickness: 1, color: Colors.grey),
      ),
    );
  }

  @override
  Widget buildView(BuildContext context, HomeVM vm) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
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
                onPageChanged: (index, reason) {
                  vm.carouselIndex = index;
                  vm.notifyListeners();
                },
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
            SeeAllWidget(title: 'popular_courses'.tr(), onSeeAll: () {}),
            Row(children: [CourseCard(), CourseCard()]),
            SizedBox(height: 24.h),
            SeeAllWidget(title: 'popular_courses'.tr(), onSeeAll: () {}),
            SizedBox(height: 16.h),
            BannerWidget(),
            CategoryItem(),
            PopularCard(),
            TextButton(
              onPressed: () => vm.redirectToAdmin(),
              child: Text('Admin Dashboard'),
            ),
          ],
        ),
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
