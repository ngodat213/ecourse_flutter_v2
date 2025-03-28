import 'package:ecourse_flutter_v2/core/base/base_view.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/view_models/streak_vm.dart';
import 'package:ecourse_flutter_v2/views/streak/widget/user_streak.dart';
import 'package:flutter/material.dart';

class StreakView extends BaseView<StreakVM> {
  const StreakView({super.key});

  @override
  StreakVM createViewModel(
    BuildContext context,
    Map<String, dynamic>? arguments,
  ) {
    return StreakVM(context);
  }

  @override
  Widget buildView(BuildContext context, StreakVM vm) {
    return SafeArea(
      child: UserStreak(
        currentStreak: vm.userProfile?.user?.currentStreak ?? 0,
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, StreakVM vm) {
    return AppBar(
      backgroundColor: AppColor.background,
      title: Text('Streak', style: Theme.of(context).textTheme.titleLarge),
    );
  }
}
