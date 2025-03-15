import 'package:ecourse_flutter_v2/core/services/base_api.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentService {
  // Mở URL thanh toán
  static Future<bool> openPaymentUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      return false;
    }
  }

  // Kiểm tra trạng thái thanh toán
  static Future<ApiResponse> checkPaymentStatus(String orderId) async {
    try {
      final response = await BaseAPI().fetchData(
        '/payment/status/$orderId',
        method: ApiMethod.GET,
      );
      return ApiResponse.fromResponse(response.data);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }
}
