import 'package:easy_localization/easy_localization.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/widgets/text_fields/base_text_field.dart';
import 'package:ecourse_flutter_v2/view_models/profile_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordSecurityView extends StatefulWidget {
  const PasswordSecurityView({super.key});

  @override
  State<PasswordSecurityView> createState() => _PasswordSecurityViewState();
}

class _PasswordSecurityViewState extends State<PasswordSecurityView> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final bool _obscureCurrentPassword = true;
  final bool _obscureNewPassword = true;
  final bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('password_security'.tr()),
        backgroundColor: AppColor.background,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'current_password'.tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: 8.h),
            BaseTextField(
              controller: _currentPasswordController,
              hintText: 'enter_current_password'.tr(),
              obscureText: _obscureCurrentPassword,
            ),
            SizedBox(height: 16.h),
            Text(
              'new_password'.tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: 8.h),
            BaseTextField(
              controller: _newPasswordController,
              hintText: 'enter_new_password'.tr(),
              obscureText: _obscureNewPassword,
            ),
            SizedBox(height: 16.h),
            Text(
              'confirm_password'.tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: 8.h),
            BaseTextField(
              controller: _confirmPasswordController,
              hintText: 'enter_confirm_password'.tr(),
              obscureText: _obscureConfirmPassword,
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: () {
                // Validate passwords
                if (_newPasswordController.text !=
                    _confirmPasswordController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('passwords_not_match'.tr()),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                // TODO: Call API to change password
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primary,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'update_password'.tr(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
