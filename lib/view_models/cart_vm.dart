import 'package:ecourse_flutter_v2/models/cart_item.dart';
import 'package:ecourse_flutter_v2/view_models/login_vm.dart';
import 'package:ecourse_flutter_v2/views/cart/widgets/payment_success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:ecourse_flutter_v2/core/base/base_view_model.dart';
import 'package:ecourse_flutter_v2/models/payment_method.dart';
import 'package:ecourse_flutter_v2/repositories/cart_repository.dart';
import 'package:ecourse_flutter_v2/services/payment_service.dart';
import 'package:provider/provider.dart';

class CartVM extends BaseVM {
  final CartRepository _cartRepository;

  List<CartItem> _cartItems = [];
  double _totalAmount = 0;
  String? _promoCode;
  PaymentMethod? _selectedPaymentMethod;
  bool _isLoading = false;
  String? _error;
  String? _orderId;
  bool _isProcessingPayment = false;

  // Getters
  List<CartItem> get cartItems => _cartItems;
  double get totalAmount => _totalAmount;
  String? get promoCode => _promoCode;
  PaymentMethod? get selectedPaymentMethod => _selectedPaymentMethod;
  @override
  bool get isLoading => _isLoading;
  @override
  String? get error => _error;
  bool get isProcessingPayment => _isProcessingPayment;

  List<PaymentMethod> get paymentMethods => [
    PaymentMethod(
      id: 'momo',
      name: 'E-Wallet',
      description: 'Momo',
      icon: 'assets/svgs/momo.svg',
      type: PaymentType.momo,
    ),
  ];

  CartVM(super.context, {CartRepository? cartRepository})
    : _cartRepository = cartRepository ?? CartRepository() {
    loadCartItems();
  }

  Future<void> loadCartItems() async {
    try {
      _setLoading(true);
      final response = await _cartRepository.getCart();

      if (response.allGood) {
        final data = response.body;
        _cartItems =
            (data['items'] as List)
                .map((item) => CartItem.fromJson(item))
                .toList();
        _totalAmount = data['total_amount'].toDouble();
        notifyListeners();
      } else {
        _setError(response.message ?? 'Không thể tải giỏ hàng');
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addToCart(String courseId) async {
    try {
      _setLoading(true);
      final response = await _cartRepository.addToCart(courseId);

      if (response.allGood) {
        await loadCartItems(); // Tải lại giỏ hàng
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Đã thêm vào giỏ hàng')));
      } else {
        _setError(response.message ?? 'Không thể thêm vào giỏ hàng');
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> removeItem(String courseId) async {
    try {
      _setLoading(true);
      final response = await _cartRepository.removeFromCart(courseId);

      if (response.allGood) {
        await loadCartItems(); // Tải lại giỏ hàng
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Đã xóa khỏi giỏ hàng')));
      } else {
        _setError(response.message ?? 'Không thể xóa khỏi giỏ hàng');
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> clearCart() async {
    try {
      _setLoading(true);
      final response = await _cartRepository.clearCart();

      if (response.allGood) {
        _cartItems.clear();
        _totalAmount = 0;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đã xóa toàn bộ giỏ hàng')),
        );
      } else {
        _setError(response.message ?? 'Không thể xóa giỏ hàng');
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  void selectPaymentMethod(PaymentMethod method) {
    _selectedPaymentMethod = method;
    notifyListeners();
  }

  void applyPromoCode(String code) {
    _promoCode = code;
    // TODO: Implement promo code API
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String value) {
    _error = value;
    notifyListeners();
  }

  Future<void> checkout() async {
    if (_selectedPaymentMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng chọn phương thức thanh toán')),
      );
      return;
    }

    try {
      _isProcessingPayment = true;
      notifyListeners();

      final response = await _cartRepository.checkout(
        _selectedPaymentMethod?.id,
      );

      if (response.allGood) {
        final data = response.body;
        _orderId = data['order_id'];

        if (context.mounted) {
          await _showPaymentSuccessDialog(context);
          await loadCartItems();
          await context.read<LoginVM>().loadUserProfile();
        }
      } else {
        _setError(response.message ?? 'Không thể tạo đơn hàng');
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _isProcessingPayment = false;
      notifyListeners();
    }
  }

  // Thêm hàm hiển thị dialog thành công
  Future<void> _showPaymentSuccessDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PaymentSuccessDialog(),
    );
  }

  // Kiểm tra trạng thái thanh toán
  Future<void> checkPaymentStatus() async {
    if (_orderId == null) return;

    try {
      _setLoading(true);
      final response = await PaymentService.checkPaymentStatus(_orderId!);

      if (response.allGood) {
        final status = response.body['status'];

        if (status == 'success') {
          // Thanh toán thành công
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Thanh toán thành công')),
          );

          // Chuyển đến trang thành công
          Navigator.pushReplacementNamed(
            context,
            '/payment-success',
            arguments: {'order_id': _orderId},
          );
        } else if (status == 'pending') {
          // Thanh toán đang xử lý
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Thanh toán đang xử lý')),
          );
        } else {
          // Thanh toán thất bại
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Thanh toán thất bại')));
        }
      } else {
        _setError(
          response.message ?? 'Không thể kiểm tra trạng thái thanh toán',
        );
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }
}
