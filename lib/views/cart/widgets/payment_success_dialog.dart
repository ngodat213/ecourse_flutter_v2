import 'package:flutter/material.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentSuccessDialog extends StatelessWidget {
  const PaymentSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColor.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon ngón tay cái
          Container(
            width: 80.w,
            height: 80.w,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.thumb_up_alt_rounded,
              color: AppColor.primary,
              size: 40.w,
            ),
          ),

          SizedBox(height: 16.h),

          // Tiêu đề
          Text(
            'Congratulations the\npayment has been successful!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 8.h),

          // Nút đóng
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColor.primary,
              minimumSize: Size(double.infinity, 48.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Đóng',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),
          ),
        ],
      ),
    );
  }
}
