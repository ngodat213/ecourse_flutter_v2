import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmartImage extends StatelessWidget {
  const SmartImage({
    super.key,
    required this.source,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.color,
    this.borderRadius,
    this.errorWidget,
    this.loadingWidget,
    this.isCircle = false,
    this.border,
  });

  final String source;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;
  final BorderRadius? borderRadius;
  final Widget Function(BuildContext, Object)? errorWidget;
  final Widget Function(BuildContext)? loadingWidget;
  final bool isCircle;
  final BoxBorder? border;

  bool get _isNetworkImage =>
      source.startsWith('http://') || source.startsWith('https://');

  bool get _isSvgImage => source.toLowerCase().endsWith('.svg');

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (_isNetworkImage) {
      imageWidget = CachedNetworkImage(
        imageUrl: source,
        width: width,
        height: height,
        fit: fit,
        color: color,
        placeholder: (context, url) {
          return loadingWidget?.call(context) ?? _defaultLoadingWidget();
        },
        errorWidget: (context, url, error) {
          return errorWidget?.call(context, error) ?? _defaultErrorWidget();
        },
      );
    } else if (_isSvgImage) {
      imageWidget = SvgPicture.asset(
        source,
        width: width,
        height: height,
        fit: fit,
        colorFilter:
            color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      );
    } else {
      imageWidget = Image.asset(
        source,
        width: width,
        height: height,
        fit: fit,
        color: color,
        errorBuilder: (context, error, stackTrace) {
          return errorWidget?.call(context, error) ?? _defaultErrorWidget();
        },
      );
    }

    if (isCircle || border != null) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          border: border,
          borderRadius: !isCircle ? borderRadius : null,
        ),
        child: ClipRRect(
          borderRadius:
              !isCircle
                  ? (borderRadius ?? BorderRadius.zero)
                  : BorderRadius.circular(width ?? 0 / 2),
          child: imageWidget,
        ),
      );
    }

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: imageWidget);
    }

    return imageWidget;
  }

  Widget _defaultLoadingWidget() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColor.border,
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: !isCircle ? borderRadius : null,
        border: border,
      ),
      child: Center(
        child: SizedBox(
          width: 20.w,
          height: 20.w,
          child: CircularProgressIndicator(
            strokeWidth: 2.w,
            valueColor: AlwaysStoppedAnimation<Color>(AppColor.primary),
          ),
        ),
      ),
    );
  }

  Widget _defaultErrorWidget() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColor.border,
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: !isCircle ? borderRadius : null,
        border: border,
      ),
      child: Icon(Icons.error_outline, color: AppColor.error, size: 24.w),
    );
  }
}
