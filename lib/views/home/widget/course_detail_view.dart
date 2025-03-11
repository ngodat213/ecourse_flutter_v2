import 'package:animated_read_more_text/animated_read_more_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_constants.dart';
import 'package:ecourse_flutter_v2/core/config/app_image.dart';
import 'package:ecourse_flutter_v2/core/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CourseDetailView extends StatelessWidget {
  const CourseDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Course Detail')),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 33.h),
        child: CustomElevatedButton(
          onPressed: () {},
          width: 1.sw, // Full width
          text: 'Buy Course for \$100',
          context: context,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 1.sw,
                height: 200.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  image: DecorationImage(
                    image: AssetImage(AppImage.imageThumnail),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Adobe Premiere Pro: Complete Course from Beginner to Expert ',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  SvgPicture.asset(
                    AppImage.svgClock,
                    width: 16.w,
                    height: 16.h,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '8h 30min',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  SvgPicture.asset(AppImage.svgInfo, width: 16.w, height: 16.h),
                  SizedBox(width: 4.w),
                  Text(
                    '30 lessons',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                    ),
                  ),
                  Spacer(),
                  SvgPicture.asset(
                    AppImage.svgStar,
                    color: Colors.yellow,
                    width: 16.w,
                    height: 16.h,
                  ),
                  Text(
                    '4.7',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '(',
                          style: Theme.of(
                            context,
                          ).textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                          ),
                        ),
                        TextSpan(
                          text: '15.0 rattings',
                          style: Theme.of(
                            context,
                          ).textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                          ),
                        ),
                        TextSpan(
                          text: ')',
                          style: Theme.of(
                            context,
                          ).textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 0.w),
                leading: CircleAvatar(
                  backgroundImage: AssetImage(AppConstants.defaultAvatar),
                ),
                title: Text(
                  'Hydra Coder',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Full Stack Developer',
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
              ),
              SizedBox(height: 4.h),
              Text(
                'About this course',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
              AnimatedReadMoreText(
                'Amet veniam ea dolor qui quis sint aliqua nulla occaecat fugiat qui. Magna consectetur amet sunt officia id elit adipisicing exercitation do consectetur eu do tempor. Incididunt eiusmod ex amet cupidatat enim ullamco eiusmod nulla. Irure minim ut nisi Lorem officia ut. Eu laboris ullamco ex ex magna aliquip amet officia reprehenderit commodo exercitation. Commodo nostrud ad magna ad anim cupidatat adipisicing fugiat adipisicing commodo. Laboris sint eu ex voluptate velit labore culpa. Ex occaecat eiusmod pariatur velit. Ad irure magna dolore est officia cillum dolor. Velit magna commodo laborum pariatur occaecat voluptate enim magna quis esse fugiat. Velit nulla anim pariatur non ad ipsum cillum ullamco id est ut deserunt esse irure.'
                    .tr(),
                maxLines: 6,
                textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColor.textSecondary,
                  fontSize: 10.sp,
                ),
              ),

              SizedBox(height: 16),
              ListTile(
                leading: SvgPicture.asset(AppImage.svgWarning),
                title: Text('Last update 06/2023'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
