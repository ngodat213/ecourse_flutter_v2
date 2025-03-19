import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CourseLearnAppBar extends StatelessWidget {
  const CourseLearnAppBar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(
          child: SizedBox(
            width: 0.6.sw,
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Positioned(
          right: 8.w,
          child: IconButton(
            onPressed: () {},
            padding: EdgeInsets.all(4.w),
            icon: SvgPicture.asset(
              AppImage.svgMore,
              width: 16.w,
              height: 16.w,
              color: AppColor.primary,
            ),
          ),
        ),
        Positioned(
          left: 8.w,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: SvgPicture.asset(
              AppImage.svgArrowLeft,
              width: 16.w,
              height: 16.w,
              color: AppColor.primary,
            ),
          ),
        ),
      ],
    );
  }
}
