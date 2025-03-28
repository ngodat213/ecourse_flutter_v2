import 'package:ecourse_flutter_v2/app/data/models/fileinfo_model.dart';
import 'package:ecourse_flutter_v2/app/data/models/read_receipt_model.dart';
import 'package:ecourse_flutter_v2/enums/message_type.enum.dart';

class MessageModel {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final MessageType type;
  final DateTime createdAt;
  final bool isRead;
  final FileInfo? fileInfo;
  final List<ReadReceipt> readBy;

  MessageModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.type,
    required this.createdAt,
    this.isRead = false,
    this.fileInfo,
    List<ReadReceipt>? readBy,
  }) : readBy = readBy ?? [];

  // Tạo bản sao với các thuộc tính mới
  MessageModel copyWith({
    String? id,
    String? senderId,
    String? receiverId,
    String? content,
    MessageType? type,
    DateTime? createdAt,
    bool? isRead,
    FileInfo? fileInfo,
    List<ReadReceipt>? readBy,
  }) {
    return MessageModel(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      content: content ?? this.content,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
      fileInfo: fileInfo ?? this.fileInfo,
      readBy: readBy ?? this.readBy,
    );
  }

  // Từ JSON
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['_id'] ?? json['id'] ?? '',
      senderId: json['sender'] ?? '',
      receiverId: json['conversation'] ?? '',
      content: json['content'] ?? '',
      type: _messageTypeFromString(json['contentType'] ?? 'text'),
      createdAt:
          json['createdAt'] != null
              ? DateTime.parse(json['createdAt'])
              : (json['timestamp'] != null
                  ? DateTime.parse(json['timestamp'])
                  : DateTime.now()),
      isRead: json['isRead'] ?? false,
      fileInfo:
          json['fileInfo'] != null ? FileInfo.fromJson(json['fileInfo']) : null,
      readBy:
          json['readBy'] != null
              ? List<ReadReceipt>.from(
                json['readBy'].map((x) => ReadReceipt.fromJson(x)),
              )
              : [],
    );
  }

  // Sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender': senderId,
      'conversation': receiverId,
      'content': content,
      'contentType': _messageTypeToString(type),
      'createdAt': createdAt.toIso8601String(),
      'isRead': isRead,
      if (fileInfo != null) 'fileInfo': fileInfo!.toJson(),
      'readBy': readBy.map((x) => x.toJson()).toList(),
    };
  }

  bool isReadByUser(String userId) {
    return readBy.any((receipt) => receipt.userId == userId);
  }

  // Helper methods để chuyển đổi enum <-> string
  static MessageType _messageTypeFromString(String type) {
    switch (type) {
      case 'image':
        return MessageType.image;
      case 'file':
        return MessageType.file;
      case 'text':
      default:
        return MessageType.text;
    }
  }

  static String _messageTypeToString(MessageType type) {
    switch (type) {
      case MessageType.image:
        return 'image';
      case MessageType.file:
        return 'file';
      case MessageType.text:
      default:
        return 'text';
    }
  }
}
