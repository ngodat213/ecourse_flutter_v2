import 'package:dio/dio.dart';
import 'package:ecourse_flutter_v2/core/config/app_config.dart';
import 'package:ecourse_flutter_v2/core/services/base_api.dart';

class CourseRepository {
  final BaseAPI _baseAPI = BaseAPI();

  // Lấy danh sách khóa học với filter
  Future<ApiResponse> getCourses([Map<String, dynamic>? filters]) async {
    final response = await _baseAPI.fetchData(
      AppConfig.courses,
      method: ApiMethod.GET,
      params: filters,
    );
    return ApiResponse.fromResponse(response.data);
  }

  // Lấy chi tiết khóa học
  Future<ApiResponse> getCourseById(String id) async {
    final response = await _baseAPI.fetchData(
      '${AppConfig.courses}/$id',
      method: ApiMethod.GET,
    );
    return ApiResponse.fromResponse(response.data);
  }

  // Lấy danh sách khóa học đã đăng ký
  Future<ApiResponse> getEnrolledCourses() async {
    final response = await _baseAPI.fetchData(
      '${AppConfig.courses}/my/enrolled',
      method: ApiMethod.GET,
    );
    return ApiResponse.fromResponse(response.data);
  }

  // Đăng ký khóa học
  Future<ApiResponse> enrollCourse(String courseId) async {
    final response = await _baseAPI.fetchData(
      '${AppConfig.courses}/$courseId/enroll',
      method: ApiMethod.POST,
    );
    return ApiResponse.fromResponse(response.data);
  }

  // Tạo khóa học mới
  Future<ApiResponse> createCourse({
    required String title,
    required String description,
    required double price,
    required String type,
    String? level,
    List<String>? categories,
    MultipartFile? thumbnail,
  }) async {
    final formData = FormData.fromMap({
      'title': title,
      'description': description,
      'price': price,
      'type': type,
      if (level != null) 'level': level,
      if (categories != null) 'categories': categories,
      if (thumbnail != null) 'thumbnail': thumbnail,
    });

    final response = await _baseAPI.fetchData(
      AppConfig.courses,
      method: ApiMethod.POST,
      body: formData,
    );
    return ApiResponse.fromResponse(response.data);
  }

  // Cập nhật khóa học
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
  }) async {
    final formData = FormData.fromMap({
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (price != null) 'price': price,
      if (type != null) 'type': type,
      if (level != null) 'level': level,
      if (status != null) 'status': status,
      if (categories != null) 'categories': categories,
      if (thumbnail != null) 'thumbnail': thumbnail,
    });

    final response = await _baseAPI.fetchData(
      '${AppConfig.courses}/$courseId',
      method: ApiMethod.PUT,
      body: formData,
    );
    return ApiResponse.fromResponse(response.data);
  }

  // Build query filters
  Map<String, dynamic> buildFilters({
    String? search,
    String? level,
    String? status,
    double? price,
    String? instructorId,
    String? category,
    int? page,
    int? limit,
    String? sort,
  }) {
    return {
      if (search != null && search.isNotEmpty) 'search': search,
      if (level != null) 'level': level,
      if (status != null) 'status': status,
      if (price != null) 'price': price,
      if (instructorId != null) 'instructor_id': instructorId,
      if (category != null) 'category': category,
      if (page != null) 'page': page,
      if (limit != null) 'limit': limit,
      if (sort != null) 'sort': sort,
    };
  }
}
