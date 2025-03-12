import 'package:easy_localization/easy_localization.dart';
import 'package:ecourse_flutter_v2/core/config/app_config.dart';
import 'package:ecourse_flutter_v2/core/routes/app_routes.dart';
import 'package:ecourse_flutter_v2/core/services/base_api.dart';
import 'package:ecourse_flutter_v2/mixin/login_form_mixin.dart';
import 'package:ecourse_flutter_v2/models/user_profile.dart';
import 'package:ecourse_flutter_v2/repositories/auth_repository.dart';
import 'package:ecourse_flutter_v2/repositories/user_repository.dart';
import 'package:ecourse_flutter_v2/view_models/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/base/base_view_model.dart';
import '../../../../core/utils/validator.dart';
import 'package:ecourse_flutter_v2/core/services/shared_prefs.dart';

class LoginVM extends BaseVM with LoginFormMixin, RegisterFormMixin {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  LoginVM(
    super.context, {
    AuthRepository? authRepository,
    UserRepository? userRepository,
  }) : _authRepository = authRepository ?? AuthRepository(),
       _userRepository = userRepository ?? UserRepository();

  // OTP state
  String _otpCode = '';
  String? _userId;
  String? _verificationToken;
  bool _isResendEnabled = true;
  int _resendCountdown = 60;

  bool _isLoading = false;
  String? _error;

  // Getters
  @override
  bool get isLoading => _isLoading;
  @override
  String? get error => _error;
  bool get isResendEnabled => _isResendEnabled;
  int get resendCountdown => _resendCountdown;

  @override
  void onInit() {
    initializeDebugCredentials();
  }

  @override
  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Đăng nhập
  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    try {
      _setLoading(true);
      final response = await _authRepository.login(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      if (response.allGood) {
        await _handleLoginResponse(response);

        await _loadUserProfile();
        _setError(null);

        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      } else {
        _setError(response.message ?? 'Đăng nhập thất bại');
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> _handleLoginResponse(ApiResponse response) async {
    if (!response.allGood) {
      _setError(response.message);
      await _clearTokens();
      return false;
    }

    final data = response.body;
    await _saveToken(data);
    await _saveLoginCredentials();
    return true;
  }

  Future<void> _saveToken(Map<String, dynamic> data) async {
    await SharedPrefs.setToken(data['access_token']);
    await SharedPrefs.setRefreshToken(data['refresh_token']);
  }

  Future<void> _saveLoginCredentials() async {
    await SharedPrefs.setString('saved_email', emailController.text.trim());
    await SharedPrefs.setString('saved_password', passwordController.text);
  }

  Future<bool> _loadUserProfile() async {
    final profileResponse = await _userRepository.getUserProfile();
    if (!profileResponse.allGood) {
      _setError(profileResponse.message);
      await _clearTokens();
      return false;
    }

    await _saveUserData(profileResponse.body);
    return true;
  }

  Future<void> _saveUserData(Map<String, dynamic> userData) async {
    await SharedPrefs.setUser(UserProfile.fromJson(userData));
    await SharedPrefs.setString(
      AppConfig.userRoleKey,
      userData['role'] ?? 'user',
    );
    await SharedPrefs.setString(
      AppConfig.userIdKey,
      userData['id']?.toString() ?? '',
    );
    context.read<UserVM>().setUserProfile(UserProfile.fromJson(userData));
  }

  Future<void> _clearTokens() async {
    await SharedPrefs.removeToken();
    await SharedPrefs.removeRefreshToken();
  }

  // Đăng ký
  Future<void> register() async {
    if (!registerFormKey.currentState!.validate()) return;

    if (registerPasswordController.text !=
        registerConfirmPasswordController.text) {
      _setError('Mật khẩu không khớp');
      return;
    }

    try {
      _setLoading(true);

      // Tách họ và tên
      final fullName = registerNameController.text.trim();
      final nameParts = fullName.split(' ');
      final lastName = nameParts.length > 1 ? nameParts.last : '';
      final firstName =
          nameParts.length > 1
              ? nameParts.sublist(0, nameParts.length - 1).join(' ')
              : fullName;

      final response = await _authRepository.register(
        firstName: firstName,
        lastName: lastName,
        email: registerEmailController.text.trim(),
        password: registerPasswordController.text,
      );

      if (response.allGood) {
        // Hiển thị thông báo thành công
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Đăng ký thành công. Vui lòng kiểm tra email để xác thực tài khoản.',
            ),
          ),
        );

        // Reset form
        registerNameController.clear();
        registerEmailController.clear();
        registerPasswordController.clear();
        registerConfirmPasswordController.clear();
      } else {
        _setError(response.message ?? 'Đăng ký thất bại');
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Xử lý OTP
  void onChangeOtp(String value) {
    _otpCode = value;
    notifyListeners();
  }

  Future<void> verifyOtp() async {
    if (_otpCode.length != 5) {
      _setError('Vui lòng nhập đủ mã OTP');
      return;
    }

    try {
      _setLoading(true);
      final response = await _authRepository.verifyOTP(
        email: emailController.text.trim(),
        otp: _otpCode,
      );

      if (response.allGood) {
        // Nếu đang trong luồng quên mật khẩu
        if (_verificationToken != null) {
          Navigator.pushNamed(
            context,
            '/reset-password',
            arguments: {'token': _verificationToken},
          );
        } else {
          // Nếu đang trong luồng xác thực email
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('verify_success'.tr())));
          Navigator.pushReplacementNamed(context, '/login');
        }
      } else {
        _setError(response.message ?? 'verify_failed'.tr());
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> resendOtp() async {
    if (!_isResendEnabled) return;

    try {
      _setLoading(true);
      final response = await _authRepository.resendOTP(
        userId: _userId ?? '',
        type: _verificationToken != null ? 'reset' : 'verification',
      );

      if (response.allGood) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('otp_resent'.tr())));
        _startResendCooldown();
      } else {
        _setError(response.message ?? 'resend_failed'.tr());
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  void _startResendCooldown() {
    _isResendEnabled = false;
    _resendCountdown = 60;
    notifyListeners();

    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      _resendCountdown--;
      notifyListeners();

      if (_resendCountdown <= 0) {
        _isResendEnabled = true;
        notifyListeners();
        return false;
      }
      return true;
    });
  }

  // Quên mật khẩu
  Future<void> forgotPassword() async {
    if (emailController.text.isEmpty) {
      _setError('Vui lòng nhập email');
      return;
    }

    try {
      _setLoading(true);
      final response = await _authRepository.forgotPasswordMobile(
        email: emailController.text.trim(),
      );

      if (response.allGood) {
        _userId = response.body['userId'];
        _verificationToken = response.body['token'];

        // Chuyển đến màn hình nhập OTP
        Navigator.pushNamed(context, '/verify-otp');
      } else {
        _setError(response.message ?? 'forgot_password_failed'.tr());
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Đặt lại mật khẩu
  Future<void> resetPassword(String newPassword) async {
    if (_verificationToken == null) {
      _setError('invalid_token'.tr());
      return;
    }

    try {
      _setLoading(true);
      final response = await _authRepository.resetPassword(
        token: _verificationToken!,
        newPassword: newPassword,
      );

      if (response.allGood) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('reset_password_success'.tr())));
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        _setError(response.message ?? 'reset_password_failed'.tr());
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? value) {
    _error = value;
    notifyListeners();
  }

  void goBack() {
    AppRoutes.pop(context);
  }

  String? validateEmail(String? value) => Validator.validateEmail(value);
  String? validatePassword(String? value) => Validator.validatePassword(value);
  String? validateFullName(String? value) => Validator.validateFullName(value);

  String? validateConfirmPassword(String? value) {
    return Validator.validateConfirmPassword(
      value,
      registerPasswordController.text,
    );
  }
}
