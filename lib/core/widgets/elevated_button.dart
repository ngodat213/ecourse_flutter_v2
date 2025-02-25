import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.context,
    required this.text,
    required this.onPressed,
    this.leading,
    this.backgroundColor,
    this.foregroundColor,
    this.textStyle,
    this.width,
    this.padding,
  });

  final BuildContext context;
  final String text;
  final TextStyle? textStyle;
  final Widget? leading;
  final double? width;
  final EdgeInsets? padding;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding:
              padding ??
              const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          backgroundColor: backgroundColor ?? AppColor.primary,
          foregroundColor: foregroundColor ?? Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: width == null ? MainAxisSize.min : MainAxisSize.max,
          children: [
            leading ?? const SizedBox(),
            Text(
              text,
              style:
                  textStyle ??
                  Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
