import 'package:ecourse_flutter_v2/core/services/base_api.dart';

abstract class OrderRepository {
  Future<ApiResponse> createOrder(Map<String, dynamic> orderData);
  Future<ApiResponse> getAllOrders();
  Future<ApiResponse> getOrderById(String orderId);
  Future<ApiResponse> getOrdersWithFilters(Map<String, dynamic> filters);
  Map<String, dynamic> buildFilters({
    String? status,
    DateTime? fromDate,
    DateTime? toDate,
    int? limit,
    int? page,
  });
}
