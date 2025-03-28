import 'package:ecourse_flutter_v2/enums/lesson_content_type.enum.dart';
import 'package:ecourse_flutter_v2/app/data/models/cloudinary_file.dart';
import 'package:ecourse_flutter_v2/app/data/models/quiz_model.dart';

class LessonContentModel {
  String? sId;
  String? lessonId;
  String? title;
  LessonContentType? type;
  int? order;
  int? duration;
  CloudinaryFile? video;
  QuizModel? quiz;
  // List<Null>? attachments;
  // List<Null>? requirements;
  // List<Null>? comments;
  String? status;
  int? version;
  String? createdAt;
  String? updatedAt;
  int? iV;

  LessonContentModel({
    this.sId,
    this.lessonId,
    this.title,
    this.type,
    this.order,
    this.duration,
    this.video,
    this.quiz,
    // this.attachments,
    // this.requirements,
    // this.comments,
    this.status,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  LessonContentModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    lessonId = json['lesson_id'];
    title = json['title'];
    type = LessonContentType.values.byName(json['type']);
    order = json['order'];
    duration = json['duration'].ceil();
    video =
        json['video'] != null ? CloudinaryFile.fromJson(json['video']) : null;
    quiz = json['quiz'] != null ? QuizModel.fromJson(json['quiz']) : null;
    // if (json['attachments'] != null) {
    //   attachments = <Null>[];
    //   json['attachments'].forEach((v) {
    //     attachments!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['requirements'] != null) {
    //   requirements = <Null>[];
    //   json['requirements'].forEach((v) {
    //     requirements!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['comments'] != null) {
    //   comments = <Null>[];
    //   json['comments'].forEach((v) {
    //     comments!.add(new Null.fromJson(v));
    //   });
    // }
    status = json['status'];
    version = json['version'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['lesson_id'] = lessonId;
    data['title'] = title;
    data['type'] = type?.name;
    data['order'] = order;
    data['duration'] = duration;
    if (video != null) {
      data['video'] = video!.toJson();
    }
    if (quiz != null) {
      data['quiz'] = quiz!.toJson();
    }
    // if (this.attachments != null) {
    //   data['attachments'] = this.attachments!.map((v) => v.toJson()).toList();
    // }
    // if (this.requirements != null) {
    //   data['requirements'] = this.requirements!.map((v) => v.toJson()).toList();
    // }
    // if (this.comments != null) {
    //   data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    // }
    data['status'] = status;
    data['version'] = version;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
