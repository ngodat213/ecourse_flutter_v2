import 'package:dio/dio.dart';
import 'package:ecourse_flutter_v2/core/services/base_api.dart';

abstract class CourseRepository {
  Future<ApiResponse> getCourses([Map<String, dynamic>? filters]);
  Future<ApiResponse> getCourseById(String id);
  Future<ApiResponse> getEnrolledCourses();
  Future<ApiResponse> enrollCourse(String courseId);
  Future<ApiResponse> createCourse({
    required String title,
    required String description,
    required String categoryId,
    required String instructorId,
    required double price,
    required String type,
    String? level,
    List<String>? categories,
  });
  Future<ApiResponse> updateCourse({
    required String courseId,
    String? title,
    String? description,
    double? price,
    String? type,
    String? level,
    String? status,
    List<String>? categories,
    MultipartFile? thumbnail,
  });
  Map<String, dynamic> buildFilters({
    String? search,
    String? level,
    String? status,
    double? price,
    String? instructorId,
    String? category,
  });
}
