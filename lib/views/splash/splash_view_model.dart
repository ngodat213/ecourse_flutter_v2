import 'package:ecourse_flutter_v2/core/services/shared_prefs.dart';
import '../../core/base/base_view_model.dart';
import '../../core/routes/app_routes.dart';

class SplashVM extends BaseVM {
  SplashVM(super.context);

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2), () {
      getStartRoute();
    });
  }

  void getStartRoute() {
    final isOnboardingSkipped = SharedPrefs.getBool('is_onboarding_skipped');
    if (isOnboardingSkipped == null) {
      AppRoutes.pushAndRemoveUntil(context, AppRoutes.onboarding);
    } else {
      AppRoutes.pushAndRemoveUntil(context, AppRoutes.login);
    }
  }
}
