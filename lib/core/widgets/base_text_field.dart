import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/widgets/svg_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final bool obscureText;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final VoidCallback? onTap;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;
  final TextInputAction? textInputAction;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final bool showCursor;
  final bool autofocus;
  final bool enabled;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final BorderRadius? borderRadius;

  const BaseTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.obscureText = false,
    this.prefixIcon,
    this.validator,
    this.keyboardType,
    this.onTap,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.textInputAction,
    this.onSubmitted,
    this.onChanged,
    this.focusNode,
    this.showCursor = true,
    this.autofocus = false,
    this.enabled = true,
    this.contentPadding,
    this.fillColor,
    this.style,
    this.labelStyle,
    this.hintStyle,
    this.borderRadius,
  });

  @override
  State<BaseTextField> createState() => _BaseTextFieldState();
}

class _BaseTextFieldState extends State<BaseTextField> {
  bool _obscureText = false;
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        TextFormField(
          controller: widget.controller,
          obscureText: _obscureText,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          onTap: widget.onTap,
          readOnly: widget.readOnly,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onSubmitted,
          onChanged: widget.onChanged,
          focusNode: _focusNode,
          showCursor: widget.showCursor,
          autofocus: widget.autofocus,
          enabled: widget.enabled,
          style: widget.style ?? theme.textTheme.bodyLarge,
          decoration: InputDecoration(
            // labelText: widget.labelText,
            errorStyle: const TextStyle(height: 0, fontSize: 0),
            errorText: null,
            hintText: widget.hintText,
            prefixIcon:
                widget.prefixIcon != null
                    ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: widget.prefixIcon,
                    )
                    : null,
            suffixIcon:
                widget.obscureText
                    ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: SvgIconButton(
                        width: 16.w,
                        height: 16.h,
                        assetName:
                            _obscureText
                                ? 'assets/svgs/eye_off.svg'
                                : 'assets/svgs/eye.svg',
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    )
                    : null,
            contentPadding:
                widget.contentPadding ??
                EdgeInsets.symmetric(horizontal: 32.w, vertical: 8.h),
            filled: true,
            fillColor: widget.fillColor ?? AppColor.cardColor,
            labelStyle:
                widget.labelStyle ??
                theme.textTheme.bodyLarge?.copyWith(
                  color: _isFocused ? theme.primaryColor : Colors.grey,
                ),
            hintStyle:
                widget.hintStyle ??
                theme.textTheme.bodyLarge?.copyWith(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: widget.borderRadius ?? BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: widget.borderRadius ?? BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColor.accent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: widget.borderRadius ?? BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColor.accent),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: widget.borderRadius ?? BorderRadius.circular(12.r),
              borderSide: BorderSide(color: theme.colorScheme.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: widget.borderRadius ?? BorderRadius.circular(12.r),
              borderSide: BorderSide(color: theme.colorScheme.error),
            ),
          ),
        ),
      ],
    );
  }
}
