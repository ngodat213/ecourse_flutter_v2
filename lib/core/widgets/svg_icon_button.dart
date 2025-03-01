import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIconButton extends StatelessWidget {
  final String assetName;
  final double width;
  final double height;
  final Color? color;
  final VoidCallback onPressed;

  SvgIconButton({
    super.key,
    required this.assetName,
    required this.onPressed,
    double? width,
    double? height,
    this.color,
  }) : width = width ?? 16.w,
       height = height ?? 16.h;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(
        assetName,
        width: width,
        height: height,
        color: color,
      ),
      onPressed: onPressed,
    );
  }
}
