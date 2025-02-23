import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../core/base/base_view_model.dart';
import '../../core/utils/validator.dart';

class LoginVM extends BaseVM {
  final BuildContext context;

  LoginVM({required this.context});

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final registerFormKey = GlobalKey<FormState>();
  final registerNameController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();

  Future<void> login() async {
    try {
      if (!formKey.currentState!.validate()) {
        setError('invalid_email_or_password'.tr());
        return;
      } else {
        setError(null);
      }

      // await SharedPrefs.setToken('dummy_token');
      // AppRoutes.pushAndRemoveUntil(context, AppRoutes.home);
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> register() async {
    try {
      if (registerPasswordController.text !=
          registerConfirmPasswordController.text) {
        setError('passwords_not_match'.tr());
        return;
      }

      if (registerNameController.text.isEmpty) {
        setError('fullname_required'.tr());
        return;
      }

      if (registerEmailController.text.isEmpty) {
        setError('email_required'.tr());
        return;
      }

      if (registerPasswordController.text.isEmpty) {
        setError('password_required'.tr());
        return;
      }

      if (registerConfirmPasswordController.text.isEmpty) {
        setError('confirm_password_required'.tr());
        return;
      }

      if (!registerFormKey.currentState!.validate()) {
        setError('invalid_email_or_password'.tr());
        return;
      } else {
        setError(null);
      }

      setLoading(true);
      // TODO: Call register API
      await Future.delayed(const Duration(seconds: 2));

      // Clear form and switch to login tab
      registerNameController.clear();
      registerEmailController.clear();
      registerPasswordController.clear();
      registerConfirmPasswordController.clear();
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  String? validateEmail(String? value) => Validator.validateEmail(value);
  String? validatePassword(String? value) => Validator.validatePassword(value);
  String? validateFullName(String? value) => Validator.validateFullName(value);

  String? validateConfirmPassword(String? value) {
    return Validator.validateConfirmPassword(
      value,
      registerPasswordController.text,
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    registerNameController.dispose();
    registerEmailController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();
    super.dispose();
  }
}
