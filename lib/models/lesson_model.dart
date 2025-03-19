import 'package:ecourse_flutter_v2/models/lesson_content_model.dart';

class LessonModel {
  String? sId;
  String? courseId;
  String? title;
  String? description;
  int? duration;
  bool? isFree;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;
  List<LessonContentModel>? contents;
  String? id;

  LessonModel({
    this.sId,
    this.courseId,
    this.title,
    this.description,
    this.duration,
    this.isFree,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.contents,
    this.id,
  });

  LessonModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    courseId = json['course_id'];
    title = json['title'];
    description = json['description'];
    duration = json['duration'].ceil();
    isFree = json['is_free'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    if (json['contents'] != null) {
      contents = <LessonContentModel>[];
      json['contents'].forEach((v) {
        contents!.add(LessonContentModel.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['course_id'] = courseId;
    data['title'] = title;
    data['description'] = description;
    data['duration'] = duration;
    data['is_free'] = isFree;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    if (contents != null) {
      data['contents'] = contents!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    return data;
  }
}
