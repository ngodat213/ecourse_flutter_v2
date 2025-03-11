import 'package:ecourse_flutter_v2/core/base/base_view.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_image.dart';
import 'package:ecourse_flutter_v2/view_models/profile_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyCourseView extends BaseView<ProfileVM> {
  const MyCourseView({super.key});

  @override
  ProfileVM createViewModel(BuildContext context) {
    return ProfileVM(context);
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, ProfileVM vm) {
    return AppBar(backgroundColor: AppColor.background);
  }

  @override
  Widget buildView(BuildContext context, ProfileVM viewModel) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Course',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 18.sp,
              ),
            ),
            Text(
              '2 courses enrolled',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 10.sp,
              ),
            ),
            SizedBox(height: 32.h),
            Container(
              width: 1.sw,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: AppColor.cardColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 50.w,
                        height: 50.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          image: DecorationImage(
                            image: AssetImage(AppImage.imageThumnail),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      SizedBox(
                        width: 1.sw - 50.w - 16.w - 32.w - 8.w - 32.w - 24.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Aliqua ad et esse sunt cupidatat ut culpa esse. Occaecat eiusmod consectetur laborum ex irure ea irure magna voluptate duis adipisicing et est. Officia nisi deserunt laboris culpa eiusmod sunt pariatur pariatur excepteur reprehenderit laboris officia. Occaecat eiusmod fugiat anim anim adipisicing tempor. Commodo aliqua reprehenderit consequat officia labore irure tempor culpa reprehenderit veniam nostrud. Aliqua nostrud dolor cillum tempor. Id dolore Lorem cupidatat aliquip amet.',
                              maxLines: 2,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(
                                context,
                              ).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 13.sp,
                              ),
                            ),
                            Text(
                              'Course Description',
                              style: Theme.of(
                                context,
                              ).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 10.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16.w),
                      SvgPicture.asset(
                        AppImage.svgMore,
                        width: 16.w,
                        height: 16.h,
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Overall progress 99%',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 10.sp,
                    ),
                  ),
                  LinearProgressIndicator(
                    value: 0.99,
                    color: AppColor.primary,
                    backgroundColor: AppColor.border,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
