import 'package:easy_localization/easy_localization.dart';
import 'package:ecourse_flutter_v2/core/widgets/buttons/see_all_button.dart';
import 'package:ecourse_flutter_v2/view_models/home_vm.dart';
import 'package:ecourse_flutter_v2/views/explore/explore_view.dart';
import 'package:flutter/material.dart';

class CourseListView extends StatelessWidget {
  const CourseListView({super.key, required this.vm});
  final HomeVM vm;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: vm.popularCourses.isNotEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SeeAllButton(title: 'popular_courses'.tr(), onSeeAll: () {}),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children:
                    vm.popularCourses
                        .map((e) => CardCourse(course: e))
                        .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
