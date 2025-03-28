class ReadReceipt {
  final String userId;
  final DateTime readAt;

  ReadReceipt({required this.userId, required this.readAt});

  factory ReadReceipt.fromJson(Map<String, dynamic> json) {
    return ReadReceipt(
      userId: json['user'],
      readAt: DateTime.parse(json['readAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'user': userId, 'readAt': readAt.toIso8601String()};
  }
}
