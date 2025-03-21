// import 'package:data_table_2/data_table_2.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class Course {
//   String? sId;
//   String? title;
//   String? description;
//   int? price;
//   // Instructor? instructorId;
//   // Thumbnail? thumbnailId;
//   int? studentCount;
//   int? rating;
//   int? reviewCount;
//   int? totalRevenue;
//   int? lessonCount;
//   int? totalDuration;
//   bool? hasCertificate;
//   // List<Null>? requirements;
//   // List<Null>? whatYouWillLearn;
//   String? level;
//   String? status;
//   String? createdAt;
//   String? updatedAt;

//   Course({
//     this.sId,
//     this.title,
//     this.description,
//     this.price,
//     // this.instructorId,
//     // this.thumbnailId,
//     this.studentCount,
//     this.rating,
//     this.reviewCount,
//     this.totalRevenue,
//     this.lessonCount,
//     this.totalDuration,
//     this.hasCertificate,
//     // this.requirements,
//     // this.whatYouWillLearn,
//     this.level,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//   });

//   Course.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     title = json['title'];
//     description = json['description'];
//     price = json['price'];
//     // instructorId =
//     //     json['instructor_id'] != null
//     //         ? Instructor.fromJson(json['instructor_id'])
//     //         : null;
//     // thumbnailId =
//     //     json['thumbnail_id'] != null
//     //         ? Thumbnail.fromJson(json['thumbnail_id'])
//     //         : null;
//     studentCount = json['student_count'];
//     rating = json['rating'];
//     reviewCount = json['review_count'];
//     totalRevenue = json['total_revenue'];
//     lessonCount = json['lesson_count'];
//     totalDuration = json['total_duration'];
//     hasCertificate = json['has_certificate'];
//     // if (json['requirements'] != null) {
//     //   requirements = <Null>[];
//     //   json['requirements'].forEach((v) {
//     //     requirements!.add(Null.fromJson(v));
//     //   });
//     // }
//     // if (json['what_you_will_learn'] != null) {
//     //   whatYouWillLearn = <Null>[];
//     //   json['what_you_will_learn'].forEach((v) {
//     //     whatYouWillLearn!.add(Null.fromJson(v));
//     //   });
//     // }
//     level = json['level'];
//     status = json['status'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = sId;
//     data['title'] = title;
//     data['description'] = description;
//     data['price'] = price;
//     // if (instructorId != null) {
//     //   data['instructor_id'] = instructorId!.toJson();
//     // }
//     // if (thumbnailId != null) {
//     //   data['thumbnail_id'] = thumbnailId!.toJson();
//     // }
//     data['student_count'] = studentCount;
//     data['rating'] = rating;
//     data['review_count'] = reviewCount;
//     data['total_revenue'] = totalRevenue;
//     data['lesson_count'] = lessonCount;
//     data['total_duration'] = totalDuration;
//     data['has_certificate'] = hasCertificate;
//     // if (requirements != null) {
//     //   data['requirements'] = requirements!.map((v) => v.toJson()).toList();
//     // }
//     // if (whatYouWillLearn != null) {
//     //   data['what_you_will_learn'] =
//     //       whatYouWillLearn!.map((v) => v.toJson()).toList();
//     // }
//     data['level'] = level;
//     data['status'] = status;
//     data['createdAt'] = createdAt;
//     data['updatedAt'] = updatedAt;
//     return data;
//   }

//   static final List<DataColumn2> columns = [
//     DataColumn2(label: Text('Title')),
//     DataColumn2(label: Text('Description')),
//     DataColumn2(label: Text('Price')),
//     DataColumn2(label: Text('Student Count')),
//     DataColumn2(label: Text('Rating')),
//     DataColumn2(label: Text('Review Count')),
//     DataColumn2(label: Text('Total Revenue')),
//     DataColumn2(label: Text('Lesson Count')),
//     DataColumn2(label: Text('Total Duration')),
//     DataColumn2(label: Text('Has Certificate')),
//     DataColumn2(label: Text('Level')),
//     DataColumn2(label: Text('Status')),
//     DataColumn2(label: Text('Created At')),
//     DataColumn2(label: Text('Updated At')),
//     DataColumn2(label: Text('Actions'), fixedWidth: 200.w),
//   ];

//   static DataRow toRow(Course course) {
//     return DataRow(
//       cells: [
//         DataCell(Text(course.title ?? '')),
//         DataCell(Text(course.description ?? '')),
//         DataCell(Text(course.price.toString())),
//         DataCell(Text(course.studentCount.toString())),
//         DataCell(Text(course.rating.toString())),
//         DataCell(Text(course.reviewCount.toString())),
//         DataCell(Text(course.totalRevenue.toString())),
//         DataCell(Text(course.lessonCount.toString())),
//         DataCell(Text(course.totalDuration.toString())),
//         DataCell(Text(course.hasCertificate.toString())),
//         DataCell(Text(course.level ?? '')),
//         DataCell(Text(course.status ?? '')),
//         DataCell(
//           Text(
//             DateFormat(
//               'dd/MM/yyyy',
//             ).format(DateTime.parse(course.createdAt ?? '')),
//           ),
//         ),
//         DataCell(
//           Text(
//             DateFormat(
//               'dd/MM/yyyy',
//             ).format(DateTime.parse(course.updatedAt ?? '')),
//           ),
//         ),
//         DataCell(
//           Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               IconButton(
//                 icon: Icon(Icons.visibility, color: Colors.blue),
//                 onPressed: () => {},
//               ),
//               IconButton(
//                 icon: Icon(Icons.edit, color: Colors.orange),
//                 onPressed: () => {},
//               ),
//               IconButton(
//                 icon: Icon(Icons.delete, color: Colors.red),
//                 onPressed: () => {},
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
