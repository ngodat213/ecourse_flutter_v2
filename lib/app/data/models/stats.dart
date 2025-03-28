import 'package:ecourse_flutter_v2/app/data/models/course_model.dart';

class Stats {
  List<CourseModel>? courses;
  // List<Null>? students;
  // List<Null>? ratings;

  Stats({
    this.courses,
    // this.students, this.ratings
  });

  Stats.fromJson(Map<String, dynamic> json) {
    if (json['courses'] != null) {
      courses = <CourseModel>[];
      json['courses'].forEach((v) {
        courses!.add(CourseModel.fromJson(v));
      });
    }
    // if (json['students'] != null) {
    //   students = <Null>[];
    //   json['students'].forEach((v) {
    //     students!.add(Null.fromJson(v));
    //   });
    // }
    // if (json['ratings'] != null) {
    //   ratings = <Null>[];
    //   json['ratings'].forEach((v) {
    //     ratings!.add(Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (courses != null) {
      data['courses'] = courses!.map((v) => v.toJson()).toList();
    }
    // if (students != null) {
    //   data['students'] = students!.map((v) => v.toJson()).toList();
    // }
    // if (ratings != null) {
    //   data['ratings'] = ratings!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
