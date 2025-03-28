import 'package:ecourse_flutter_v2/core/services/base_api.dart';

abstract class CartRepository {
  Future<ApiResponse> getCart();
  Future<ApiResponse> addToCart(String courseId);
  Future<ApiResponse> removeFromCart(String courseId);
  Future<ApiResponse> clearCart();
  Future<ApiResponse> checkout(String paymentMethodId);
}
