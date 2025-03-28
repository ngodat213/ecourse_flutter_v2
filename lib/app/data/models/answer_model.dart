class AnswerModel {
  String? sId;
  String? text;

  AnswerModel({this.sId, this.text});

  AnswerModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['text'] = text;
    return data;
  }
}
