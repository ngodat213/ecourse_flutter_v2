class InstructorModel {
  final String id;
  final String name;
  final String profilePicture;
  final String title;
  final String bio;
  final int coursesCount;
  final int studentsCount;
  final double rating;
  final bool isFollowing;

  InstructorModel({
    this.id = '',
    required this.name,
    required this.profilePicture,
    required this.title,
    required this.bio,
    this.coursesCount = 0,
    this.studentsCount = 0,
    this.rating = 0,
    this.isFollowing = false,
  });

  // Constructor để tạo copy của model với một số thuộc tính mới
  InstructorModel copyWith({
    String? id,
    String? name,
    String? profilePicture,
    String? title,
    String? bio,
    int? coursesCount,
    int? studentsCount,
    double? rating,
    bool? isFollowing,
  }) {
    return InstructorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      profilePicture: profilePicture ?? this.profilePicture,
      title: title ?? this.title,
      bio: bio ?? this.bio,
      coursesCount: coursesCount ?? this.coursesCount,
      studentsCount: studentsCount ?? this.studentsCount,
      rating: rating ?? this.rating,
      isFollowing: isFollowing ?? this.isFollowing,
    );
  }

  // Từ JSON
  factory InstructorModel.fromJson(Map<String, dynamic> json) {
    return InstructorModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      profilePicture: json['profilePicture'] ?? '',
      title: json['title'] ?? '',
      bio: json['bio'] ?? '',
      coursesCount: json['coursesCount'] ?? 0,
      studentsCount: json['studentsCount'] ?? 0,
      rating: json['rating']?.toDouble() ?? 0.0,
      isFollowing: json['isFollowing'] ?? false,
    );
  }

  // Sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'profilePicture': profilePicture,
      'title': title,
      'bio': bio,
      'coursesCount': coursesCount,
      'studentsCount': studentsCount,
      'rating': rating,
      'isFollowing': isFollowing,
    };
  }
}
