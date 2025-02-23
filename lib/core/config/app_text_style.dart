import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyle {
  // Regular text styles
  static TextStyle regular({
    double? fontSize,
    Color? color,
    double? height,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: 'GeneralSans',
      fontWeight: FontWeight.w400,
      fontSize: fontSize?.sp ?? 14.sp,
      color: color,
      height: height,
      decoration: decoration,
    );
  }

  // Medium text styles
  static TextStyle medium({
    double? fontSize,
    Color? color,
    double? height,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: 'GeneralSans',
      fontWeight: FontWeight.w500,
      fontSize: fontSize?.sp ?? 14.sp,
      color: color,
      height: height,
      decoration: decoration,
    );
  }

  // SemiBold text styles
  static TextStyle semiBold({
    double? fontSize,
    Color? color,
    double? height,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: 'GeneralSans',
      fontWeight: FontWeight.w600,
      fontSize: fontSize?.sp ?? 14.sp,
      color: color,
      height: height,
      decoration: decoration,
    );
  }

  // Bold text styles
  static TextStyle bold({
    double? fontSize,
    Color? color,
    double? height,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: 'GeneralSans',
      fontWeight: FontWeight.w700,
      fontSize: fontSize?.sp ?? 14.sp,
      color: color,
      height: height,
      decoration: decoration,
    );
  }
}
