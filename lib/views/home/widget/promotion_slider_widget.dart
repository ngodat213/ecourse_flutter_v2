import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_image.dart';
import 'package:ecourse_flutter_v2/core/widgets/buttons/elevated_button.dart';
import 'package:ecourse_flutter_v2/view_models/home_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
