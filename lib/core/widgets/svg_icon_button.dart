import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIconButton extends StatelessWidget {
  final String assetName;
  final double width;
  final double height;
  final Color? color;
  final VoidCallback onPressed;

  const SvgIconButton({
    super.key,
    required this.assetName,
    required this.onPressed,
    this.width = 24,
    this.height = 24,
    this.color,
  });

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
