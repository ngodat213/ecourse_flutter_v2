import 'package:ecourse_flutter_v2/app/domain/repositories/order_repository.dart';
import 'package:ecourse_flutter_v2/core/config/app_config.dart';
import 'package:ecourse_flutter_v2/core/services/base_api.dart';

class OrderRepositoryImpl implements OrderRepository {
  final BaseAPI _api;

  OrderRepositoryImpl({BaseAPI? api}) : _api = api ?? BaseAPI();

  /// Tạo đơn hàng mới
  @override
  Future<ApiResponse> createOrder(Map<String, dynamic> orderData) async {
    try {
      final response = await _api.fetchData(
        AppConfig.orders,
        method: ApiMethod.POST,
        body: orderData,
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  /// Lấy danh sách tất cả đơn hàng của user
  @override
  Future<ApiResponse> getAllOrders() async {
    try {
      final response = await _api.fetchData(
        AppConfig.orders,
        method: ApiMethod.GET,
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  /// Lấy chi tiết đơn hàng theo ID
  @override
  Future<ApiResponse> getOrderById(String orderId) async {
    try {
      final response = await _api.fetchData(
        '${AppConfig.orders}/$orderId',
        method: ApiMethod.GET,
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  /// Lấy danh sách đơn hàng với filters
  @override
  Future<ApiResponse> getOrdersWithFilters(Map<String, dynamic> filters) async {
    try {
      final response = await _api.fetchData(
        AppConfig.orders,
        method: ApiMethod.GET,
        params: filters,
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  /// Build query parameters cho filters
  @override
  Map<String, dynamic> buildFilters({
    String? status,
    DateTime? fromDate,
    DateTime? toDate,
    int? limit,
    int? page,
  }) {
    final Map<String, dynamic> filters = {};

    if (status != null) filters['status'] = status;
    if (fromDate != null) filters['fromDate'] = fromDate.toIso8601String();
    if (toDate != null) filters['toDate'] = toDate.toIso8601String();
    if (limit != null) filters['limit'] = limit.toString();
    if (page != null) filters['page'] = page.toString();

    return filters;
  }
}
