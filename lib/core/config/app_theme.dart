import 'package:flutter/material.dart';
import 'app_color.dart';
import 'app_text_style.dart';

class AppTheme {
  static TextTheme get textTheme {
    return TextTheme(
      // Display styles
      displayLarge: AppTextStyle.bold(
        fontSize: 57,
        height: 1.12,
        color: AppColor.textPrimary,
      ),
      displayMedium: AppTextStyle.bold(
        fontSize: 45,
        height: 1.15,
        color: AppColor.textPrimary,
      ),
      displaySmall: AppTextStyle.bold(
        fontSize: 36,
        height: 1.22,
        color: AppColor.textPrimary,
      ),

      // Headline styles
      headlineLarge: AppTextStyle.semiBold(
        fontSize: 32,
        height: 1.25,
        color: AppColor.textPrimary,
      ),
      headlineMedium: AppTextStyle.semiBold(
        fontSize: 28,
        height: 1.28,
        color: AppColor.textPrimary,
      ),
      headlineSmall: AppTextStyle.semiBold(
        fontSize: 24,
        height: 1.33,
        color: AppColor.textPrimary,
      ),

      // Title styles
      titleLarge: AppTextStyle.medium(
        fontSize: 22,
        height: 1.27,
        color: AppColor.textPrimary,
      ),
      titleMedium: AppTextStyle.medium(
        fontSize: 16,
        height: 1.5,
        color: AppColor.textPrimary,
      ),
      titleSmall: AppTextStyle.medium(
        fontSize: 14,
        height: 1.43,
        color: AppColor.textPrimary,
      ),

      // Label styles
      labelLarge: AppTextStyle.medium(
        fontSize: 14,
        height: 1.43,
        color: AppColor.textPrimary,
      ),
      labelMedium: AppTextStyle.medium(
        fontSize: 12,
        height: 1.33,
        color: AppColor.textSecondary,
      ),
      labelSmall: AppTextStyle.medium(
        fontSize: 11,
        height: 1.45,
        color: AppColor.textPrimary,
      ),

      // Body styles
      bodyLarge: AppTextStyle.regular(
        fontSize: 16,
        height: 1.5,
        color: AppColor.textPrimary,
      ),
      bodyMedium: AppTextStyle.regular(
        fontSize: 14,
        height: 1.43,
        color: AppColor.textPrimary,
      ),
      bodySmall: AppTextStyle.regular(
        fontSize: 12,
        height: 1.33,
        color: AppColor.textPrimary,
      ),
    );
  }

  static TextTheme get darkTextTheme {
    return textTheme.apply(
      bodyColor: AppColor.textPrimaryDark,
      displayColor: AppColor.textPrimaryDark,
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColor.primary,
      scaffoldBackgroundColor: AppColor.background,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primary),
      fontFamily: 'GeneralSans',
      textTheme: textTheme,
      useMaterial3: true,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColor.primary,
      scaffoldBackgroundColor: AppColor.backgroundDark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColor.primary,
        brightness: Brightness.dark,
      ),
      fontFamily: 'GeneralSans',
      textTheme: darkTextTheme,
      useMaterial3: true,
    );
  }
}
