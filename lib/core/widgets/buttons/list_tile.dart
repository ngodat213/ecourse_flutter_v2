import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ListTileWidget extends StatelessWidget {
  const ListTileWidget({
    super.key,
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.isExam,
    this.onTap,
  });
  final String leading;
  final String title;
  final String subtitle;
  final bool isExam;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.w),
        decoration: BoxDecoration(
          color: AppColor.background,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: AppColor.secondary.withOpacity(0.1),
              blurRadius: 8.r,
            ),
          ],
        ),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),

          leading: Text(
            leading,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColor.textPrimary,
            ),
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColor.textPrimary,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColor.textSecondary,
            ),
          ),
          trailing: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColor.primary.withOpacity(0.3),
              borderRadius: BorderRadius.circular(100.r),
            ),
            child:
                isExam
                    ? SvgPicture.asset(
                      AppImage.svgHour,
                      width: 16.w,
                      height: 16.h,
                      color: AppColor.primary,
                    )
                    : SvgPicture.asset(
                      AppImage.svgPlay,
                      width: 16.w,
                      height: 16.h,
                      color: AppColor.primary,
                    ),
          ),
        ),
      ),
    );
  }
}
