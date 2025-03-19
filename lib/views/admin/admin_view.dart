// import 'package:data_table_2/data_table_2.dart';
// import 'package:ecourse_flutter_v2/core/base/base_view.dart';
// import 'package:ecourse_flutter_v2/core/config/app_color.dart';
// import 'package:ecourse_flutter_v2/core/config/app_image.dart';
// import 'package:ecourse_flutter_v2/core/widgets/text_fields/base_text_field.dart';
// import 'package:ecourse_flutter_v2/models/course.dart';
// import 'package:ecourse_flutter_v2/view_models/admin_vm.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';

// class AdminView extends BaseView<AdminVM> {
//   const AdminView({super.key});

//   @override
//   AdminVM createViewModel(
//     BuildContext context,
//     Map<String, dynamic>? arguments,
//   ) {
//     return AdminVM(context);
//   }

//   @override
//   PreferredSizeWidget? buildAppBar(BuildContext context, AdminVM viewModel) {
//     return AppBar(
//       title: Row(
//         children: [
//           BaseTextField(
//             hintText: 'Search',
//             onChanged: (value) {},
//             width: 300.w,
//           ),
//           Spacer(),
//           SvgPicture.asset(AppImage.svgBell, width: 24.w, height: 24.h),
//           SizedBox(width: 16.w),
//           CircleAvatar(
//             radius: 32.r,
//             backgroundImage: AssetImage(AppImage.imgBanner),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget buildView(BuildContext context, AdminVM vm) {
//     return SafeArea(
//       child:
//           vm.rowCourseList.isEmpty
//               ? Center(
//                 child: CircularProgressIndicator(),
//               ) // Hiển thị loading nếu chưa có dữ liệu
//               : Align(
//                 alignment: Alignment.centerRight,
//                 child: Row(
//                   children: [
//                     DataTableWidget(
//                       datas: vm.rowCourseList,
//                       columns: CourseModel.columns,
//                       title: 'Course List',
//                       description: 'Click on the course to view details',
//                       onPressed: () {},
//                     ),
//                   ],
//                 ),
//               ),
//     );
//   }
// }

// class DataTableWidget extends StatelessWidget {
//   const DataTableWidget({
//     super.key,
//     required this.datas,
//     required this.columns,
//     required this.title,
//     required this.description,
//     required this.onPressed,
//   });
//   final String title;
//   final String description;
//   final Function() onPressed;
//   final List<DataRow> datas;
//   final List<DataColumn> columns;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 0.7.sw,
//       height: 1.sh,
//       padding: EdgeInsets.all(16.w),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: TextStyle(
//                       fontSize: 24.sp,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     description,
//                     style: TextStyle(fontSize: 16.sp, color: Colors.grey),
//                   ),
//                 ],
//               ),
//               TextButton(
//                 style: TextButton.styleFrom(
//                   backgroundColor: AppColor.primary,
//                   foregroundColor: Colors.white,
//                 ),
//                 onPressed: () {},
//                 child: Text('Add Course'),
//               ),
//             ],
//           ),
//           SizedBox(height: 16.h),
//           Expanded(
//             child: DataTable2(
//               columnSpacing: 12,
//               horizontalMargin: 12,
//               minWidth: 0.7.sw,
//               columns: columns,
//               rows: datas,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
