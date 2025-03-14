import 'package:easy_localization/easy_localization.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClaimCerificationCard extends StatelessWidget {
  final int progress;

  const ClaimCerificationCard({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    final double progressValue = progress / 100;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.cardColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColor.accent),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'progress_so_far'.tr(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '$progress% ',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColor.primary,
                        fontSize: 10.sp,
                      ),
                    ),
                    TextSpan(
                      text: 'completed',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColor.textSecondary,
                        fontWeight: FontWeight.w400,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: LinearProgressIndicator(
              value: progressValue,
              color: AppColor.primary,
              backgroundColor: AppColor.secondary,
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'You did it! Congrats heres ',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 10.sp,
                  ),
                ),
                TextSpan(
                  text: '100 Points ',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColor.textTertiary,
                    fontWeight: FontWeight.w500,
                    fontSize: 10.sp,
                  ),
                ),
                TextSpan(
                  text: 'and a ',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColor.textSecondary,
                    fontWeight: FontWeight.w500,
                    fontSize: 10.sp,
                  ),
                ),
                TextSpan(
                  text: 'Certificate',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColor.textTertiary,
                    fontWeight: FontWeight.w500,
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          GestureDetector(
            onTap: () {},
            child: Text(
              'claim_certificate'.tr(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 10.sp,
                color: AppColor.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
