import 'package:ecourse_flutter_v2/core/base/base_view_model.dart';
import 'package:ecourse_flutter_v2/core/routes/app_routes.dart';
import 'package:ecourse_flutter_v2/app/data/models/order_model.dart';
import 'package:ecourse_flutter_v2/app/data/models/user_profile.dart';
import 'package:ecourse_flutter_v2/app/data/repositories/order_repository_impl.dart';
import 'package:ecourse_flutter_v2/app/data/repositories/auth_repository_impl.dart';
import 'package:ecourse_flutter_v2/app/data/repositories/notification_repository_impl.dart';
import 'package:ecourse_flutter_v2/view_models/user_vm.dart';
import 'package:ecourse_flutter_v2/core/services/firebase_messaging_service.dart';
import 'package:ecourse_flutter_v2/core/services/shared_prefs.dart';
import 'package:ecourse_flutter_v2/core/config/app_config.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

class ProfileVM extends BaseVM {
  final OrderRepositoryImpl _orderRepository = OrderRepositoryImpl();
  final AuthRepositoryImpl _authRepository = AuthRepositoryImpl();
  final NotificationRepositoryImpl _notificationRepository =
      NotificationRepositoryImpl();
  final FirebaseMessagingService _firebaseMessaging =
      FirebaseMessagingService();
  ProfileVM(super.context);
  final List<OrderModel> _orders = [];

  UserProfile? get userProfile => context.read<UserVM>().userProfile;
  List<OrderModel> get orders => _orders;

  @override
  void onInit() {
    super.onInit();
    getAllOrders();
  }

  void redirectToProfile() {
    AppRoutes.push(context, AppRoutes.profile);
  }

  Future<void> getAllOrders() async {
    final response = await _orderRepository.getAllOrders();
    if (response.allGood) {
      for (var order in response.body['data']) {
        _orders.add(OrderModel.fromJson(order));
      }
      notifyListeners();
    }
  }

  Future<bool> logout() async {
    setLoading(true);

    try {
      // 1. Hủy đăng ký FCM token
      final fcmToken = _firebaseMessaging.fcmToken;
      if (fcmToken != null) {
        try {
          await _notificationRepository.unregisterFCMToken(fcmToken);
        } catch (e) {
          debugPrint('Error unregistering FCM token: $e');
          // Tiếp tục quá trình đăng xuất ngay cả khi hủy FCM thất bại
        }
      }

      // 2. Gọi API đăng xuất
      final refreshToken = SharedPrefs.getRefreshToken();
      if (refreshToken != null) {
        try {
          await _authRepository.logout(refreshToken: refreshToken);
        } catch (e) {
          debugPrint('Error logging out from API: $e');
          // Tiếp tục quá trình đăng xuất ngay cả khi API thất bại
        }
      }

      // 3. Xóa dữ liệu phiên đăng nhập
      await _clearUserData();

      // 4. Điều hướng về màn hình đăng nhập
      if (context.mounted) {
        AppRoutes.pushAndRemoveUntil(context, AppRoutes.login);
      }

      return true;
    } catch (e) {
      setError('Failed to logout: $e');
      return false;
    } finally {
      setLoading(false);
    }
  }

  Future<void> _clearUserData() async {
    // Xóa token
    await SharedPrefs.removeToken();
    await SharedPrefs.removeRefreshToken();

    // Xóa thông tin người dùng
    await SharedPrefs.removeUser();

    // Xóa các thông tin khác liên quan đến phiên đăng nhập
    await SharedPrefs.remove(AppConfig.userRoleKey);
    await SharedPrefs.remove(AppConfig.userIdKey);
    await SharedPrefs.remove(AppConfig.tokenExpiryKey);

    // Cập nhật UserViewModel
    if (context.mounted) {
      context.read<UserVM>().clearUserProfile();
    }
  }
}
