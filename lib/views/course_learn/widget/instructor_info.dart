import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_constants.dart';
import 'package:ecourse_flutter_v2/core/widgets/buttons/elevated_button.dart';
import 'package:ecourse_flutter_v2/core/widgets/smart_image.dart';
import 'package:ecourse_flutter_v2/models/teacher_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InstructorInfoWidget extends StatelessWidget {
  final TeacherModel instructor;

  const InstructorInfoWidget({super.key, required this.instructor});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0.w),
      leading: SmartImage(
        source: instructor.profilePicture ?? AppConstants.defaultAvatar,
        width: 40.w,
        height: 40.w,
        borderRadius: BorderRadius.circular(20.r),
      ),
      title: Text(
        "${instructor.firstName} ${instructor.lastName}",
        style: Theme.of(
          context,
        ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        instructor.email ?? '',
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
