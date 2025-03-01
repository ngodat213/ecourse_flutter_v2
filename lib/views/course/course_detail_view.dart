import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_image.dart';
import 'package:ecourse_flutter_v2/core/widgets/elevated_button.dart';
import 'package:ecourse_flutter_v2/core/widgets/list_tile.dart';
import 'package:ecourse_flutter_v2/view_models/course_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/base/base_view.dart';

class CourseDetailView extends BaseView<CourseVM> {
  const CourseDetailView({super.key});

  @override
  CourseVM createViewModel(BuildContext context) {
    return CourseVM(context);
  }

  @override
  Widget buildView(BuildContext context, CourseVM vm) {
    return CourseDetailScreen(viewModel: vm);
  }
}

class CourseStatsItem extends StatelessWidget {
  const CourseStatsItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.45.sw,
      decoration: BoxDecoration(
        color: AppColor.cardColor,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.secondary.withOpacity(0.1),
            blurRadius: 8.r,
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
        leading: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: AppColor.primary.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: SvgPicture.asset(
            AppImage.svgPlay,
            width: 16.w,
            height: 16.h,
            color: AppColor.primary,
          ),
        ),
        title: Text(
          'Total Lessons',
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          '45-50 Classes',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColor.accent,
          ),
        ),
      ),
    );
  }
}

class CourseDetailScreen extends StatefulWidget {
  const CourseDetailScreen({super.key, required this.viewModel});
  final CourseVM viewModel;

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 33.h),
        child: CustomElevatedButton(
          onPressed: () {},
          width: 1.sw, // Full width
          text: 'Buy Course for \$100',
          context: context,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.all(6.w),
                      style: IconButton.styleFrom(
                        backgroundColor: AppColor.primary.withOpacity(0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                      ),
                      icon: SvgPicture.asset(
                        AppImage.svgArrowLeft,
                        width: 12.w,
                        height: 16.h,
                        color: AppColor.primary,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {},
                      padding: EdgeInsets.all(8.w),
                      icon: SvgPicture.asset(
                        AppImage.svgHeart,
                        width: 16.w,
                        height: 16.h,
                        color: AppColor.primary,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    IconButton(
                      onPressed: () {},
                      padding: EdgeInsets.all(8.w),
                      icon: SvgPicture.asset(
                        AppImage.svgShare,
                        width: 16.w,
                        height: 16.h,
                        color: AppColor.primary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 0.6.sw,
                margin: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColor.secondary,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Flutter for Beginners',
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  AppImage.svgClock,
                                  width: 12.w,
                                  height: 12.h,
                                  color: AppColor.primary,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  '45m',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.primary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        Row(
                          children: [
                            SvgPicture.asset(
                              AppImage.svgStar,
                              width: 12.w,
                              height: 12.h,
                              color: AppColor.warning,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              '4.5',
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    TabBar(
                      controller: _tabController,
                      labelStyle: Theme.of(
                        context,
                      ).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColor.secondary,
                      ),
                      unselectedLabelStyle: Theme.of(
                        context,
                      ).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColor.accent,
                      ),
                      tabs: [Text('Description'), Text('Lesson')],
                    ),
                    SizedBox(
                      height: 1.sw,
                      child: Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(height: 16.h),
                                  Text(
                                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.textSecondary,
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CourseStatsItem(),
                                      CourseStatsItem(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            LessonTab(),
                          ],
                        ),
                      ),
                    ),
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

class LessonTab extends StatelessWidget {
  const LessonTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [SizedBox(height: 16.h), SelectionItem(), SelectionItem()],
      ),
    );
  }
}

class SelectionItem extends StatelessWidget {
  const SelectionItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        childrenPadding: EdgeInsets.symmetric(vertical: 8.w),
        title: Text(
          'Selection 1 - Introducting to the class',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColor.textSecondary,
          ),
        ),

        children: [
          ListTileWidget(
            leading: '1',
            title: 'Introducting to the class',
            subtitle: '45m',
            isExam: false,
            onTap: () {},
          ),
          ListTileWidget(
            leading: '2',
            title: 'Introducting to the class',
            subtitle: '45m',
            isExam: false,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
