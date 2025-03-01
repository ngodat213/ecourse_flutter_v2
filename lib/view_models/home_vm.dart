import 'package:ecourse_flutter_v2/core/repository/user_repository.dart';
import 'package:ecourse_flutter_v2/core/routes/app_routes.dart';
import 'package:ecourse_flutter_v2/models/user_profile.dart';
import 'package:ecourse_flutter_v2/views/home/event_view.dart';
import 'package:ecourse_flutter_v2/views/home/explore_view.dart';
import 'package:ecourse_flutter_v2/views/home/home_view.dart';
import 'package:ecourse_flutter_v2/views/home/profile_view.dart';
import 'package:flutter/material.dart';

import '../core/base/base_view_model.dart';

class HomeVM extends BaseVM {
  final UserRepository _userRepository = UserRepository();
  int carouselIndex = 0;
  UserProfile? userProfile;
  int bottomNavigationIndex = 0;
  HomeVM(super.context);

  @override
  void onInit() {
    super.onInit();
    getUser();
    notifyListeners();
  }

  void changeBottomNavigationIndex(int index) {
    bottomNavigationIndex = index;
    notifyListeners();
  }

  List<Widget> screens = [
    const HomeView(),
    const ExploreView(),
    const EventsView(),
    const ProfileView(),
  ];

  Future<void> getUser() async {
    setLoading(true);
    final response = await _userRepository.getUserProfile();

    if (response.allGood) {
      userProfile = UserProfile.fromJson(response.body);
    }
    setLoading(false);
  }

  void redirectToAdmin() {
    if (userProfile?.user?.role == 'admin') {
      AppRoutes.push(context, AppRoutes.adminDashboard);
    }
  }
}
