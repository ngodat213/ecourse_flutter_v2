import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/app/data/models/course_model.dart';
import 'package:ecourse_flutter_v2/views/explore/widget/list_view_course_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListViewCourse extends StatelessWidget {
  final List<CourseModel> courses;
  final Function() onCancel;
  const ListViewCourse({
    super.key,
    required this.courses,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${courses.length} courses',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: onCancel,
                icon: Icon(Icons.close),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
              ),
            ],
          ),
        ),
        Divider(height: 1.h, color: AppColor.border),
        SizedBox(
          height: 1.sh - 300.h,
          child: ListView.builder(
            itemCount: courses.length,
            shrinkWrap: true,
            itemBuilder:
                (context, index) => ListViewCourseItem(course: courses[index]),
          ),
        ),
      ],
    );
  }
}
