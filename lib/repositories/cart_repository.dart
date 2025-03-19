import 'package:ecourse_flutter_v2/core/services/base_api.dart';

class CartRepository {
  final BaseAPI _api;

  CartRepository({BaseAPI? api}) : _api = api ?? BaseAPI();

  // Lấy thông tin giỏ hàng
  Future<ApiResponse> getCart() async {
    try {
      final response = await _api.fetchData('/cart', method: ApiMethod.GET);
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  // Thêm khóa học vào giỏ hàng
  Future<ApiResponse> addToCart(String courseId) async {
    try {
      final response = await _api.fetchData(
        '/cart/add',
        method: ApiMethod.POST,
        body: {'course_id': courseId},
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  // Xóa khóa học khỏi giỏ hàng
  Future<ApiResponse> removeFromCart(String courseId) async {
    try {
      final response = await _api.fetchData(
        '/cart/remove',
        method: ApiMethod.POST,
        body: {'course_id': courseId},
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  // Xóa toàn bộ giỏ hàng
  Future<ApiResponse> clearCart() async {
    try {
      final response = await _api.fetchData(
        '/cart/clear',
        method: ApiMethod.POST,
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  // Thêm vào CartRepository
  Future<ApiResponse> checkout(String? paymentMethodId) async {
    try {
      final response = await _api.fetchData(
        '/cart/checkout',
        body: {'payment_method': paymentMethodId},
        method: ApiMethod.POST,
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }
}
