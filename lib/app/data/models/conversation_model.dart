import 'package:ecourse_flutter_v2/app/data/models/message_model.dart';
import 'package:ecourse_flutter_v2/app/data/models/participant_model.dart';
import 'package:ecourse_flutter_v2/enums/conversation_type.enum.dart';

class ConversationModel {
  final String id;
  final String name;
  final String avatarUrl;
  final List<Participant> participants;
  final String? courseId;
  final ConversationType type;
  final MessageModel? lastMessage;
  final int unreadCount;
  final bool isOnline;
  final DateTime lastActive;
  final List<String> onlineUsers;
  final List<String> typingUsers;

  ConversationModel({
    required this.id,
    required this.name,
    this.avatarUrl = '',
    required this.participants,
    this.courseId,
    this.type = ConversationType.direct,
    this.lastMessage,
    this.unreadCount = 0,
    this.isOnline = false,
    DateTime? lastActive,
    List<String>? onlineUsers,
    List<String>? typingUsers,
  }) : lastActive = lastActive ?? DateTime.now(),
       onlineUsers = onlineUsers ?? [],
       typingUsers = typingUsers ?? [];

  // Tạo bản sao với các thuộc tính mới
  ConversationModel copyWith({
    String? id,
    String? name,
    String? avatarUrl,
    List<Participant>? participants,
    String? courseId,
    ConversationType? type,
    MessageModel? lastMessage,
    int? unreadCount,
    bool? isOnline,
    DateTime? lastActive,
    List<String>? onlineUsers,
    List<String>? typingUsers,
  }) {
    return ConversationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      participants: participants ?? this.participants,
      courseId: courseId ?? this.courseId,
      type: type ?? this.type,
      lastMessage: lastMessage ?? this.lastMessage,
      unreadCount: unreadCount ?? this.unreadCount,
      isOnline: isOnline ?? this.isOnline,
      lastActive: lastActive ?? this.lastActive,
      onlineUsers: onlineUsers ?? this.onlineUsers,
      typingUsers: typingUsers ?? this.typingUsers,
    );
  }

  // Từ JSON
  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? '',
      avatarUrl: json['avatarUrl'] ?? '',
      participants:
          json['participants'] != null
              ? List<Participant>.from(
                json['participants'].map((x) => Participant.fromJson(x)),
              )
              : [],
      courseId:
          json['courseId'] is Map ? json['courseId']['_id'] : json['courseId'],
      type:
          json['type'] == 'group'
              ? ConversationType.group
              : ConversationType.direct,
      lastMessage:
          json['lastMessage'] != null
              ? MessageModel.fromJson(json['lastMessage'])
              : null,
      unreadCount: json['unreadCount'] ?? 0,
      isOnline: json['isOnline'] ?? false,
      lastActive:
          json['updatedAt'] != null
              ? DateTime.parse(json['updatedAt'])
              : (json['lastActive'] != null
                  ? DateTime.parse(json['lastActive'])
                  : DateTime.now()),
      onlineUsers:
          json['onlineUsers'] != null
              ? List<String>.from(json['onlineUsers'])
              : [],
      typingUsers:
          json['typingUsers'] != null
              ? List<String>.from(json['typingUsers'])
              : [],
    );
  }

  // Từ JSON cấu trúc group chat từ server
  factory ConversationModel.fromGroupJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      avatarUrl: '',
      participants:
          json['participants'] != null
              ? List<Participant>.from(
                json['participants'].map((x) => Participant.fromJson(x)),
              )
              : [],
      courseId:
          json['courseId'] is Map ? json['courseId']['_id'] : json['courseId'],
      type: ConversationType.group,
      lastMessage:
          json['lastMessage'] != null
              ? MessageModel.fromJson(json['lastMessage'])
              : null,
      unreadCount: 0,
      isOnline: false,
      lastActive:
          json['updatedAt'] != null
              ? DateTime.parse(json['updatedAt'])
              : DateTime.now(),
      onlineUsers:
          json['onlineUsers'] != null
              ? List<String>.from(json['onlineUsers'])
              : [],
      typingUsers:
          json['typingUsers'] != null
              ? List<String>.from(json['typingUsers'])
              : [],
    );
  }

  // Sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatarUrl': avatarUrl,
      'participants': participants.map((x) => x.toJson()).toList(),
      if (courseId != null) 'courseId': courseId,
      'type': type == ConversationType.group ? 'group' : 'direct',
      if (lastMessage != null) 'lastMessage': lastMessage!.toJson(),
      'unreadCount': unreadCount,
      'isOnline': isOnline,
      'lastActive': lastActive.toIso8601String(),
      'onlineUsers': onlineUsers,
      'typingUsers': typingUsers,
    };
  }

  String getDisplayName(String currentUserId) {
    if (type == ConversationType.group) {
      return name;
    } else {
      // Tìm người tham gia khác không phải là người dùng hiện tại
      final otherParticipant = participants.firstWhere(
        (p) => p.userId != currentUserId,
        orElse: () => participants.first,
      );
      return name;
    }
  }
}
