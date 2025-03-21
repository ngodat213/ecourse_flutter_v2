import 'package:ecourse_flutter_v2/models/course_model.dart';

class CategoryModel {
  String? sId;
  String? name;
  String? description;
  String? parentId;
  String? status;
  int? order;
  String? icon;
  List<CourseModel>? courses;
  int? courseCount;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CategoryModel({
    this.sId,
    this.name,
    this.description,
    this.parentId,
    this.status,
    this.order,
    this.icon,
    this.courses,
    this.courseCount,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  CategoryModel.fromJson(
    Map<String, dynamic> json, {
    bool includeCourses = false,
  }) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    parentId = json['parent_id'];
    status = json['status'];
    order = json['order'];
    icon = json['icon'];
    if (includeCourses && json['courses'] != null) {
      courses = <CourseModel>[];
      json['courses'].forEach((v) {
        courses!.add(CourseModel.fromJson(v));
      });
    }
    courseCount = json['course_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['description'] = description;
    data['parent_id'] = parentId;
    data['status'] = status;
    data['order'] = order;
    data['icon'] = icon;
    if (courses != null) {
      data['courses'] = courses!.map((v) => v.toJson()).toList();
    }
    data['course_count'] = courseCount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
