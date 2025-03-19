import 'package:ecourse_flutter_v2/models/lesson_content_model.dart';

class UserProgressModel {
  String? sId;
  String? userId;
  String? courseId;
  String? lessonId;
  LessonContentModel? lessonContent;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;

  UserProgressModel({
    this.sId,
    this.userId,
    this.courseId,
    this.lessonId,
    this.lessonContent,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  UserProgressModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['user_id'];
    courseId = json['course_id'];
    lessonId = json['lesson_id'];
    lessonContent = LessonContentModel.fromJson(json['content_id']);
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['user_id'] = userId;
    data['course_id'] = courseId;
    data['lesson_id'] = lessonId;
    data['lesson_content'] = lessonContent?.toJson();
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
