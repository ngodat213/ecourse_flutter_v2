import 'package:ecourse_flutter_v2/core/base/base_view.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_image.dart';
import 'package:ecourse_flutter_v2/view_models/home_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MainView extends BaseView<HomeVM> {
  const MainView({super.key});

  @override
  HomeVM createViewModel(BuildContext context) {
    return HomeVM(context);
  }

  @override
  Widget? buildBottomNavigationBar(BuildContext context, HomeVM vm) {
    final bottomNavigationBarItems = [
      {'icon': AppImage.svgHome, 'label': 'Home', 'index': 0},
      {'icon': AppImage.svgExplore, 'label': 'Explore', 'index': 1},
      {'icon': AppImage.svgEvents, 'label': 'Events', 'index': 2},
      {'icon': AppImage.svgProfile, 'label': 'Profile', 'index': 3},
    ];
    return BottomNavigationBar(
      currentIndex: vm.bottomNavigationIndex,
      onTap: (index) {
        vm.changeBottomNavigationIndex(index);
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColor.background,
      items:
          bottomNavigationBarItems.map((item) {
            return BottomNavigationBarItem(
              icon: SvgPicture.asset(
                item['icon'] as String,
                width: 18.w,
                height: 18.h,
                color:
                    vm.bottomNavigationIndex == item['index']
                        ? AppColor.primary
                        : AppColor.textSecondary,
              ),
              label: item['label'] as String,
            );
          }).toList(),
      selectedItemColor: AppColor.primary,
      unselectedItemColor: AppColor.textSecondary,
      selectedLabelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 10.sp,
      ),
      unselectedLabelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 10.sp,
      ),
    );
  }

  @override
  Widget buildView(BuildContext context, HomeVM vm) {
    return SafeArea(
      child: IndexedStack(
        index: vm.bottomNavigationIndex,
        children: vm.screens, // Danh sách màn hình từ HomeVM
      ),
    );
  }
}
