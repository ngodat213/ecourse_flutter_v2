import 'package:flutter/material.dart';

class AppConstants {
  static const String defaultAvatar = 'assets/images/home/default-avatar.png';
  static const int otpLength = 5;
  static const int resendCooldown = 60;
  static const String biometricReason = 'Xác thực để đăng nhập';
  static const int tokenExpiryTime = 55 * 60 * 1000;
  static const int refreshTokenTime = 30 * 60 * 1000;
  static const int splashScreenDuration = 2;

  // App Bar
  static const double kAppBarHeight = 56.0;
  static const double kToolbarHeight = 56.0;

  /// Get total app bar height including status bar
  static double getAppBarTotalHeight(BuildContext context) {
    return kAppBarHeight + MediaQuery.of(context).padding.top;
  }
}
