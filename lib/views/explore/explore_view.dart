import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_constants.dart';
import 'package:ecourse_flutter_v2/core/config/app_image.dart';
import 'package:ecourse_flutter_v2/core/routes/app_routes.dart';
import 'package:ecourse_flutter_v2/core/widgets/smart_image.dart';
import 'package:ecourse_flutter_v2/core/widgets/text_fields/base_text_field.dart';
import 'package:ecourse_flutter_v2/core/widgets/buttons/see_all_button.dart';
import 'package:ecourse_flutter_v2/core/widgets/buttons/svg_icon_button.dart';
import 'package:ecourse_flutter_v2/models/course_model.dart';
import 'package:ecourse_flutter_v2/models/teacher_model.dart';
import 'package:ecourse_flutter_v2/view_models/explore_vm.dart';
import 'package:ecourse_flutter_v2/views/explore/widget/listview_course.dart';
import 'package:ecourse_flutter_v2/views/explore/widget/my_search_delegate.dart';
import 'package:ecourse_flutter_v2/views/explore/widget/search_filter_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              SvgIconButton(
                assetName: AppImage.svgCart,
                onPressed: () => vm.redirectToCart(),
              ),
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
              SvgIconButton(
                assetName: AppImage.svgFilter,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => const SearchFilterDialog(),
                  ).then((result) {
                    if (result != null) {
                      // TODO: Handle filter result
                      print('Selected filters: $result');
                    }
                  });
                },
              ),
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
    return SafeArea(
      child:
          vm.onSeeAll
              ? ListViewCourse(
                courses: vm.coursesOnSeeAll,
                onCancel: () => vm.setOnSeeAll(vm.coursesOnSeeAll),
              )
              : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SeeAllButton(title: 'find_subjects'.tr(), onSeeAll: () {}),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          childAspectRatio: 0.9,
                          crossAxisSpacing: 4.w,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            vm.categories.length > 5 ? 5 : vm.categories.length,
                        itemBuilder: (context, index) {
                          return CategoryCard(
                            icon: Icons.code,
                            label: vm.categories[index].name ?? '',
                            onTap:
                                () => vm.setOnSeeAll(
                                  vm.categories[index].courses ?? [],
                                ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 16.h),
                    SeeAllButton(
                      title: 'find_teachers'.tr(),
                      onSeeAll: () {},
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 0.h,
                      ),
                    ),
                    SizedBox(
                      height: 105.h,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return TeacherItem(teacher: vm.teachers[index]);
                        },
                        itemCount: vm.teachers.length,
                      ),
                    ),
                    SeeAllButton(
                      title: 'featured_courses'.tr(),
                      onSeeAll: () => vm.setOnSeeAll(vm.courses),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 0.h,
                      ),
                    ),
                    Visibility(
                      visible: vm.courses.isNotEmpty,
                      child: SizedBox(
                        height: 240.h,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return CardCourse(course: vm.courses[index]);
                          },
                          itemCount: vm.courses.length,
                        ),
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
  final Function() onTap;

  const CategoryCard({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 1.sw / 5 - 10.w,
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
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  const CourseCard({super.key, required this.course, this.isEnrolled = false});
  final CourseModel course;
  final bool isEnrolled;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!isEnrolled) {
          AppRoutes.push(
            context,
            AppRoutes.courseDetail,
            arguments: course.toJson(),
          );
        } else {
          AppRoutes.push(
            context,
            AppRoutes.courseLearn,
            arguments: course.toJson(),
          );
        }
      },
      child: Container(
        margin: EdgeInsets.only(left: 16.w),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
        width: 0.5.sw - 24.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SmartImage(
              source: course.thumnail?.url ?? '',
              fit: BoxFit.cover,
              width: 0.5.sw - 24.w,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.r),
                topRight: Radius.circular(8.r),
              ),
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
                  Row(
                    children: [
                      ...course.categories?.map(
                            (e) => Container(
                              margin: EdgeInsets.only(right: 4.w),
                              decoration: BoxDecoration(
                                color: AppColor.primary,
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.h,
                                vertical: 2.h,
                              ),
                              child: Text(
                                e.name ?? '',
                                style: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 9.sp,
                                  color: AppColor.textPrimaryDark,
                                ),
                              ),
                            ),
                          ) ??
                          [],
                    ],
                  ),
                  SizedBox(height: 6.h),
                  if (!isEnrolled)
                    Row(
                      children: [
                        Text(
                          '${course.price}',
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          '${course.price}',
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
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
        AppRoutes.push(
          context,
          AppRoutes.teacherProfile,
          arguments: teacher.toJson(),
        );
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

class CardCourse extends StatelessWidget {
  const CardCourse({super.key, required this.course});
  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppRoutes.push(
          context,
          AppRoutes.courseDetail,
          arguments: course.toJson(),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        margin: EdgeInsets.only(left: 16.w),
        elevation: 2,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
          width: 0.5.sw - 24.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.r),
                  topRight: Radius.circular(8.r),
                ),
                child: CachedNetworkImage(
                  imageUrl: course.thumnail?.url ?? '',
                  fit: BoxFit.cover,
                  width: 0.5.sw - 24.w,
                  height: 100.h,
                ),
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
                    Row(
                      children: [
                        ...course.categories?.map(
                              (e) => Container(
                                decoration: BoxDecoration(
                                  color: AppColor.primary,
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5.h,
                                  vertical: 2.h,
                                ),
                                child: Text(
                                  e.name ?? '',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 9.sp,
                                    color: AppColor.textPrimaryDark,
                                  ),
                                ),
                              ),
                            ) ??
                            [],
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Text(
                          '${course.price}',
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          '${course.price}',
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
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
      ),
    );
  }
}
