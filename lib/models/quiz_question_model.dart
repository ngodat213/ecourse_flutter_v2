import 'package:ecourse_flutter_v2/models/answer_model.dart';
import 'package:ecourse_flutter_v2/models/cloudinary_file.dart';

class QuizQuestionModel {
  String? sId;
  String? question;
  CloudinaryFile? imageId;
  List<AnswerModel>? answers;
  int? points;

  QuizQuestionModel({
    this.sId,
    this.question,
    this.imageId,
    this.answers,
    this.points,
  });

  QuizQuestionModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    question = json['question'];
    imageId =
        json['image_id'] != null
            ? CloudinaryFile.fromJson(json['image_id'])
            : null;
    if (json['answers'] != null) {
      answers = <AnswerModel>[];
      json['answers'].forEach((v) {
        answers!.add(AnswerModel.fromJson(v));
      });
    }
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['question'] = question;
    if (imageId != null) {
      data['image_id'] = imageId!.toJson();
    }
    if (answers != null) {
      data['answers'] = answers!.map((v) => v.toJson()).toList();
    }
    data['points'] = points;
    return data;
  }
}
