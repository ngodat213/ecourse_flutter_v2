import 'package:ecourse_flutter_v2/models/cloudinary_file.dart';

import 'teacher_model.dart';

class CourseModel {
  // List<Null>? categories;
  String? sId;
  String? title;
  String? description;
  int? price;
  TeacherModel? instructor;
  String? type;
  CloudinaryFile? thumnail;
  String? level;
  String? status;
  int? totalDuration;
  int? lessonCount;
  int? studentCount;
  int? rating;
  int? reviewCount;
  int? totalRevenue;
  List<String>? lessons;
  String? createdAt;
  String? updatedAt;

  CourseModel({
    // this.categories,
    this.sId,
    this.title,
    this.description,
    this.price,
    this.instructor,
    this.type,
    this.thumnail,
    this.level,
    this.status,
    this.totalDuration,
    this.lessonCount,
    this.studentCount,
    this.rating,
    this.reviewCount,
    this.totalRevenue,
    this.lessons,
    this.createdAt,
    this.updatedAt,
  });

  String get updatedAtString => updatedAt?.split('T')[0] ?? '';

  CourseModel.fromJson(Map<String, dynamic> json) {
    // if (json['categories'] != null) {
    //   categories = <Null>[];
    //   json['categories'].forEach((v) {
    //     categories!.add(Null.fromJson(v));
    //   });
    // }
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    instructor =
        json['instructor_id'] != null
            ? TeacherModel.fromJson(json['instructor_id'])
            : null;
    type = json['type'];
    thumnail =
        json['thumbnail_id'] != null
            ? CloudinaryFile.fromJson(json['thumbnail_id'])
            : null;
    level = json['level'];
    status = json['status'];
    totalDuration = json['total_duration'];
    lessonCount = json['lesson_count'];
    studentCount = json['student_count'];
    rating = json['rating'];
    reviewCount = json['review_count'];
    totalRevenue = json['total_revenue'];
    lessons = json['lessons'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // if (categories != null) {
    //   data['categories'] = categories!.map((v) => v.toJson()).toList();
    // }
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    if (instructor != null) {
      data['instructor_id'] = instructor!.toJson();
    }
    data['type'] = type;
    if (thumnail != null) {
      data['thumbnail_id'] = thumnail!.toJson();
    }
    data['level'] = level;
    data['status'] = status;
    data['total_duration'] = totalDuration;
    data['lesson_count'] = lessonCount;
    data['student_count'] = studentCount;
    data['rating'] = rating;
    data['review_count'] = reviewCount;
    data['total_revenue'] = totalRevenue;
    data['lessons'] = lessons;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
