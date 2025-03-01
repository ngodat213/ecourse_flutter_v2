import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SeeAllWidget extends StatelessWidget {
  const SeeAllWidget({super.key, required this.title, this.onSeeAll});

  final String title;
  final Function()? onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 18.sp,
            ),
          ),
          TextButton(
            onPressed: onSeeAll,
            child: Text(
              'see_all'.tr(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 10.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
