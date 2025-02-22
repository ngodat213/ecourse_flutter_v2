import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../../core/base/base_view_model.dart';
import '../../core/config/app_config.dart';
import '../../core/routes/app_routes.dart';

class SplashVM extends BaseVM {
  final BuildContext context;

  SplashVM(this.context) {
    _init();
  }

  Future<void> _init() async {
    await Future.delayed(const Duration(seconds: 2));
    final prefs = Provider.of<SharedPreferences>(context, listen: false);
    final token = prefs.getString(AppConfig.tokenKey);

    if (token != null) {
      AppRoutes.pushAndRemoveUntil(context, AppRoutes.home);
    } else {
      AppRoutes.pushAndRemoveUntil(context, AppRoutes.login);
    }
  }
}
