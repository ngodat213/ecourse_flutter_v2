import 'package:ecourse_flutter_v2/app/domain/repositories/cart_repository.dart';
import 'package:ecourse_flutter_v2/core/services/base_api.dart';

class CartRepositoryImpl implements CartRepository {
  final BaseAPI _api;

  CartRepositoryImpl({BaseAPI? api}) : _api = api ?? BaseAPI();

  // Lấy thông tin giỏ hàng
  @override
  Future<ApiResponse> getCart() async {
    try {
      final response = await _api.fetchData('/cart', method: ApiMethod.GET);
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  // Thêm khóa học vào giỏ hàng
  @override
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
  @override
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
  @override
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
  @override
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
