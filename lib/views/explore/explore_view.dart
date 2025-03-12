import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_constants.dart';
import 'package:ecourse_flutter_v2/core/config/app_image.dart';
import 'package:ecourse_flutter_v2/core/routes/app_routes.dart';
import 'package:ecourse_flutter_v2/core/widgets/text_fields/base_text_field.dart';
import 'package:ecourse_flutter_v2/core/widgets/buttons/see_all_button.dart';
import 'package:ecourse_flutter_v2/core/widgets/buttons/svg_icon_button.dart';
import 'package:ecourse_flutter_v2/models/course_model.dart';
import 'package:ecourse_flutter_v2/models/teacher_model.dart';
import 'package:ecourse_flutter_v2/view_models/explore_vm.dart';
import 'package:ecourse_flutter_v2/views/home/widget/my_search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/base/base_view.dart';

class ExploreView extends BaseView<ExploreVM> {
  const ExploreView({super.key});

  @override
  ExploreVM createViewModel(
    BuildContext context,
    Map<String, dynamic>? arguments,
  ) {
    return ExploreVM(context);
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, ExploreVM vm) {
    return AppBar(
      toolbarHeight: 80.h,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                'Explore',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 24.sp,
                ),
              ),
              Spacer(),
              SvgIconButton(assetName: AppImage.svgBell, onPressed: () {}),
              SvgIconButton(assetName: AppImage.svgCart, onPressed: () {}),
            ],
          ),
          Row(
            children: [
              BaseTextField(
                onTap: () {
                  showSearch(context: context, delegate: MySearchDelegate());
                },
                height: 35.h,
                width: 1.sw - 76.w,
                hintText: 'search'.tr(),
                prefixIcon: const Icon(Icons.search),
                obscureText: false,
                textInputAction: TextInputAction.done,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
              ),
              Spacer(),
              SvgIconButton(assetName: AppImage.svgFilter, onPressed: () {}),
            ],
          ),
          SizedBox(height: 16.h),
        ],
      ),
      centerTitle: false,
      backgroundColor: AppColor.background,
    );
  }

  @override
  Widget buildView(BuildContext context, ExploreVM vm) {
    final List<Map<String, dynamic>> items = [
      {"icon": Icons.design_services, "label": "UI/UX"},
      {"icon": Icons.code, "label": "Coding"},
      {"icon": Icons.block, "label": "3D Design"},
      {"icon": Icons.adobe, "label": "Adobe"},
      {"icon": Icons.brush, "label": "Art"},
      {"icon": Icons.video_library, "label": "Editing"},
      {"icon": Icons.camera, "label": "Photograph"},
      {"icon": Icons.animation, "label": "Animate"},
    ];
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200.h,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ExploreCourses(course: vm.courses[index]);
                },
                itemCount: vm.courses.length,
              ),
            ),
            SeeAllButton(title: 'find_subjects'.tr(), onSeeAll: () {}),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return CategoryCard(
                    icon: items[index]['icon'],
                    label: items[index]['label'],
                  );
                },
              ),
            ),
            SeeAllButton(title: 'find_teachers'.tr(), onSeeAll: () {}),
            SizedBox(
              height: 200.h,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return TeacherItem(teacher: vm.teachers[index]);
                },
                itemCount: vm.teachers.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const CategoryCard({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.3.sw - 24.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8.h),
            decoration: BoxDecoration(
              color: AppColor.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(icon, size: 32.h, color: AppColor.primary),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  const CourseCard({super.key, required this.course});
  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppRoutes.push(context, AppRoutes.courseDetail, arguments: course);
      },
      child: Container(
        margin: EdgeInsets.only(left: 16.w),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
        width: 0.5.sw - 24.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: course.thumnail?.url ?? '',
              fit: BoxFit.cover,
              width: 0.5.sw - 24.w,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: AppColor.cardColor,
              ),
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.h),
                  Text(
                    course.title ?? '',
                    maxLines: 2,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${course.instructor?.firstName} ${course.instructor?.lastName}, ${course.instructor?.level}',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 9.sp,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.h,
                      vertical: 2.h,
                    ),
                    child: Text(
                      'Video Editing',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 9.sp,
                        color: AppColor.textPrimaryDark,
                      ),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Text(
                        '${course.price}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        '${course.price}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp,
                          decoration: TextDecoration.lineThrough,
                          color: AppColor.textSecondaryDark,
                          decorationColor: AppColor.textSecondaryDark,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TeacherItem extends StatelessWidget {
  const TeacherItem({super.key, required this.teacher});
  final TeacherModel teacher;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppRoutes.push(context, AppRoutes.teacherProfile, arguments: teacher);
      },
      child: SizedBox(
        width: 0.3.sw - 16.w,
        child: Column(
          children: [
            CircleAvatar(
              radius: 35.r,
              backgroundImage: AssetImage(
                teacher.profilePicture ?? AppConstants.defaultAvatar,
              ),
            ),
            Text(
              '${teacher.firstName} ${teacher.lastName}',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 10.sp,
              ),
            ),
            Text(
              teacher.level ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w300,
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExploreCourses extends StatelessWidget {
  const ExploreCourses({super.key, required this.course});
  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppRoutes.push(context, AppRoutes.courseDetail, arguments: course);
      },
      child: Container(
        margin: EdgeInsets.only(left: 12.w),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          elevation: 5,
          child: Container(
            width: 0.72.sw,
            height: 150.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              image: DecorationImage(
                image: CachedNetworkImageProvider(course.thumnail?.url ?? ''),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Container(
                  width: 0.72.sw,
                  height: 150.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF202020), Color(0x00202020)],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 16.w,
                      top: 16.h,
                      right: 24.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.title ?? '',
                          style: Theme.of(
                            context,
                          ).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColor.textPrimaryDark,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'By ',
                                style: Theme.of(
                                  context,
                                ).textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10.sp,
                                  color: AppColor.textPrimaryDark,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '${course.instructor?.firstName} ${course.instructor?.lastName}',
                                style: Theme.of(
                                  context,
                                ).textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10.sp,
                                  color: AppColor.textPrimaryDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.primary,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.h,
                            vertical: 2.h,
                          ),
                          child: Text(
                            'Video Editing',
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 9.sp,
                              color: AppColor.textPrimaryDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16.h,
                  left: 16.w,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppImage.svgClock,
                        width: 16.w,
                        height: 16.h,
                        color: AppColor.textPrimaryDark,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: ' 7 ',
                              style: Theme.of(
                                context,
                              ).textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 10.sp,
                                color: AppColor.textPrimaryDark,
                              ),
                            ),
                            TextSpan(
                              text: 'Weeks',
                              style: Theme.of(
                                context,
                              ).textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 10.sp,
                                color: AppColor.textPrimaryDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 16.h,
                  right: 16.w,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '\$ ',
                          style: Theme.of(
                            context,
                          ).textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                            color: AppColor.textPrimaryDark,
                          ),
                        ),
                        TextSpan(
                          text: '${course.price}',
                          style: Theme.of(
                            context,
                          ).textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 10.sp,
                            color: AppColor.textPrimaryDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
