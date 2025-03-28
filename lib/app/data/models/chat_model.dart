import 'package:ecourse_flutter_v2/enums/message_type.enum.dart';

class ChatModel {
  String? sId;
  String? conversation;
  Sender? sender;
  String? content;
  MessageType? contentType;
  List<ReadBy>? readBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? iV;

  ChatModel({
    this.sId,
    this.conversation,
    this.sender,
    this.content,
    this.contentType,
    this.readBy,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  ChatModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    conversation = json['conversation'];
    sender = json['sender'] != null ? Sender.fromJson(json['sender']) : null;
    content = json['content'];
    contentType =
        json['contentType'] != null
            ? MessageType.values.byName(json['contentType'])
            : null;
    if (json['readBy'] != null) {
      readBy = <ReadBy>[];
      json['readBy'].forEach((v) {
        readBy!.add(ReadBy.fromJson(v));
      });
    }
    createdAt = DateTime.parse(json['createdAt']);
    updatedAt = DateTime.parse(json['updatedAt']);
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['conversation'] = conversation;
    if (sender != null) {
      data['sender'] = sender!.toJson();
    }
    data['content'] = content;
    data['contentType'] = contentType?.name;
    if (readBy != null) {
      data['readBy'] = readBy!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Sender {
  String? sId;
  String? email;

  Sender({this.sId, this.email});

  Sender.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['email'] = email;
    return data;
  }
}

class ReadBy {
  String? user;
  String? sId;
  String? readAt;

  ReadBy({this.user, this.sId, this.readAt});

  ReadBy.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    sId = json['_id'];
    readAt = json['readAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user;
    data['_id'] = sId;
    data['readAt'] = readAt;
    return data;
  }
}
