import 'package:flutter/material.dart';
import '../../core/base/base_view.dart';
import 'splash_view_model.dart';

class SplashView extends BaseView<SplashVM> {
  const SplashView({super.key});

  @override
  SplashVM createViewModel(BuildContext context) {
    return SplashVM(context);
  }

  @override
  Widget buildView(BuildContext context, SplashVM viewModel) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
