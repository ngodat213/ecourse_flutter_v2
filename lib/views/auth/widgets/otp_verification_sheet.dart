import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/widgets/buttons/elevated_button.dart';

class OTPVerificationSheet extends StatelessWidget {
  final String email;
  final Function(String) onVerify;
  final VoidCallback onResend;
  final bool isResendEnabled;
  final int resendCountdown;
  final bool isLoading;

  const OTPVerificationSheet({
    super.key,
    required this.email,
    required this.onVerify,
    required this.onResend,
    required this.isResendEnabled,
    required this.resendCountdown,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Verification Email',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8.h),
          RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 14.sp, color: AppColor.textSecondary),
              children: [
                const TextSpan(text: 'OTP code has been sent to '),
                TextSpan(
                  text: email,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // OTP Input
          Text(
            'Kode OTP',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 8.h),
          PinCodeTextField(
            appContext: context,
            length: 6,
            onChanged: (value) {},
            onCompleted: onVerify,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(8.r),
              fieldHeight: 48.h,
              fieldWidth: 48.w,
              activeFillColor: Colors.white,
              inactiveFillColor: Colors.white,
              selectedFillColor: Colors.white,
              activeColor: AppColor.primary,
              inactiveColor: AppColor.border,
              selectedColor: AppColor.primary,
            ),
            cursorColor: AppColor.primary,
            animationDuration: const Duration(milliseconds: 300),
            enableActiveFill: true,
            keyboardType: TextInputType.number,
            beforeTextPaste: (text) => true,
          ),
          SizedBox(height: 16.h),

          // Resend Button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Resend OTP code ',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColor.textSecondary,
                ),
              ),
              if (!isResendEnabled) ...[
                Text(
                  '00:${resendCountdown.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColor.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ] else
                GestureDetector(
                  onTap: onResend,
                  child: Text(
                    'Resend',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColor.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.h),

          // Verify Button
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else
            CustomElevatedButton(
              context: context,
              onPressed: () {},
              text: 'Verify',
              width: 1.sw,
            ),
        ],
      ),
    );
  }
}
