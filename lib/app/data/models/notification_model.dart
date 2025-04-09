class NotificationModel {
  final String? sId;
  final String? userId;
  final String? type;
  final String? title;
  final String? message;
  final Map<String, dynamic>? data;
  final String? actionUrl;
  final bool? read;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  NotificationModel({
    this.sId,
    this.userId,
    this.type,
    this.title,
    this.message,
    this.data,
    this.actionUrl,
    this.read,
    this.createdAt,
    this.updatedAt,
  });

  String get typeString {
    switch (type) {
      case 'comment':
        return 'Comment';
      case 'like':
        return 'Like';
      case 'follow':
        return 'Follow';
      case 'new_message':
        return 'New Message';
      case 'new_comment':
        return 'New Comment';
      case 'new_like':
        return 'New Like';
      case 'new_follow':
        return 'New Follow';
      default:
        return type ?? '';
    }
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      sId: json['_id'],
      userId: json['user_id'],
      type: json['type'],
      title: json['title'],
      message: json['message'],
      data: json['data'],
      actionUrl: json['action_url'],
      read: json['read'],
      createdAt:
          json['created_at'] != null
              ? DateTime.parse(json['created_at'])
              : null,
      updatedAt:
          json['updated_at'] != null
              ? DateTime.parse(json['updated_at'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'user_id': userId,
      'type': type,
      'title': title,
      'message': message,
      'data': data,
      'action_url': actionUrl,
      'read': read,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
