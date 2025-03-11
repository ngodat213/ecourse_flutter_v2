import 'instructor_model.dart';
import 'lesson_model.dart';

class CourseModel {
  final String id;
  final String title;
  final String description;
  final String aboutCourse;
  final String thumbnail;
  final String duration;
  final double rating;
  final int studentsCount;
  final int progressPercentage;
  final InstructorModel instructor;
  final List<LessonModel> lessons;
  final String category;
  final double price;
  final double originalPrice;
  final bool isFavorite;

  CourseModel({
    this.id = '',
    required this.title,
    required this.description,
    required this.aboutCourse,
    this.thumbnail = '',
    this.duration = '',
    this.rating = 0,
    this.studentsCount = 0,
    required this.progressPercentage,
    required this.instructor,
    this.lessons = const [],
    this.category = '',
    this.price = 0,
    this.originalPrice = 0,
    this.isFavorite = false,
  });

  // Constructor để tạo copy của model với một số thuộc tính mới
  CourseModel copyWith({
    String? id,
    String? title,
    String? description,
    String? aboutCourse,
    String? thumbnail,
    String? duration,
    double? rating,
    int? studentsCount,
    int? progressPercentage,
    InstructorModel? instructor,
    List<LessonModel>? lessons,
    String? category,
    double? price,
    double? originalPrice,
    bool? isFavorite,
  }) {
    return CourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      aboutCourse: aboutCourse ?? this.aboutCourse,
      thumbnail: thumbnail ?? this.thumbnail,
      duration: duration ?? this.duration,
      rating: rating ?? this.rating,
      studentsCount: studentsCount ?? this.studentsCount,
      progressPercentage: progressPercentage ?? this.progressPercentage,
      instructor: instructor ?? this.instructor,
      lessons: lessons ?? this.lessons,
      category: category ?? this.category,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  // Từ JSON
  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      aboutCourse: json['aboutCourse'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      duration: json['duration'] ?? '',
      rating: json['rating']?.toDouble() ?? 0.0,
      studentsCount: json['studentsCount'] ?? 0,
      progressPercentage: json['progressPercentage'] ?? 0,
      instructor:
          json['instructor'] != null
              ? InstructorModel.fromJson(json['instructor'])
              : InstructorModel(
                name: '',
                profilePicture: '',
                title: '',
                bio: '',
              ),
      lessons:
          json['lessons'] != null
              ? List<LessonModel>.from(
                json['lessons'].map((x) => LessonModel.fromJson(x)),
              )
              : [],
      category: json['category'] ?? '',
      price: json['price']?.toDouble() ?? 0.0,
      originalPrice: json['originalPrice']?.toDouble() ?? 0.0,
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  // Sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'aboutCourse': aboutCourse,
      'thumbnail': thumbnail,
      'duration': duration,
      'rating': rating,
      'studentsCount': studentsCount,
      'progressPercentage': progressPercentage,
      'instructor': instructor.toJson(),
      'lessons': lessons.map((x) => x.toJson()).toList(),
      'category': category,
      'price': price,
      'originalPrice': originalPrice,
      'isFavorite': isFavorite,
    };
  }
}
