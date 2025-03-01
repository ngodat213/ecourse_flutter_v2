import 'package:easy_localization/easy_localization.dart';
import 'package:ecourse_flutter_v2/core/base/base_view.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_image.dart';
import 'package:ecourse_flutter_v2/core/widgets/elevated_button.dart';
import 'package:ecourse_flutter_v2/view_models/login_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ForgetPwView extends BaseView<LoginVM> {
  const ForgetPwView({super.key});

  @override
  LoginVM createViewModel(BuildContext context) {
    return LoginVM(context);
  }

  @override
  Widget buildView(BuildContext context, LoginVM viewModel) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () => viewModel.goBack(),
                  icon: SvgPicture.asset(
                    AppImage.svgArrowLeft,
                    width: 24.w,
                    height: 24.h,
                  ),
                ),
              ),
              Text(
                'forget_password'.tr(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 64.h),
              Text('enter_the_6_digit_code'.tr()),
              SizedBox(height: 32.h),
              OtpTextField(
                numberOfFields: 5,
                borderColor: AppColor.primary,
                showFieldAsBox: true,
                onCodeChanged: (String value) {
                  viewModel.onChangeOtp(value);
                },
                onSubmit: (String verificationCode) {
                  viewModel.verifyOtp();
                },
              ),
              SizedBox(height: 32.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('did_not_receive_the_code'.tr()),
                  TextButton(
                    onPressed: () => viewModel.resendOtp(),
                    child: Text('resend'.tr()),
                  ),
                ],
              ),
              Expanded(child: SizedBox()),
              CustomElevatedButton(
                context: context,
                onPressed: () => viewModel.verifyOtp(),
                text: 'verify'.tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
