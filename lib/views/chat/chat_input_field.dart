import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_image.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';
import 'dart:async';

class ChatInputField extends StatefulWidget {
  final Function(String) onSendMessage;
  final Function()? onAttachmentPressed;
  final Function(String)? onTextChanged;
  final Function(bool)? onTypingStatusChanged;
  final TextEditingController? controller;
  final String hintText;

  const ChatInputField({
    super.key,
    required this.onSendMessage,
    this.onAttachmentPressed,
    this.onTextChanged,
    this.onTypingStatusChanged,
    this.controller,
    this.hintText = 'Viết tin nhắn...',
  });

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  late final TextEditingController _textController;
  bool _showEmojiPicker = false;
  bool _isComposing = false;
  bool _isTyping = false;
  Timer? _typingTimer;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _textController = widget.controller ?? TextEditingController();
    _textController.addListener(_handleTextChange);
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _textController.removeListener(_handleTextChange);
    if (widget.controller == null) {
      _textController.dispose();
    }
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    _typingTimer?.cancel();
    super.dispose();
  }

  void _handleTextChange() {
    final isNotEmpty = _textController.text.isNotEmpty;
    setState(() {
      _isComposing = isNotEmpty;
    });

    // Xử lý typing status
    if (isNotEmpty && !_isTyping) {
      _isTyping = true;
      widget.onTypingStatusChanged?.call(true);
    }

    _typingTimer?.cancel();
    _typingTimer = Timer(const Duration(seconds: 2), () {
      if (_isTyping) {
        _isTyping = false;
        widget.onTypingStatusChanged?.call(false);
      }
    });

    if (widget.onTextChanged != null) {
      widget.onTextChanged!(_textController.text);
    }
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus && _showEmojiPicker) {
      setState(() {
        _showEmojiPicker = false;
      });
    }
  }

  void _handleSendPressed() {
    final message = _textController.text.trim();
    if (message.isNotEmpty) {
      widget.onSendMessage(message);
      _textController.clear();
      setState(() {
        _isComposing = false;
      });
      // Reset typing status
      if (_isTyping) {
        _isTyping = false;
        widget.onTypingStatusChanged?.call(false);
      }
    }
  }

  void _toggleEmojiPicker() {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
      Future.delayed(Duration(milliseconds: 100), () {
        setState(() {
          _showEmojiPicker = !_showEmojiPicker;
        });
      });
    } else {
      setState(() {
        _showEmojiPicker = !_showEmojiPicker;
      });
    }
  }

  void _onEmojiSelected(Category? category, Emoji emoji) {
    _textController.text = _textController.text + emoji.emoji;
    _textController.selection = TextSelection.fromPosition(
      TextPosition(offset: _textController.text.length),
    );
    setState(() {
      _isComposing = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: SafeArea(
            child: Row(
              children: [
                IconButton(
                  icon: SvgPicture.asset(
                    AppImage.svgBell,
                    width: 20.w,
                    height: 20.w,
                    color: AppColor.textSecondary,
                  ),
                  onPressed: widget.onAttachmentPressed,
                ),

                // Textfield
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.cardColor,
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Row(
                      children: [
                        // Nút emoji
                        IconButton(
                          icon: Icon(
                            Icons.emoji_emotions_outlined,
                            color: AppColor.textSecondary,
                            size: 24.sp,
                          ),
                          onPressed: _toggleEmojiPicker,
                        ),

                        // Trường nhập tin nhắn
                        Expanded(
                          child: TextField(
                            controller: _textController,
                            focusNode: _focusNode,
                            minLines: 1,
                            maxLines: 5,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                              hintText: widget.hintText,
                              hintStyle: TextStyle(
                                color: AppColor.textSecondary.withOpacity(0.7),
                                fontSize: 14.sp,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 10.h,
                                horizontal: 0,
                              ),
                            ),
                          ),
                        ),

                        // Nút gửi
                        AnimatedOpacity(
                          opacity: _isComposing ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 200),
                          child: IconButton(
                            icon: Icon(
                              Icons.send,
                              color:
                                  _isComposing
                                      ? AppColor.primary
                                      : AppColor.textSecondary,
                              size: 24.sp,
                            ),
                            onPressed: _isComposing ? _handleSendPressed : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Emoji Picker
        Offstage(
          offstage: !_showEmojiPicker,
          child: SizedBox(
            height: 250.h,
            child: EmojiPicker(
              onEmojiSelected: _onEmojiSelected,
              config: Config(
                height: 250.h,
                checkPlatformCompatibility: true,
                emojiViewConfig: EmojiViewConfig(
                  emojiSizeMax: 32.0 * (Platform.isIOS ? 1.30 : 1.0),
                  verticalSpacing: 0,
                  horizontalSpacing: 0,
                  gridPadding: EdgeInsets.zero,
                ),
                categoryViewConfig: CategoryViewConfig(
                  initCategory: Category.RECENT,
                  indicatorColor: AppColor.primary,
                  iconColor: Colors.grey,
                  iconColorSelected: AppColor.primary,
                  backspaceColor: AppColor.primary,
                  backgroundColor: Colors.white,
                  tabIndicatorAnimDuration: kTabScrollDuration,
                  categoryIcons: const CategoryIcons(),
                ),
                bottomActionBarConfig: BottomActionBarConfig(enabled: true),
                skinToneConfig: SkinToneConfig(
                  enabled: true,
                  dialogBackgroundColor: Colors.white,
                  indicatorColor: Colors.grey,
                ),
                searchViewConfig: SearchViewConfig(
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
