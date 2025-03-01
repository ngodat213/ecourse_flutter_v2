import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/utils/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.context,
    required this.text,
    required this.onPressed,
    this.leading,
    this.backgroundColor,
    this.foregroundColor,
    this.textStyle,
    this.width,
    this.padding,
    this.height,
  });

  final BuildContext context;
  final String text;
  final TextStyle? textStyle;
  final Widget? leading;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = ResponsiveLayout.isDesktop(context);

    final horizontalPadding = isDesktop ? 24.0 : 16.w;
    final verticalPadding = isDesktop ? 16.0 : 8.h;
    final fontSize = isDesktop ? 16.0 : 14.sp;
    final iconSize = isDesktop ? 24.0 : 20.w;
    final borderRadius = isDesktop ? 12.0 : 12.r;
    final width = isDesktop ? 400.w : this.width;
    final height = isDesktop ? 56.h : this.height;

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding:
              padding ??
              EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
          backgroundColor: backgroundColor ?? AppColor.primary,
          foregroundColor: foregroundColor ?? Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: width == null ? MainAxisSize.min : MainAxisSize.max,
          children: [
            leading ?? const SizedBox(),
            Text(
              text,
              style:
                  textStyle ??
                  Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
