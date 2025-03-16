import 'package:ecourse_flutter_v2/core/base/base_view_model.dart';
import 'package:ecourse_flutter_v2/models/quiz_model.dart';
import 'package:flutter/material.dart';

class QuizVM extends BaseVM {
  QuizVM(super.context, this.quiz);

  final QuizModel? quiz;

  void onQuizComplete(Map<String, dynamic> result) {
    // TODO: Xử lý khi hoàn thành quiz
    // Có thể cập nhật tiến độ bài học, điểm số, v.v.
    Navigator.pop(context, result);
  }
}
