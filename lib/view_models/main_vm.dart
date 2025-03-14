import 'dart:convert';

import 'package:ecourse_flutter_v2/core/base/base_view_model.dart';
import 'package:ecourse_flutter_v2/core/services/shared_prefs.dart';
import 'package:ecourse_flutter_v2/models/user_profile.dart';
import 'package:ecourse_flutter_v2/view_models/user_vm.dart';
import 'package:ecourse_flutter_v2/views/chat/chat_list_view.dart';
import 'package:ecourse_flutter_v2/views/explore/explore_view.dart';
import 'package:ecourse_flutter_v2/views/home/home_view.dart';
import 'package:ecourse_flutter_v2/views/setting/setting_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainVM extends BaseVM {
  MainVM(super.context) {
    _initFromSharedPrefs();
    _initializeScreens();
  }

  UserProfile? userProfile;

  String? userRole;

  int bottomNavigationIndex = 0;

  late List<Widget> screens;

  void changeBottomNavigationIndex(int index) {
    bottomNavigationIndex = index;
    notifyListeners();
  }

  void _initFromSharedPrefs() {
    final userData = context.read<UserVM>().userProfile;
    if (userData != null) {
      try {
        userProfile = userData;
        userRole = userData.user?.role;
      } catch (e) {
        print('Error parsing user data: $e');
      }
    }

    getUser();
  }

  void _initializeScreens() {
    if (userRole == 'instructor' || userRole == 'admin') {
      screens = [
        const HomeView(),
        const ExploreView(),
        const ChatListView(),
        const SettingView(),
      ];
    } else {
      screens = [
        const HomeView(),
        const ExploreView(),
        const ChatListView(),
        const SettingView(),
      ];
    }
    notifyListeners();
  }

  Future<void> getUser() async {
    final newProfile = context.read<UserVM>().userProfile;

    // Chỉ cập nhật UI và SharedPrefs nếu có thay đổi
    if (_hasUserDataChanged(newProfile)) {
      userProfile = newProfile;

      // Cập nhật role nếu thay đổi
      final newRole = newProfile?.user?.role ?? 'user';
      if (newRole != userRole) {
        userRole = newRole;
        await SharedPrefs.setString('user_role', newRole);
        _initializeScreens();
      }

      // Lưu lại thông tin user mới nhất
      await SharedPrefs.setString('user_data', json.encode(newProfile));
      notifyListeners();
    }
  }

  bool _hasUserDataChanged(UserProfile? newProfile) {
    if (userProfile == null) return true;

    // So sánh các trường quan trọng
    return userProfile!.user?.sId != newProfile?.user?.sId ||
        userProfile!.user?.role != newProfile?.user?.role ||
        userProfile!.user?.firstName != newProfile?.user?.firstName ||
        userProfile!.user?.lastName != newProfile?.user?.lastName ||
        userProfile!.user?.profilePicture != newProfile?.user?.profilePicture ||
        userProfile!.user?.status != newProfile?.user?.status;
  }
}
