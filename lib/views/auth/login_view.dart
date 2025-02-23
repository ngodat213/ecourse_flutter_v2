import 'package:easy_localization/easy_localization.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/utils/validator.dart';
import 'package:ecourse_flutter_v2/core/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/base/base_view.dart';
import '../../view_models/login_vm.dart';
import '../../core/widgets/base_text_field.dart';

class LoginView extends BaseView<LoginVM> {
  const LoginView({super.key});

  @override
  LoginVM createViewModel(BuildContext context) {
    return LoginVM(context: context);
  }

  @override
  Widget buildView(BuildContext context, LoginVM viewModel) {
    return _LoginContent(viewModel: viewModel);
  }
}

class _LoginContent extends StatefulWidget {
  final LoginVM viewModel;

  const _LoginContent({required this.viewModel});

  @override
  State<_LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<_LoginContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _setupListeners();
  }

  void _setupListeners() {
    _tabController.addListener(() {
      if (widget.viewModel.error != null) {
        widget.viewModel.clearError();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              tabs: [Tab(text: 'login'.tr()), Tab(text: 'register'.tr())],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [_buildLoginTab(context), _buildRegisterTab(context)],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginTab(BuildContext context) {
    return Form(
      key: widget.viewModel.formKey,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/svgs/google.svg',
                    width: 23.w,
                    height: 23.h,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/svgs/facebook.svg',
                    width: 23.w,
                    height: 23.h,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Center(child: Text('Or use your email account login'.tr())),
            SizedBox(height: 32.h),
            SizedBox(
              height: 48.h,
              child: Visibility(
                visible: widget.viewModel.error != null,
                child: Container(
                  height: 48.h,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: AppColor.errorBackground,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/svgs/info.svg',
                        width: 16.w,
                        height: 16.h,
                        color: AppColor.error,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        widget.viewModel.error ?? '',
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(color: AppColor.error),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'email_address'.tr(),
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SizedBox(height: 8.h),
            BaseTextField(
              controller: widget.viewModel.emailController,
              labelText: 'email'.tr(),
              prefixIcon: SvgPicture.asset(
                'assets/svgs/user.svg',
                width: 16.w,
                height: 16.h,
              ),
              validator: (value) => Validator.validateEmail(value),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16.h),
            Text(
              'password'.tr(),
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SizedBox(height: 8.h),
            BaseTextField(
              controller: widget.viewModel.passwordController,
              labelText: 'password'.tr(),
              prefixIcon: SvgPicture.asset(
                'assets/svgs/lock.svg',
                width: 16.w,
                height: 16.h,
              ),
              obscureText: true,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => widget.viewModel.login(),
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            Expanded(child: SizedBox()),
            CustomElevatedButton(
              context: context,
              onPressed: () => widget.viewModel.login(),
              text: 'login'.tr(),
            ),
            SizedBox(height: 16.h),
            CustomElevatedButton(
              context: context,
              onPressed: () => widget.viewModel.login(),
              backgroundColor: Colors.white,
              text: 'sign_up'.tr(),
              textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColor.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterTab(BuildContext context) {
    return Form(
      key: widget.viewModel.registerFormKey,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            Center(child: Text('enter_your_details_below_free_sign_up'.tr())),
            SizedBox(height: 32.h),
            SizedBox(
              height: 48.h,
              child: Visibility(
                visible: widget.viewModel.error != null,
                child: Container(
                  height: 48.h,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: AppColor.errorBackground,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/svgs/info.svg',
                        width: 16.w,
                        height: 16.h,
                        color: AppColor.error,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        widget.viewModel.error ?? '',
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(color: AppColor.error),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'fullname'.tr(),
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SizedBox(height: 8.h),
            BaseTextField(
              controller: widget.viewModel.registerNameController,
              labelText: 'email'.tr(),
              prefixIcon: SvgPicture.asset(
                'assets/svgs/user.svg',
                width: 16.w,
                height: 16.h,
              ),
              validator: (value) => Validator.validateFullName(value),
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 16.h),
            Text(
              'email_address'.tr(),
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SizedBox(height: 8.h),
            BaseTextField(
              controller: widget.viewModel.registerEmailController,
              labelText: 'email'.tr(),
              prefixIcon: SvgPicture.asset(
                'assets/svgs/mail.svg',
                width: 16.w,
                height: 16.h,
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: (value) => Validator.validateEmail(value),
            ),
            SizedBox(height: 16.h),
            Text(
              'password'.tr(),
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SizedBox(height: 8.h),
            BaseTextField(
              controller: widget.viewModel.registerPasswordController,
              labelText: 'password'.tr(),
              prefixIcon: const Icon(Icons.lock),
              obscureText: true,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => widget.viewModel.register(),
              validator: (value) => Validator.validatePassword(value),
            ),
            SizedBox(height: 16.h),
            Text(
              'confirm_password'.tr(),
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SizedBox(height: 8.h),
            BaseTextField(
              controller: widget.viewModel.registerConfirmPasswordController,
              labelText: 'confirm_password'.tr(),
              prefixIcon: const Icon(Icons.lock),
              obscureText: true,
              textInputAction: TextInputAction.done,
              validator: (value) => Validator.validatePassword(value),
              onSubmitted: (_) => widget.viewModel.register(),
            ),
            Expanded(child: SizedBox()),
            CustomElevatedButton(
              context: context,
              onPressed: () => widget.viewModel.register(),
              text: 'register'.tr(),
            ),
          ],
        ),
      ),
    );
  }
}

class IconButton extends StatelessWidget {
  const IconButton({super.key, required this.icon, required this.onPressed});

  final Widget icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        padding: EdgeInsets.all(8.h),
      ),
      child: icon,
    );
  }
}
