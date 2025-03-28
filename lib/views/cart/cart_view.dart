import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/widgets/buttons/elevated_button.dart';
import 'package:ecourse_flutter_v2/core/widgets/smart_image.dart';
import 'package:ecourse_flutter_v2/app/data/models/cart_item.dart';
import 'package:ecourse_flutter_v2/view_models/cart_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/base/base_view.dart';
import '../../views/cart/widgets/payment_method_sheet.dart';

class CartView extends BaseView<CartVM> {
  const CartView({super.key});

  @override
  CartVM createViewModel(
    BuildContext context,
    Map<String, dynamic>? arguments,
  ) {
    return CartVM(context);
  }

  @override
  PreferredSizeWidget buildAppBar(BuildContext context, CartVM viewModel) {
    return AppBar(
      backgroundColor: AppColor.background,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text('Buy Now'),
    );
  }

  @override
  Widget? buildFloatingActionButton(BuildContext context, CartVM viewModel) {
    return CustomElevatedButton(
      width: 0.9.sw,
      context: context,
      text: viewModel.isProcessingPayment ? 'Đang xử lý...' : 'Checkout',
      onPressed: () {
        if (viewModel.isProcessingPayment) {
          return;
        }
        viewModel.checkout();
      },
    );
  }

  @override
  Widget buildView(BuildContext context, CartVM viewModel) {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(viewModel.error!, style: TextStyle(color: AppColor.error)),
            ElevatedButton(
              onPressed: () => viewModel.loadCartItems(),
              child: const Text('Thử lại'),
            ),
          ],
        ),
      );
    }

    if (viewModel.cartItems.isEmpty) {
      return const Center(child: Text('Giỏ hàng trống'));
    }

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            // Cart Items
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.cartItems.length,
              itemBuilder: (context, index) {
                final item = viewModel.cartItems[index];
                return _buildCartItem(context, item, viewModel);
              },
            ),

            // Promo Code
            Card(
              color: AppColor.background,
              child: ListTile(
                leading: Icon(
                  Icons.local_offer_outlined,
                  color: AppColor.primary,
                ),
                title: const Text("Let's put the promo first"),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // TODO: Show promo code dialog
                },
              ),
            ),
            SizedBox(height: 16.h),

            // Payment Summary
            Card(
              color: AppColor.background,
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Payment summary',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    _buildSummaryRow(
                      'Total items',
                      '${viewModel.cartItems.length} item',
                    ),
                    _buildSummaryRow('Price', '\$${viewModel.totalAmount}'),
                    const Divider(),
                    _buildSummaryRow(
                      'Total payment',
                      '\$${viewModel.totalAmount}',
                    ),
                    SizedBox(height: 8.h),
                    InkWell(
                      onTap: () {
                        // TODO: Show details
                      },
                      child: Text(
                        'See details',
                        style: TextStyle(
                          color: AppColor.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // Payment Method
            Card(
              color: AppColor.background,
              child: ListTile(
                leading: Icon(Icons.payment, color: AppColor.primary),
                title: Text(
                  viewModel.selectedPaymentMethod?.name ??
                      'Select a payment method',
                ),
                subtitle:
                    viewModel.selectedPaymentMethod != null
                        ? Text(
                          viewModel.selectedPaymentMethod!.description,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColor.textSecondary,
                          ),
                        )
                        : null,
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder:
                        (context) => PaymentMethodSheet(
                          methods: viewModel.paymentMethods,
                          selectedMethod: viewModel.selectedPaymentMethod,
                          onSelect: viewModel.selectPaymentMethod,
                        ),
                  );
                },
              ),
            ),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, CartItem item, CartVM viewModel) {
    return Card(
      color: AppColor.background,
      margin: EdgeInsets.only(bottom: 16.h),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Thumbnail
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: SmartImage(
                    source: item.courseId?.thumnail?.url ?? '',
                    width: 80.w,
                    height: 80.w,
                  ),
                ),
                SizedBox(width: 12.w),

                // Course Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.courseId?.title ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16.w),
                          Text(
                            ' ${item.courseId?.rating} (${item.courseId?.reviewCount} Reviews)',
                            style: TextStyle(
                              color: AppColor.textSecondary,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      // Wrap(
                      //   spacing: 8.w,
                      //   children:
                      //         item.tags.map((tag) {
                      //         return Container(
                      //           padding: EdgeInsets.symmetric(
                      //             horizontal: 8.w,
                      //             vertical: 4.h,
                      //           ),
                      //           decoration: BoxDecoration(
                      //             color: AppColor.primary.withOpacity(0.1),
                      //             borderRadius: BorderRadius.circular(4.r),
                      //           ),
                      //           child: Text(
                      //             tag,
                      //             style: TextStyle(
                      //               color: AppColor.primary,
                      //               fontSize: 10.sp,
                      //             ),
                      //           ),
                      //         );
                      //       }).toList(),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // Course Details
            Row(
              children: [
                _buildDetailItem(
                  Icons.all_inclusive,
                  item.courseId?.level ?? '',
                ),
                SizedBox(width: 16.w),
                _buildDetailItem(
                  Icons.access_time,
                  '${item.courseId?.totalDuration} Total Hours',
                ),
                SizedBox(width: 16.w),
                // _buildDetailItem(
                //   Icons.article_outlined,
                //   '${item.totalMaterials} Materials',
                // ),
              ],
            ),
            SizedBox(height: 12.h),

            // Price and Remove
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${item.price}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                    color: AppColor.primary,
                  ),
                ),
                TextButton(
                  onPressed:
                      () => viewModel.removeItem(item.courseId?.sId ?? ''),
                  child: Text(
                    'Remove',
                    style: TextStyle(color: Colors.red, fontSize: 14.sp),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16.w, color: AppColor.textSecondary),
        SizedBox(width: 4.w),
        Text(
          text,
          style: TextStyle(color: AppColor.textSecondary, fontSize: 12.sp),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: AppColor.textSecondary, fontSize: 14.sp),
          ),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}
