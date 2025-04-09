import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_image.dart';
import 'package:ecourse_flutter_v2/core/routes/app_routes.dart';
import 'package:ecourse_flutter_v2/core/widgets/buttons/svg_icon_button.dart';
import 'package:ecourse_flutter_v2/views/home/widget/course_list_card.dart';
import 'package:ecourse_flutter_v2/views/home/widget/course_progress_card.dart';
import 'package:ecourse_flutter_v2/views/home/widget/home_app_bar.dart';
import 'package:ecourse_flutter_v2/views/home/widget/notification_schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/base/base_view.dart';
import '../../view_models/home_vm.dart';

class HomeView extends BaseView<HomeVM> {
  const HomeView({super.key});

  @override
  HomeVM createViewModel(
    BuildContext context,
    Map<String, dynamic>? arguments,
  ) {
    return HomeVM(context);
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, HomeVM vm) {
    return AppBar(
      title: GestureDetector(
        onTap: () {
          AppRoutes.push(context, AppRoutes.profile);
        },
        child: HomeAppBar(vm: vm),
      ),
      centerTitle: false,
      backgroundColor: AppColor.background,
      actions: [
        SvgIconButton(
          assetName: AppImage.svgBell,
          onPressed: () {
            vm.redirectToNotification();
          },
        ),
        SvgIconButton(
          assetName: AppImage.svgCart,
          onPressed: () {
            vm.redirectToCart();
          },
        ),
      ],
    );
  }

  @override
  Widget buildView(BuildContext context, HomeVM vm) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NotificationSchedule(),
            // PromotionSliderWidget(vm: vm),
            SizedBox(height: 16.h),
            CourseProgressCard(
              enrolledCourses: vm.userProfile?.user?.enrolledCourses ?? [],
              courseProgress: vm.courseProgress,
            ),
            CourseListView(vm: vm),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
