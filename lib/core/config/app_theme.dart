import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_color.dart';
import 'app_text_style.dart';

class AppTheme {
  static TextTheme getTextTheme(BuildContext context) {
    return TextTheme(
      // Display styles
      displayLarge: AppTextStyle.bold(
        context: context,
        fontSize: 57.sp,
        height: 1.12,
        color: AppColor.textPrimary,
      ),
      displayMedium: AppTextStyle.bold(
        context: context,
        fontSize: 45.sp,
        height: 1.15,
        color: AppColor.textPrimary,
      ),
      displaySmall: AppTextStyle.bold(
        fontSize: 36.sp,
        height: 1.22,
        color: AppColor.textPrimary,
      ),

      // Headline styles
      headlineLarge: AppTextStyle.semiBold(
        fontSize: 32.sp,
        height: 1.25,
        color: AppColor.textPrimary,
      ),
      headlineMedium: AppTextStyle.semiBold(
        fontSize: 28.sp,
        height: 1.28,
        color: AppColor.textPrimary,
      ),
      headlineSmall: AppTextStyle.semiBold(
        fontSize: 24.sp,
        height: 1.33,
        color: AppColor.textPrimary,
      ),

      // Title styles
      titleLarge: AppTextStyle.medium(
        fontSize: 22.sp,
        height: 1.27,
        color: AppColor.textPrimary,
      ),
      titleMedium: AppTextStyle.medium(
        fontSize: 16.sp,
        height: 1.5,
        color: AppColor.textPrimary,
      ),
      titleSmall: AppTextStyle.medium(
        fontSize: 14.sp,
        height: 1.43,
        color: AppColor.textPrimary,
      ),

      // Label styles
      labelLarge: AppTextStyle.medium(
        fontSize: 14.sp,
        height: 1.43,
        color: AppColor.textPrimary,
      ),
      labelMedium: AppTextStyle.medium(
        fontSize: 12.sp,
        height: 1.33,
        color: AppColor.textSecondary,
      ),
      labelSmall: AppTextStyle.medium(
        fontSize: 11.sp,
        height: 1.45,
        color: AppColor.textPrimary,
      ),

      // Body styles
      bodyLarge: AppTextStyle.regular(
        fontSize: 16.sp,
        height: 1.5,
        color: AppColor.textPrimary,
      ),
      bodyMedium: AppTextStyle.regular(
        fontSize: 14.sp,
        height: 1.43,
        color: AppColor.textPrimary,
      ),
      bodySmall: AppTextStyle.regular(
        fontSize: 12.sp,
        height: 1.33,
        color: AppColor.textPrimary,
      ),
    );
  }

  static TextTheme getDarkTextTheme(BuildContext context) {
    return getTextTheme(context).apply(
      bodyColor: AppColor.textPrimaryDark,
      displayColor: AppColor.textPrimaryDark,
    );
  }

  static ThemeData getLightTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColor.primary,
      dividerColor: Colors.black,
      scaffoldBackgroundColor: AppColor.background,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primary),
      fontFamily: 'Poppins',
      textTheme: getTextTheme(context),
      useMaterial3: true,
    );
  }

  static ThemeData getDarkTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColor.primary,
      dividerColor: Colors.black,
      scaffoldBackgroundColor: AppColor.backgroundDark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColor.primary,
        brightness: Brightness.dark,
      ),
      fontFamily: 'Poppins',
      textTheme: getTextTheme(context).apply(
        bodyColor: AppColor.textPrimary,
        displayColor: AppColor.textPrimary,
      ),
      useMaterial3: true,
    );
  }
}
