import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../core/base/base_view_model.dart';
import '../core/routes/app_routes.dart';
import '../core/services/shared_prefs.dart';

class LoginVM extends BaseVM {
  // Login controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Register controllers
  final TextEditingController registerNameController = TextEditingController();
  final TextEditingController registerEmailController = TextEditingController();
  final TextEditingController registerPasswordController =
      TextEditingController();

  Future<void> login(BuildContext context) async {
    try {
      setLoading(true);

      // Validate inputs
      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        setError('please_fill_all_fields'.tr());
        return;
      }

      // TODO: Call login API
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      // Save token
      await SharedPrefs.setToken('dummy_token');

      // Navigate to home
      AppRoutes.pushAndRemoveUntil(context, AppRoutes.home);
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> register() async {
    try {
      setLoading(true);

      // Validate inputs
      if (registerNameController.text.isEmpty ||
          registerEmailController.text.isEmpty ||
          registerPasswordController.text.isEmpty) {
        setError('please_fill_all_fields'.tr());
        return;
      }

      // TODO: Call register API
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      // Clear register form
      registerNameController.clear();
      registerEmailController.clear();
      registerPasswordController.clear();
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    registerNameController.dispose();
    registerEmailController.dispose();
    registerPasswordController.dispose();
    super.dispose();
  }
}
