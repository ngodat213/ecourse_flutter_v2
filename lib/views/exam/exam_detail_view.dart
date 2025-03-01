import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_image.dart';
import 'package:ecourse_flutter_v2/core/routes/app_routes.dart';
import 'package:ecourse_flutter_v2/core/widgets/elevated_button.dart';
import 'package:ecourse_flutter_v2/core/widgets/list_tile.dart';
import 'package:ecourse_flutter_v2/view_models/exam_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/base/base_view.dart';

class ExamDetailView extends BaseView<ExamVM> {
  const ExamDetailView({super.key});

  @override
  ExamVM createViewModel(BuildContext context) {
    return ExamVM(context);
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, ExamVM vm) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColor.background,
      actionsPadding: EdgeInsets.all(0),
      title: AppBarDetail(),
    );
  }

  @override
  Widget buildView(BuildContext context, ExamVM vm) {
    return ExamDetailScreen(viewModel: vm);
  }
}

class AppBarDetail extends StatelessWidget {
  const AppBarDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class ExamStatsItem extends StatelessWidget {
  const ExamStatsItem({super.key});

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

class ExamDetailScreen extends StatefulWidget {
  const ExamDetailScreen({super.key, required this.viewModel});
  final ExamVM viewModel;

  @override
  State<ExamDetailScreen> createState() => _ExamDetailScreenState();
}

class _ExamDetailScreenState extends State<ExamDetailScreen>
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
                                      ExamStatsItem(),
                                      ExamStatsItem(),
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
            subtitle: '45m/30 Questions',
            isExam: true,
            onTap: () => AppRoutes.push(context, AppRoutes.examTaking),
          ),
          ListTileWidget(
            leading: '2',
            title: 'Introducting to the class',
            subtitle: '45m/30 Questions',
            isExam: true,
          ),
        ],
      ),
    );
  }
}
