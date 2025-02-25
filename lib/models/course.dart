class CourseStats {
  String? nId;
  int? totalCourses;
  int? totalStudents;
  int? totalRevenue;

  CourseStats({
    this.nId,
    this.totalCourses,
    this.totalStudents,
    this.totalRevenue,
  });

  CourseStats.fromJson(Map<String, dynamic> json) {
    nId = json['_id'];
    totalCourses = json['total_courses'];
    totalStudents = json['total_students'];
    totalRevenue = json['total_revenue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = nId;
    data['total_courses'] = totalCourses;
    data['total_students'] = totalStudents;
    data['total_revenue'] = totalRevenue;
    return data;
  }
}
