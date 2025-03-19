class CourseProgressModel {
  final String courseId;
  final double progress;

  CourseProgressModel({required this.courseId, required this.progress});

  factory CourseProgressModel.fromJson(Map<String, dynamic> json) {
    return CourseProgressModel(
      courseId: json['courseId'],
      progress: json['progress'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'courseId': courseId, 'progress': progress};
  }
}
