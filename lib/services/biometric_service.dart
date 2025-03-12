import 'package:ecourse_flutter_v2/core/config/app_constants.dart';
import 'package:local_auth/local_auth.dart';

class BiometricAuth {
  final LocalAuthentication _localAuth;
  bool _canCheckBiometrics = false;

  BiometricAuth() : _localAuth = LocalAuthentication();

  Future<void> initialize() async {
    try {
      _canCheckBiometrics = await _localAuth.canCheckBiometrics;
    } catch (e) {
      _canCheckBiometrics = false;
    }
  }

  Future<bool> authenticate() async {
    if (!_canCheckBiometrics) return false;

    try {
      return await _localAuth.authenticate(
        localizedReason: AppConstants.biometricReason,
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } catch (e) {
      return false;
    }
  }
}
