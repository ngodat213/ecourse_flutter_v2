import 'package:ecourse_flutter_v2/utils/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyle {
  static double _getFontSize(BuildContext? context, double? fontSize) {
    if (context == null || fontSize == null) return 14.sp;

    if (ResponsiveLayout.isDesktop(context)) {
      return fontSize.sp / 4; // Chia cho 4 khi ở desktop mode
    }
    return fontSize.sp;
  }

  // Regular text styles
  static TextStyle regular({
    BuildContext? context,
    double? fontSize,
    Color? color,
    double? height,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
      fontSize: _getFontSize(context, fontSize ?? 14),
      color: color,
      height: height,
      decoration: decoration,
    );
  }

  // Medium text styles
  static TextStyle medium({
    BuildContext? context,
    double? fontSize,
    Color? color,
    double? height,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
      fontSize: _getFontSize(context, fontSize ?? 14),
      color: color,
      height: height,
      decoration: decoration,
    );
  }

  // SemiBold text styles
  static TextStyle semiBold({
    BuildContext? context,
    double? fontSize,
    Color? color,
    double? height,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      fontSize: _getFontSize(context, fontSize ?? 14),
      color: color,
      height: height,
      decoration: decoration,
    );
  }

  // Bold text styles
  static TextStyle bold({
    BuildContext? context,
    double? fontSize,
    Color? color,
    double? height,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w700,
      fontSize: _getFontSize(context, fontSize ?? 14),
      color: color,
      height: height,
      decoration: decoration,
    );
  }
}
