class Participant {
  final String userId;
  final String role;
  final DateTime joinedAt;

  Participant({
    required this.userId,
    required this.role,
    required this.joinedAt,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      userId: json['user'] is String ? json['user'] : json['user']['_id'] ?? '',
      role: json['role'] ?? 'student',
      joinedAt:
          json['joinedAt'] != null
              ? DateTime.parse(json['joinedAt'])
              : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': userId,
      'role': role,
      'joinedAt': joinedAt.toIso8601String(),
    };
  }
}
