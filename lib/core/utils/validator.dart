import 'package:easy_localization/easy_localization.dart';

class Validator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'email_required'.tr();
    }

    final emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');

    if (!emailRegExp.hasMatch(value)) {
      return 'invalid_email'.tr();
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'password_required'.tr();
    }

    if (value.length < 6) {
      return 'password_length'.tr();
    }

    final hasUpperCase = value.contains(RegExp(r'[A-Z]'));
    final hasLowerCase = value.contains(RegExp(r'[a-z]'));
    final hasNumbers = value.contains(RegExp(r'[0-9]'));
    final hasSpecialCharacters = value.contains(
      RegExp(r'[!@#$%^&*(),.?":{}|<>]'),
    );

    if (!hasUpperCase ||
        !hasLowerCase ||
        !hasNumbers ||
        !hasSpecialCharacters) {
      return 'password_requirements'.tr();
    }

    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'confirm_password_required'.tr();
    }

    if (value != password) {
      return 'passwords_not_match'.tr();
    }

    return null;
  }

  static String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'fullname_required'.tr();
    }

    if (value.length < 2) {
      return 'fullname_length'.tr();
    }

    final hasSpecialCharacters = value.contains(
      RegExp(r'[!@#$%^&*(),.?":{}|<>]'),
    );

    if (hasSpecialCharacters) {
      return 'fullname_invalid'.tr();
    }

    return null;
  }
}
