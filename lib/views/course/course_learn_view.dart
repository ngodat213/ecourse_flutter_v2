import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/view_models/course_vm.dart';
import 'package:ecourse_flutter_v2/views/course/widget/course_learn_appbar.dart';
import 'package:ecourse_flutter_v2/views/course/widget/course_learn_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/base/base_view.dart';

class CourseLearnView extends BaseView<CourseVM> {
  const CourseLearnView({super.key});

  @override
  CourseVM createViewModel(
    BuildContext context,
    Map<String, dynamic>? arguments,
  ) {
    return CourseVM(context);
  }

  @override
  Widget buildView(BuildContext context, CourseVM vm) {
    return CourseLearnScreen(viewModel: vm);
  }
}

class CourseLearnScreen extends StatefulWidget {
  const CourseLearnScreen({super.key, required this.viewModel});
  final CourseVM viewModel;

  @override
  State<CourseLearnScreen> createState() => _CourseLearnScreenState();
}

class _CourseLearnScreenState extends State<CourseLearnScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, title: CourseAppBar()),
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
              CourseTabBar(tabController: _tabController),
            ],
          ),
        ),
      ),
    );
  }
}
