class QuizModel {
  String? sId;
  String? lessonId;
  int? duration;
  int? passingScore;
  int? totalQuestions;
  bool? randomQuestions;
  int? questionsPerExam;
  String? status;
  int? attemptsAllowed;
  String? createdAt;
  String? updatedAt;
  int? iV;

  QuizModel({
    this.sId,
    this.lessonId,
    this.duration,
    this.passingScore,
    this.totalQuestions,
    this.randomQuestions,
    this.questionsPerExam,
    this.status,
    this.attemptsAllowed,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  QuizModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    lessonId = json['lesson_id'];
    duration = json['duration'];
    passingScore = json['passing_score'];
    totalQuestions = json['total_questions'];
    randomQuestions = json['random_questions'];
    questionsPerExam = json['questions_per_exam'];
    status = json['status'];
    attemptsAllowed = json['attempts_allowed'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['lesson_id'] = lessonId;
    data['duration'] = duration;
    data['passing_score'] = passingScore;
    data['total_questions'] = totalQuestions;
    data['random_questions'] = randomQuestions;
    data['questions_per_exam'] = questionsPerExam;
    data['status'] = status;
    data['attempts_allowed'] = attemptsAllowed;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
