class UserProgressModel {
  String? sId;
  String? userId;
  String? courseId;
  String? lessonId;
  String? status;
  double? progressPercent;
  String? createdAt;
  String? updatedAt;
  int? iV;

  UserProgressModel({
    this.sId,
    this.userId,
    this.courseId,
    this.lessonId,
    this.status,
    this.progressPercent,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  UserProgressModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['user_id'];
    courseId = json['course_id'];
    lessonId = json['lesson_id'];
    status = json['status'];
    progressPercent = json['progress_percent'].toDouble();
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
    data['status'] = status;
    data['progress_percent'] = progressPercent;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
