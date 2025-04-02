import 'package:ecourse_flutter_v2/core/providers/theme_provider.dart';
import 'package:ecourse_flutter_v2/core/providers/chat_provider.dart';
import 'package:ecourse_flutter_v2/core/services/shared_prefs.dart';
import 'package:ecourse_flutter_v2/view_models/chat_vm.dart';
import 'package:ecourse_flutter_v2/view_models/course_learn_vm.dart';
import 'package:ecourse_flutter_v2/view_models/user_vm.dart';
import 'package:ecourse_flutter_v2/view_models/login_vm.dart';
import 'package:ecourse_flutter_v2/view_models/course_detail_vm.dart';
import 'package:ecourse_flutter_v2/view_models/explore_vm.dart';
import 'package:ecourse_flutter_v2/view_models/home_vm.dart';
import 'package:ecourse_flutter_v2/view_models/my_profile_vm.dart';
import 'package:ecourse_flutter_v2/view_models/teacher_profile_vm.dart';
import 'package:ecourse_flutter_v2/view_models/profile_vm.dart';
import 'package:ecourse_flutter_v2/view_models/teacher_vm.dart';
import 'package:ecourse_flutter_v2/view_models/learning_streak_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppProvider {
  AppProvider._();

  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(SharedPrefs.getThemeMode(), context),
    ),
    ChangeNotifierProvider(create: (context) => ChatProvider()),
    ChangeNotifierProvider(create: (context) => UserVM(context)),
    ChangeNotifierProvider(create: (context) => LoginVM(context)),
    ChangeNotifierProvider(create: (context) => HomeVM(context)),
    ChangeNotifierProvider(create: (context) => TeacherVM(context)),
    ChangeNotifierProvider(create: (context) => ExploreVM(context)),
    ChangeNotifierProvider(create: (context) => ChatVM(context)),
    ChangeNotifierProvider(create: (context) => ProfileVM(context)),
    ChangeNotifierProvider(create: (context) => MyProfileVM(context)),
    ChangeNotifierProvider(create: (context) => TeacherProfileVM(context)),
    ChangeNotifierProvider(create: (context) => CourseDetailVM(context)),
    ChangeNotifierProvider(create: (context) => CourseLearnVM(context, null)),
    ChangeNotifierProvider(
      create: (context) => LearningStreakVM(context),
      lazy: false,
    ),
  ];

  static void disposeProviders(BuildContext context) {
    context.read<UserVM>().dispose();
    context.read<LoginVM>().dispose();
    context.read<HomeVM>().dispose();
    context.read<TeacherVM>().dispose();
    context.read<ExploreVM>().dispose();
    context.read<ChatVM>().dispose();
    context.read<MyProfileVM>().dispose();
    context.read<ProfileVM>().dispose();
    context.read<TeacherProfileVM>().dispose();
    context.read<ThemeProvider>().dispose();
    context.read<CourseDetailVM>().dispose();
    context.read<CourseLearnVM>().dispose();
    context.read<LearningStreakVM>().dispose();
    context.read<ChatProvider>().dispose();
  }
}
