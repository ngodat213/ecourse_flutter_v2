import 'package:ecourse_flutter_v2/app/data/models/notification_model.dart';
import 'package:ecourse_flutter_v2/app/data/models/user_profile.dart';
import 'package:ecourse_flutter_v2/app/data/repositories/notification_repository_impl.dart';
import 'package:ecourse_flutter_v2/app/domain/repositories/notification_repository.dart';
import 'package:ecourse_flutter_v2/core/base/base_view_model.dart';
import 'package:ecourse_flutter_v2/view_models/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationVM extends BaseVM {
  final NotificationRepository _repository;

  UserProfile? _userProfile;

  NotificationVM({
    required BuildContext context,
    NotificationRepository? repository,
  }) : _repository = repository ?? NotificationRepositoryImpl(),
       super(context);

  final List<NotificationModel> _notifications = [];

  List<NotificationModel> get notifications => _notifications;
  UserProfile? get userProfile => _userProfile;

  @override
  void onInit() {
    super.onInit();
    _userProfile = context.read<UserVM>().userProfile;
  }
}
