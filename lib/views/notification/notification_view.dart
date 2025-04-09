import 'package:easy_localization/easy_localization.dart';
import 'package:ecourse_flutter_v2/core/base/base_view.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_image.dart';
import 'package:ecourse_flutter_v2/view_models/notification_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationView extends BaseView<NotificationVM> {
  const NotificationView({super.key});

  @override
  NotificationVM createViewModel(
    BuildContext context,
    Map<String, dynamic>? args,
  ) {
    return NotificationVM(context: context);
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, NotificationVM vm) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColor.background,
      title: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: SizedBox(
              width: 0.6.sw,
              child: Text(
                'notification'.tr(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Positioned(
            right: 8.w,
            child: IconButton(
              onPressed: () {},
              padding: EdgeInsets.all(4.w),
              icon: SvgPicture.asset(
                AppImage.svgMore,
                width: 16.w,
                height: 16.w,
                color: AppColor.primary,
              ),
            ),
          ),
          Positioned(
            left: 8.w,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: SvgPicture.asset(
                AppImage.svgArrowLeft,
                width: 16.w,
                height: 16.w,
                color: AppColor.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildView(BuildContext context, NotificationVM vm) {
    return SingleChildScrollView(
      child: ListView.builder(
        itemCount: vm.userProfile?.user?.notifications?.length ?? 0,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColor.cardColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        vm
                                .userProfile
                                ?.user
                                ?.notifications?[index]
                                .typeString ??
                            '',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        vm.userProfile?.user?.notifications?[index].createdAt
                                ?.toLocal()
                                .toString()
                                .substring(0, 10) ??
                            '',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  Text(
                    vm.userProfile?.user?.notifications?[index].title ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    vm.userProfile?.user?.notifications?[index].message ?? '',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
