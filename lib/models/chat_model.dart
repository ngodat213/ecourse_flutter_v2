enum MessageType { text, image, file, voice }

class MessageModel {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final MessageType type;
  final DateTime createdAt;
  final bool isRead;
  final String? fileUrl;
  final int? fileSize;

  MessageModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.type,
    required this.createdAt,
    this.isRead = false,
    this.fileUrl,
    this.fileSize,
  });

  // Tạo bản sao với các thuộc tính mới
  MessageModel copyWith({
    String? id,
    String? senderId,
    String? receiverId,
    String? content,
    MessageType? type,
    DateTime? createdAt,
    bool? isRead,
    String? fileUrl,
    int? fileSize,
  }) {
    return MessageModel(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      content: content ?? this.content,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
      fileUrl: fileUrl ?? this.fileUrl,
      fileSize: fileSize ?? this.fileSize,
    );
  }

  // Từ JSON
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] ?? '',
      senderId: json['senderId'] ?? '',
      receiverId: json['receiverId'] ?? '',
      content: json['content'] ?? '',
      type: _messageTypeFromString(json['type'] ?? 'text'),
      createdAt:
          json['createdAt'] != null
              ? DateTime.parse(json['createdAt'])
              : DateTime.now(),
      isRead: json['isRead'] ?? false,
      fileUrl: json['fileUrl'],
      fileSize: json['fileSize'],
    );
  }

  // Sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'content': content,
      'type': _messageTypeToString(type),
      'createdAt': createdAt.toIso8601String(),
      'isRead': isRead,
      'fileUrl': fileUrl,
      'fileSize': fileSize,
    };
  }

  // Helper methods để chuyển đổi enum <-> string
  static MessageType _messageTypeFromString(String type) {
    switch (type) {
      case 'text':
        return MessageType.text;
      case 'image':
        return MessageType.image;
      case 'file':
        return MessageType.file;
      case 'voice':
        return MessageType.voice;
      default:
        return MessageType.text;
    }
  }

  static String _messageTypeToString(MessageType type) {
    switch (type) {
      case MessageType.text:
        return 'text';
      case MessageType.image:
        return 'image';
      case MessageType.file:
        return 'file';
      case MessageType.voice:
        return 'voice';
    }
  }
}

class ChatModel {
  final String id;
  final String name;
  final String avatarUrl;
  final List<String> participantIds;
  final MessageModel? lastMessage;
  final int unreadCount;
  final bool isOnline;
  final DateTime lastActive;

  ChatModel({
    required this.id,
    required this.name,
    this.avatarUrl = '',
    required this.participantIds,
    this.lastMessage,
    this.unreadCount = 0,
    this.isOnline = false,
    DateTime? lastActive,
  }) : lastActive = lastActive ?? DateTime.now();

  // Tạo bản sao với các thuộc tính mới
  ChatModel copyWith({
    String? id,
    String? name,
    String? avatarUrl,
    List<String>? participantIds,
    MessageModel? lastMessage,
    int? unreadCount,
    bool? isOnline,
    DateTime? lastActive,
  }) {
    return ChatModel(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      participantIds: participantIds ?? this.participantIds,
      lastMessage: lastMessage ?? this.lastMessage,
      unreadCount: unreadCount ?? this.unreadCount,
      isOnline: isOnline ?? this.isOnline,
      lastActive: lastActive ?? this.lastActive,
    );
  }

  // Từ JSON
  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      avatarUrl: json['avatarUrl'] ?? '',
      participantIds: List<String>.from(json['participantIds'] ?? []),
      lastMessage:
          json['lastMessage'] != null
              ? MessageModel.fromJson(json['lastMessage'])
              : null,
      unreadCount: json['unreadCount'] ?? 0,
      isOnline: json['isOnline'] ?? false,
      lastActive:
          json['lastActive'] != null
              ? DateTime.parse(json['lastActive'])
              : DateTime.now(),
    );
  }

  // Sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatarUrl': avatarUrl,
      'participantIds': participantIds,
      'lastMessage': lastMessage?.toJson(),
      'unreadCount': unreadCount,
      'isOnline': isOnline,
      'lastActive': lastActive.toIso8601String(),
    };
  }
}
