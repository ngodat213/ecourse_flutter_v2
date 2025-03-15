import 'package:animated_read_more_text/animated_read_more_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_constants.dart';
import 'package:ecourse_flutter_v2/models/course_model.dart';
import 'package:ecourse_flutter_v2/models/teacher_model.dart';
import 'package:ecourse_flutter_v2/views/course_learn/widget/claim_cerification_card.dart';
import 'package:ecourse_flutter_v2/views/course_learn/widget/instructor_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OverviewTab extends StatelessWidget {
  const OverviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Sử dụng mock data cho demo
    // final instructor = InstructorModel(
    //   name: 'Hydra Coder',
    //   profilePicture: AppConstants.defaultAvatar,
    //   title: 'Full Stack Developer',
    //   bio:
    //       'Hi there, my name is Michael Curry and I am an Adobe Certified Instructor. I am here to help you learn Adobe Premiere Pro and to show you the tools you need to become a successful video editor. Premiere Pro is the industry standard used by professional designers to create stunning, high class videos and, after completing this course, you too can become a confident, skilful and efficient creator of stunning videos.',
    // );

    // final course = CourseModel(
    //   title: 'Adobe Premiere Pro: Complete Course',
    //   description:
    //       'Amet veniam ea dolor qui quis sint aliqua nulla occaecat fugiat qui. Magna consectetur amet sunt officia id elit adipisicing exercitation do consectetur eu do tempor. Incididunt eiusmod ex amet cupidatat enim ullamco eiusmod nulla. Irure minim ut nisi Lorem officia ut. Eu laboris ullamco ex ex magna aliquip amet officia reprehenderit commodo exercitation. Commodo nostrud ad magna ad anim cupidatat adipisicing fugiat adipisicing commodo. Laboris sint eu ex voluptate velit labore culpa. Ex occaecat eiusmod pariatur velit. Ad irure magna dolore est officia cillum dolor. Velit magna commodo laborum pariatur occaecat voluptate enim magna quis esse fugiat. Velit nulla anim pariatur non ad ipsum cillum ullamco id est ut deserunt esse irure.',
    //   aboutCourse:
    //       'Ut labore reprehenderit proident officia magna ex tempor labore magna nostrud aute deserunt adipisicing voluptate. Cupidatat nostrud officia laboris ea proident. Est culpa eiusmod elit eiusmod excepteur sint sit qui adipisicing mollit reprehenderit. Amet amet laborum sunt ad amet ullamco. Labore esse anim non nulla laboris sunt nulla eu nisi ipsum esse eiusmod veniam. Cupidatat laboris proident aliquip dolore.',
    //   progressPercentage: 100,
    //   instructor: instructor,
    // );

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(height: 16.h),
          // ClaimCerificationCard(progress: course.progressPercentage),
          // SizedBox(height: 16.h),
          // Text(
          //   'about_course'.tr(),
          //   style: Theme.of(context).textTheme.titleMedium?.copyWith(
          //     fontWeight: FontWeight.w600,
          //     fontSize: 18.sp,
          //   ),
          // ),
          // AnimatedReadMoreText(
          //   course.aboutCourse.tr(),
          //   textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
          //     color: AppColor.textSecondary,
          //     fontSize: 10.sp,
          //   ),
          // ),
          // SizedBox(height: 24.h),
          // Text(
          //   'description'.tr(),
          //   style: Theme.of(context).textTheme.titleMedium?.copyWith(
          //     fontWeight: FontWeight.w600,
          //     fontSize: 18.sp,
          //   ),
          // ),
          // AnimatedReadMoreText(
          //   course.description.tr(),
          //   maxLines: 6,
          //   textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
          //     color: AppColor.textSecondary,
          //     fontSize: 10.sp,
          //   ),
          // ),
          // SizedBox(height: 20.h),
          // Text(
          //   'about_instructor'.tr(),
          //   style: Theme.of(context).textTheme.titleMedium?.copyWith(
          //     fontWeight: FontWeight.w600,
          //     fontSize: 18.sp,
          //   ),
          // ),
          // InstructorInfoWidget(instructor: instructor),
          // AnimatedReadMoreText(
          //   instructor.bio.tr(),
          //   maxLines: 6,
          //   textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
          //     color: AppColor.textSecondary,
          //     fontSize: 10.sp,
          //   ),
          // ),
        ],
      ),
    );
  }
}
