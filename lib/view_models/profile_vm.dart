import 'package:ecourse_flutter_v2/core/base/base_view_model.dart';
import 'package:ecourse_flutter_v2/core/routes/app_routes.dart';
import 'package:ecourse_flutter_v2/app/data/models/order_model.dart';
import 'package:ecourse_flutter_v2/app/data/models/user_profile.dart';
import 'package:ecourse_flutter_v2/app/data/repositories/order_repository_impl.dart';
import 'package:ecourse_flutter_v2/view_models/user_vm.dart';
import 'package:provider/provider.dart';

class ProfileVM extends BaseVM {
  final OrderRepositoryImpl _orderRepository = OrderRepositoryImpl();
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
}
