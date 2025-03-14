import 'package:ecourse_flutter_v2/core/config/app_image.dart';
import 'package:ecourse_flutter_v2/core/utils/responsive_layout.dart';
import 'package:flutter/material.dart';
import '../../core/base/base_view.dart';
import '../../view_models/login_vm.dart';
import 'package:ecourse_flutter_v2/core/widgets/text_fields/base_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/utils/validator.dart';
import 'package:ecourse_flutter_v2/core/widgets/buttons/elevated_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class LoginView extends BaseView<LoginVM> {
  const LoginView({super.key});

  @override
  LoginVM createViewModel(
    BuildContext context,
    Map<String, dynamic>? arguments,
  ) {
    return LoginVM(context);
  }

  @override
  Widget buildView(BuildContext context, LoginVM viewModel) {
    return LoginMobileView(vm: viewModel);
  }
}

class LoginMobileView extends StatefulWidget {
  final LoginVM vm;

  const LoginMobileView({super.key, required this.vm});

  @override
  State<LoginMobileView> createState() => LoginMobileViewState();
}

class LoginMobileViewState extends State<LoginMobileView>
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
      if (widget.vm.error != null) {
        widget.vm.clearError();
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
    return SafeArea(
      child: SizedBox(
        width: 1.sw,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: ResponsiveLayout.isDesktop(context) ? 32.h : 0),
            SizedBox(
              width: ResponsiveLayout.isDesktop(context) ? 400.w : 1.sw,
              child: TabBar(
                controller: _tabController,
                tabs: [Tab(text: 'login'.tr()), Tab(text: 'register'.tr())],
                labelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColor.secondary,
                ),
                unselectedLabelStyle: Theme.of(
                  context,
                ).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColor.accent,
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: ResponsiveLayout.isDesktop(context) ? 400.w : 1.sw,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildLoginTab(context),
                    _buildRegisterTab(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginTab(BuildContext context) {
    return Form(
      key: widget.vm.loginFormKey,
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
                    AppImage.svgGoogle,
                    width: 23.w,
                    height: 23.h,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: SvgPicture.asset(
                    AppImage.svgFacebook,
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
                visible: widget.vm.error != null,
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
                        AppImage.svgInfo,
                        width: 16.w,
                        height: 16.h,
                        color: AppColor.error,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        widget.vm.error ?? '',
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
              controller: widget.vm.emailController,
              labelText: 'email'.tr(),
              prefixIcon: SvgPicture.asset(
                AppImage.svgUser,
                width: 16.w,
                height: 16.h,
              ),
              validator: (value) => Validator.validateEmail(value),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 16.h),
            Text(
              'password'.tr(),
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SizedBox(height: 8.h),
            BaseTextField(
              controller: widget.vm.passwordController,
              labelText: 'password'.tr(),
              prefixIcon: SvgPicture.asset(
                AppImage.svgLock,
                width: 16.w,
                height: 16.h,
              ),
              obscureText: true,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => widget.vm.login(),
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => widget.vm.forgotPassword(),
                child: Text(
                  'forgot_password'.tr(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColor.primary,
                  ),
                ),
              ),
            ),
            SizedBox(height: ResponsiveLayout.isDesktop(context) ? 32.h : 16.h),
            CustomElevatedButton(
              context: context,
              onPressed: () => widget.vm.login(),
              text: 'login'.tr(),
              width: 1.sw,
            ),
            SizedBox(height: 16.h),
            CustomElevatedButton(
              context: context,
              onPressed: () => {},
              backgroundColor: Colors.white,
              text: 'login_with_face_id'.tr(),
              width: 1.sw,
              leading: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: SvgPicture.asset(
                  AppImage.svgFaceId,
                  width: 24.w,
                  height: 24.h,
                ),
              ),
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
      key: widget.vm.registerFormKey,
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
                visible: widget.vm.error != null,
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
                        AppImage.svgInfo,
                        width: 16.w,
                        height: 16.h,
                        color: AppColor.error,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        widget.vm.error ?? '',
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(color: AppColor.error),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'first_name'.tr(),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    SizedBox(height: 8.h),
                    BaseTextField(
                      width: 1.sw / 2 - 16.w - 8.w,
                      controller: widget.vm.registerFirstNameController,
                      labelText: 'first_name'.tr(),
                      prefixIcon: SvgPicture.asset(
                        AppImage.svgUser,
                        width: 16.w,
                        height: 16.h,
                      ),
                      validator: (value) => Validator.validateFullName(value),
                      textInputAction: TextInputAction.next,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'last_name'.tr(),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    SizedBox(height: 8.h),
                    BaseTextField(
                      controller: widget.vm.registerLastNameController,
                      labelText: 'last_name'.tr(),
                      width: 1.sw / 2 - 16.w - 8.w,
                      prefixIcon: SvgPicture.asset(
                        AppImage.svgUser,
                        width: 16.w,
                        height: 16.h,
                      ),
                      validator: (value) => Validator.validateFullName(value),
                      textInputAction: TextInputAction.next,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              'email_address'.tr(),
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SizedBox(height: 8.h),
            BaseTextField(
              controller: widget.vm.registerEmailController,
              labelText: 'email'.tr(),
              prefixIcon: SvgPicture.asset(
                AppImage.svgMail,
                width: 16.w,
                height: 16.h,
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: (value) => Validator.validateEmail(value),
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 16.h),
            Text(
              'password'.tr(),
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SizedBox(height: 8.h),
            BaseTextField(
              controller: widget.vm.registerPasswordController,
              labelText: 'password'.tr(),
              prefixIcon: const Icon(Icons.lock),
              obscureText: true,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => widget.vm.register(),
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 16.h),
            Text(
              'confirm_password'.tr(),
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SizedBox(height: 8.h),
            BaseTextField(
              controller: widget.vm.registerConfirmPasswordController,
              labelText: 'confirm_password'.tr(),
              prefixIcon: const Icon(Icons.lock),
              obscureText: true,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => widget.vm.register(),
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: ResponsiveLayout.isDesktop(context) ? 32.h : 16.h),
            CustomElevatedButton(
              context: context,
              onPressed: () => widget.vm.register(),
              text: 'register'.tr(),
              width: 1.sw,
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
