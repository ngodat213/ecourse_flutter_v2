import 'dart:ui';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'base_view_model.dart';

abstract class BaseView<T extends BaseVM> extends StatelessWidget {
  const BaseView({super.key});

  T createViewModel(BuildContext context, Map<String, dynamic>? arguments);

  Widget buildView(BuildContext context, T viewModel);

  PreferredSizeWidget? buildAppBar(BuildContext context, T viewModel) {
    return null;
  }

  Widget? buildBottomNavigationBar(BuildContext context, T viewModel) {
    return null;
  }

  Widget? buildFloatingActionButton(BuildContext context, T viewModel) {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return ChangeNotifierProvider<T>(
      create: (context) {
        final viewModel = createViewModel(context, arguments);
        WidgetsBinding.instance.addPostFrameCallback((_) => viewModel.onInit());
        return viewModel;
      },
      child: Consumer<T>(
        builder: (context, viewModel, _) {
          return Scaffold(
            appBar: buildAppBar(context, viewModel),
            backgroundColor: AppColor.background,
            body: Stack(
              children: [
                buildView(context, viewModel),
                if (viewModel.isLoading) _customLoadingProgress(context),
              ],
            ),
            bottomNavigationBar: buildBottomNavigationBar(context, viewModel),
            floatingActionButton: buildFloatingActionButton(context, viewModel),
          );
        },
      ),
    );
  }

  Container _customLoadingProgress(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.3),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: AppColor.cardColor,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 50.w,
                  height: 50.w,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColor.primary),
                    strokeWidth: 3.w,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Loading...',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
