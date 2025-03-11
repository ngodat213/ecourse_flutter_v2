enum LessonContentType { video, document, quiz }

class LessonContentModel {
  final String id;
  final String title;
  final String duration;
  final LessonContentType type;
  final bool isCompleted;
  final String resourceUrl;

  LessonContentModel({
    required this.id,
    required this.title,
    required this.duration,
    required this.type,
    this.isCompleted = false,
    this.resourceUrl = '',
  });

  LessonContentModel copyWith({
    String? id,
    String? title,
    String? duration,
    LessonContentType? type,
    bool? isCompleted,
    String? resourceUrl,
  }) {
    return LessonContentModel(
      id: id ?? this.id,
      title: title ?? this.title,
      duration: duration ?? this.duration,
      type: type ?? this.type,
      isCompleted: isCompleted ?? this.isCompleted,
      resourceUrl: resourceUrl ?? this.resourceUrl,
    );
  }

  // Từ JSON
  factory LessonContentModel.fromJson(Map<String, dynamic> json) {
    return LessonContentModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      duration: json['duration'] ?? '',
      type: _typeFromString(json['type'] ?? 'video'),
      isCompleted: json['isCompleted'] ?? false,
      resourceUrl: json['resourceUrl'] ?? '',
    );
  }

  // Sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'duration': duration,
      'type': _typeToString(type),
      'isCompleted': isCompleted,
      'resourceUrl': resourceUrl,
    };
  }

  // Helper methods để chuyển đổi enum <-> string
  static LessonContentType _typeFromString(String type) {
    switch (type) {
      case 'video':
        return LessonContentType.video;
      case 'document':
        return LessonContentType.document;
      case 'quiz':
        return LessonContentType.quiz;
      default:
        return LessonContentType.video;
    }
  }

  static String _typeToString(LessonContentType type) {
    switch (type) {
      case LessonContentType.video:
        return 'video';
      case LessonContentType.document:
        return 'document';
      case LessonContentType.quiz:
        return 'quiz';
    }
  }
}

class LessonModel {
  final String id;
  final String number;
  final String title;
  final String duration;
  final List<LessonContentModel> contents;
  final int completedContentsCount;

  LessonModel({
    required this.id,
    required this.number,
    required this.title,
    required this.duration,
    required this.contents,
    int? completedContentsCount,
  }) : completedContentsCount =
           completedContentsCount ??
           contents.where((content) => content.isCompleted).length;

  // Constructor để tạo copy của model với một số thuộc tính mới
  LessonModel copyWith({
    String? id,
    String? number,
    String? title,
    String? duration,
    List<LessonContentModel>? contents,
    int? completedContentsCount,
  }) {
    return LessonModel(
      id: id ?? this.id,
      number: number ?? this.number,
      title: title ?? this.title,
      duration: duration ?? this.duration,
      contents: contents ?? this.contents,
      completedContentsCount: completedContentsCount,
    );
  }

  // Trạng thái hoàn thành của bài học
  bool get isCompleted => completedContentsCount == contents.length;

  // Tỷ lệ phần trăm hoàn thành
  int get progressPercentage =>
      contents.isEmpty ? 0 : (completedContentsCount * 100 ~/ contents.length);

  // Từ JSON
  factory LessonModel.fromJson(Map<String, dynamic> json) {
    final contentsList =
        (json['contents'] as List?)
            ?.map((x) => LessonContentModel.fromJson(x))
            .toList() ??
        <LessonContentModel>[];

    return LessonModel(
      id: json['id'] ?? '',
      number: json['number'] ?? '',
      title: json['title'] ?? '',
      duration: json['duration'] ?? '',
      contents: contentsList,
      completedContentsCount: json['completedContentsCount'],
    );
  }

  // Sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'number': number,
      'title': title,
      'duration': duration,
      'contents': contents.map((content) => content.toJson()).toList(),
      'completedContentsCount': completedContentsCount,
    };
  }
}
