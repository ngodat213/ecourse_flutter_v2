import 'package:easy_localization/easy_localization.dart';
import 'package:ecourse_flutter_v2/core/routes/app_routes.dart';
import 'package:ecourse_flutter_v2/core/repository/auth_repository.dart';
import 'package:ecourse_flutter_v2/core/services/shared_prefs.dart';
import 'package:flutter/material.dart';
import '../../core/base/base_view_model.dart';
import '../../core/utils/validator.dart';

class LoginVM extends BaseVM {
  final AuthRepository _authRepository = AuthRepository();
  LoginVM(super.context);

  final formKey = GlobalKey<FormState>();
  final emailController =
      TextEditingController()..text = 'ngodat.it213@gmail.com';
  final passwordController = TextEditingController()..text = '123456789';
  final registerFormKey = GlobalKey<FormState>();
  final registerNameController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();

  String otp = '';

  Future<void> login() async {
    try {
      // if (!formKey.currentState!.validate()) {
      //   setError('invalid_email_or_password'.tr());
      //   return;
      // } else {
      //   setError(null);
      // }

      // final response = await _authRepository.login(
      //   emailController.text,
      //   passwordController.text,
      // );

      // if (response.allGood) {
      //   final token = response.body['access_token'];
      //   final refreshToken = response.body['refresh_token'];

      //   await SharedPrefs.setToken(token);
      //   await SharedPrefs.setRefreshToken(refreshToken);
      AppRoutes.pushAndRemoveUntil(context, AppRoutes.home);
      // } else {
      //   setError(response.message ?? 'error_occurred'.tr());
      // }
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

  Future<void> loginWithFaceId() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  void onChangeOtp(String value) {
    otp = value;
  }

  Future<void> forgotPassword() async {
    AppRoutes.push(context, AppRoutes.verifyOtp);
  }

  Future<void> resendOtp() async {
    AppRoutes.push(context, AppRoutes.verifyOtp);
  }

  Future<void> verifyOtp() async {
    AppRoutes.push(context, AppRoutes.home);
  }

  void goBack() {
    AppRoutes.pop(context);
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
