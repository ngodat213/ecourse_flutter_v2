import 'package:ecourse_flutter_v2/app/domain/repositories/auth_repository.dart';
import 'package:ecourse_flutter_v2/app/domain/repositories/user_repository.dart';
import 'package:ecourse_flutter_v2/core/base/base_view_model.dart';
import 'package:ecourse_flutter_v2/app/data/repositories/auth_repository_impl.dart';
import 'package:ecourse_flutter_v2/app/data/repositories/user_repository_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

mixin LoginFormMixin on BaseVM {
  final UserRepository userRepository = UserRepositoryImpl();
  final AuthRepository authRepository = AuthRepositoryImpl();

  final loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void initializeDebugCredentials() {
    if (kDebugMode) {
      emailController.text = 'ngodat.it213@gmail.com';
      passwordController.text = '123456789';
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

mixin RegisterFormMixin on BaseVM {
  final registerFormKey = GlobalKey<FormState>();
  final registerFirstNameController = TextEditingController();
  final registerLastNameController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();

  @override
  void dispose() {
    registerFirstNameController.dispose();
    registerLastNameController.dispose();
    registerEmailController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();
    super.dispose();
  }
}
