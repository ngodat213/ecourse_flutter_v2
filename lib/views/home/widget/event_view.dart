// import 'package:easy_localization/easy_localization.dart';
// import 'package:ecourse_flutter_v2/core/base/base_view.dart';
// import 'package:ecourse_flutter_v2/core/config/app_color.dart';
// import 'package:ecourse_flutter_v2/core/config/app_image.dart';
// import 'package:ecourse_flutter_v2/core/widgets/base_text_field.dart';
// import 'package:ecourse_flutter_v2/core/widgets/see_all.dart';
// import 'package:ecourse_flutter_v2/core/widgets/svg_icon_button.dart';
// import 'package:ecourse_flutter_v2/views/home/vm/home_vm.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class EventsView extends BaseView<HomeVM> {
//   const EventsView({super.key});

//   @override
//   HomeVM createViewModel(BuildContext context, Map<String, dynamic>? arguments) {
//     return HomeVM(context);
//   }

//   @override
//   PreferredSizeWidget? buildAppBar(BuildContext context, HomeVM vm) {
//     return AppBar(
//       toolbarHeight: 96.h,
//       title: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'events'.tr(),
//             style: Theme.of(context).textTheme.titleLarge?.copyWith(
//               fontWeight: FontWeight.w700,
//               fontSize: 24.sp,
//             ),
//           ),
//           SizedBox(height: 16.h),
//           Row(
//             children: [
//               BaseTextField(
//                 height: 35.h,
//                 width: 1.sw - 76.w,
//                 hintText: 'search'.tr(),
//                 prefixIcon: const Icon(Icons.search),
//                 obscureText: false,
//                 textInputAction: TextInputAction.done,
//                 style: Theme.of(
//                   context,
//                 ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
//               ),
//               Spacer(),
//               SvgIconButton(assetName: AppImage.svgFilter, onPressed: () {}),
//             ],
//           ),
//           SizedBox(height: 16.h),
//         ],
//       ),
//       centerTitle: false,
//       backgroundColor: AppColor.background,
//     );
//   }

//   @override
//   Widget buildView(BuildContext context, HomeVM vm) {
//     return SafeArea(
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             SeeAllWidget(title: 'upcoming_events'.tr(), onSeeAll: () {}),
//             SizedBox(
//               height: 252.h,
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (context, index) {
//                   return CourseCard();
//                 },
//                 itemCount: 5,
//               ),
//             ),
//             SeeAllWidget(title: 'newest_events'.tr(), onSeeAll: () {}),
//             SizedBox(
//               height: 252.h,
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (context, index) {
//                   return CourseCard();
//                 },
//                 itemCount: 5,
//               ),
//             ),

//             SeeAllWidget(title: 'offline_events'.tr(), onSeeAll: () {}),
//             SizedBox(
//               height: 252.h,
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (context, index) {
//                   return CourseCard();
//                 },
//                 itemCount: 5,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CourseCard extends StatelessWidget {
//   const CourseCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(left: 16.w),
//       decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
//       width: 0.5.sw - 24.w,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Image.asset(
//             AppImage.imgCourse1,
//             fit: BoxFit.cover,
//             width: 0.5.sw - 24.w,
//           ),
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10.r),
//               color: AppColor.cardColor,
//             ),
//             padding: EdgeInsets.symmetric(horizontal: 8.w),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 8.h),
//                 Text(
//                   '• ${'offline_events'.tr()}',
//                   style: Theme.of(context).textTheme.labelSmall?.copyWith(
//                     fontWeight: FontWeight.w400,
//                     fontSize: 9.sp,
//                     color: AppColor.success,
//                   ),
//                 ),
//                 Text(
//                   'Adobe Premiere Pro: Complete Course...',
//                   maxLines: 2,
//                   style: Theme.of(context).textTheme.labelSmall?.copyWith(
//                     fontWeight: FontWeight.bold,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 SizedBox(height: 6.h),
//                 Text(
//                   '14-15 March 2025',
//                   style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                     fontWeight: FontWeight.w400,
//                     fontSize: 9.sp,
//                   ),
//                 ),
//                 SizedBox(height: 6.h),
//                 Text.rich(
//                   TextSpan(
//                     children: [
//                       TextSpan(
//                         text: 'start_at '.tr(),
//                         style: Theme.of(context).textTheme.labelSmall?.copyWith(
//                           fontWeight: FontWeight.w500,
//                           fontSize: 10.sp,
//                           color: AppColor.textSecondary,
//                         ),
//                       ),
//                       TextSpan(
//                         text: '\$20',
//                         style: Theme.of(context).textTheme.labelSmall?.copyWith(
//                           fontWeight: FontWeight.w700,
//                           fontSize: 10.sp,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 8.h),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
