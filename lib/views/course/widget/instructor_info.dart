import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/widgets/elevated_button.dart';
import 'package:ecourse_flutter_v2/models/instructor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InstructorInfoWidget extends StatelessWidget {
  final InstructorModel instructor;

  const InstructorInfoWidget({super.key, required this.instructor});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0.w),
      leading: CircleAvatar(
        backgroundImage: AssetImage(instructor.profilePicture),
      ),
      title: Text(
        instructor.name,
        style: Theme.of(
          context,
        ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        instructor.title,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 10.sp,
          color: AppColor.textSecondary,
        ),
      ),
      trailing: CustomElevatedButton(
        onPressed: () {},
        height: 30.h,
        textStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 10.sp,
          color: AppColor.textPrimaryDark,
        ),
        context: context,
        text: 'Follow',
      ),
    );
  }
}
