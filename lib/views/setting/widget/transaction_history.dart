import 'package:easy_localization/easy_localization.dart';
import 'package:ecourse_flutter_v2/core/base/base_view.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/app/data/models/order_model.dart';
import 'package:ecourse_flutter_v2/view_models/profile_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class TransactionHistoryView extends BaseView<ProfileVM> {
  const TransactionHistoryView({super.key});

  @override
  ProfileVM createViewModel(
    BuildContext context,
    Map<String, dynamic>? arguments,
  ) {
    return ProfileVM(context);
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, ProfileVM viewModel) {
    return AppBar(
      title: Text('transaction_history'.tr()),
      backgroundColor: AppColor.background,
    );
  }

  @override
  Widget buildView(BuildContext context, ProfileVM vm) {
    return TransactionBuild(orders: vm.orders);
  }
}

class TransactionBuild extends StatefulWidget {
  const TransactionBuild({super.key, required this.orders});
  final List<OrderModel> orders;

  @override
  State<TransactionBuild> createState() => _TransactionBuildState();
}

class _TransactionBuildState extends State<TransactionBuild> {
  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    items.add((items.length + 1).toString());
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: height),
          SizedBox(
            height: 1.sh - height,
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: WaterDropHeader(),
              footer: CustomFooter(
                builder: (context, mode) => Text("pull up load"),
              ),
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: ListView.builder(
                itemBuilder: (c, i) => _transactionItem(widget.orders[i]),
                itemExtent: 120.0,
                itemCount: widget.orders.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _transactionItem(OrderModel order) {
    return Container(
      margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.background,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColor.border),
        ),
        padding: EdgeInsets.all(10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('dd/MM/yyyy').format(DateTime.parse(order.createdAt!)),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColor.textSecondary,
                fontSize: 10.sp,
              ),
            ),
            Text(
              getStatus(order),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColor.textPrimary,
                fontSize: 15.sp,
              ),
            ),
            Text(
              '${order.paymentMethod?.name.toUpperCase()} ${order.amount}\$',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColor.textPrimary,
                fontSize: 15.sp,
              ),
            ),
            Text(
              order.status.toString(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColor.textSecondary,
                fontSize: 15.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getStatus(OrderModel order) {
    switch (order.status) {
      case 'success':
        return 'transaction_success'.tr();
      case 'failed':
        return 'transaction_failed'.tr();
      case 'pending':
        return 'transaction_pending'.tr();
      case 'refunded':
        return 'transaction_refunded'.tr();
      default:
        return 'transaction_expired'.tr();
    }
  }
}
