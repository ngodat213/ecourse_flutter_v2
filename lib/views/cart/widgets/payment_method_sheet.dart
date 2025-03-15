import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/widgets/smart_image.dart';
import 'package:ecourse_flutter_v2/models/payment_method.dart';

class PaymentMethodSheet extends StatelessWidget {
  final List<PaymentMethod> methods;
  final PaymentMethod? selectedMethod;
  final Function(PaymentMethod) onSelect;

  const PaymentMethodSheet({
    super.key,
    required this.methods,
    required this.onSelect,
    this.selectedMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 0.8.sh),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Select a payment method',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Payment Methods List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: methods.length,
            separatorBuilder: (_, __) => Divider(height: 1.h),
            itemBuilder: (context, index) {
              final method = methods[index];
              final isSelected = selectedMethod?.id == method.id;

              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  width: 40.w,
                  height: 40.w,
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: AppColor.cardColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: SmartImage(source: method.icon),
                ),
                title: Text(
                  method.name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  method.description,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColor.textSecondary,
                  ),
                ),
                trailing:
                    isSelected
                        ? Icon(Icons.check_circle, color: AppColor.primary)
                        : Icon(
                          Icons.chevron_right,
                          color: AppColor.textSecondary,
                        ),
                onTap: () {
                  onSelect(method);
                  Navigator.pop(context);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
