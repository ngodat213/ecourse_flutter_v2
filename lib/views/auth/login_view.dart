import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/base/base_view.dart';
import '../../view_models/login_vm.dart';
import '../../core/widgets/base_text_field.dart';

class LoginView extends BaseView<LoginVM> {
  const LoginView({super.key});

  @override
  LoginVM createViewModel(BuildContext context) {
    return LoginVM();
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            controller: _tabController,
            tabs: [Tab(text: 'login'.tr()), Tab(text: 'register'.tr())],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [_buildLoginTab(context), _buildRegisterTab(context)],
        ),
      ),
    );
  }

  Widget _buildLoginTab(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BaseTextField(
            controller: widget.viewModel.emailController,
            labelText: 'email'.tr(),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: 16.h),
          BaseTextField(
            controller: widget.viewModel.passwordController,
            labelText: 'password'.tr(),
            prefixIcon: const Icon(Icons.lock),
            obscureText: true,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => widget.viewModel.login(context),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () => widget.viewModel.login(context),
            child: Text('login'.tr()),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterTab(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BaseTextField(
            controller: widget.viewModel.registerNameController,
            labelText: 'name'.tr(),
            prefixIcon: const Icon(Icons.person),
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: 16.h),
          BaseTextField(
            controller: widget.viewModel.registerEmailController,
            labelText: 'email'.tr(),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: 16.h),
          BaseTextField(
            controller: widget.viewModel.registerPasswordController,
            labelText: 'password'.tr(),
            prefixIcon: const Icon(Icons.lock),
            obscureText: true,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => widget.viewModel.register(),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: widget.viewModel.register,
            child: Text('register'.tr()),
          ),
        ],
      ),
    );
  }
}
