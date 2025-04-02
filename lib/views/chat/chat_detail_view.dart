import 'package:ecourse_flutter_v2/app/data/models/conversation_model.dart';
import 'package:ecourse_flutter_v2/core/base/base_view.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_image.dart';
import 'package:ecourse_flutter_v2/view_models/chat_vm.dart';
import 'package:ecourse_flutter_v2/views/chat/chat_input_field.dart';
import 'package:ecourse_flutter_v2/views/chat/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:async';

class ChatDetailView extends BaseView<ChatVM> {
  final ConversationModel conversation;

  const ChatDetailView({super.key, required this.conversation});

  @override
  ChatVM createViewModel(
    BuildContext context,
    Map<String, dynamic>? arguments,
  ) {
    return ChatVM(context)..loadChatDetail(conversation.id);
  }

  @override
  Widget buildView(BuildContext context, ChatVM vm) {
    return ChatDetailScreen(viewModel: vm, conversation: conversation);
  }
}

class ChatDetailScreen extends StatefulWidget {
  final ChatVM viewModel;
  final ConversationModel conversation;

  const ChatDetailScreen({
    super.key,
    required this.viewModel,
    required this.conversation,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _messageController = TextEditingController();
  bool _isTyping = false;
  Timer? _typingTimer;

  @override
  void initState() {
    super.initState();
    _scrollToBottom();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _messageController.dispose();
    _typingTimer?.cancel();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _handleTypingStatusChanged(bool isTyping) {
    if (isTyping) {
      widget.viewModel.sendTypingStatus();
    } else {
      widget.viewModel.stopTypingStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Đảm bảo cuộn xuống dưới khi có tin nhắn mới
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(1.sh * 0.13),
        child: Padding(
          padding: EdgeInsets.only(top: 48.h),
          child: AppBar(
            backgroundColor: AppColor.background,
            title: Text(
              widget.conversation.name,
              style: TextStyle(
                color: AppColor.textPrimary,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              IconButton(
                icon: SvgPicture.asset(
                  AppImage.svgCart,
                  width: 20.w,
                  height: 20.w,
                  color: AppColor.primary,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: SvgPicture.asset(
                  AppImage.svgGoogle,
                  width: 20.w,
                  height: 20.w,
                  color: AppColor.primary,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // Danh sách tin nhắn
          Expanded(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: _buildMessageList(),
            ),
          ),

          // Typing indicator
          _buildTypingIndicator(),

          // Input field
          ChatInputField(
            controller: _messageController,
            onSendMessage: _handleSendMessage,
            onAttachmentPressed: _handleAttachmentPressed,
            onTypingStatusChanged: _handleTypingStatusChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    final typingUsers = widget.viewModel.typingUsers;
    if (typingUsers.isEmpty) return const SizedBox.shrink();

    // Tìm người đang gõ không phải người dùng hiện tại
    final typingUsersIds =
        typingUsers.keys
            .where((id) => id != widget.viewModel.currentUserId?.user?.sId)
            .toList();

    if (typingUsersIds.isEmpty) return const SizedBox.shrink();

    // Hiển thị "đang gõ..." cho người đầu tiên trong danh sách
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      alignment: Alignment.centerLeft,
      child: Text(
        '${widget.conversation.name} đang gõ...',
        style: TextStyle(
          color: AppColor.textSecondary,
          fontSize: 12.sp,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    // Trong trường hợp thực tế, sẽ lấy danh sách tin nhắn từ API
    final messages = widget.viewModel.messages;

    if (messages.isEmpty) {
      return Center(
        child: Text(
          'Hãy bắt đầu cuộc trò chuyện',
          style: TextStyle(color: AppColor.textSecondary, fontSize: 14.sp),
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        final showTime =
            index == 0 ||
            messages[index].createdAt!.day !=
                messages[index - 1].createdAt!.day;

        return Column(
          children: [
            if (showTime)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Text(
                  _formatMessageDate(message.createdAt!),
                  style: TextStyle(
                    color: AppColor.textSecondary,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ChatBubble(
              message: message,
              isMe:
                  message.sender!.sId ==
                  widget.viewModel.currentUserId?.user?.sId,
            ),
          ],
        );
      },
    );
  }

  String _formatMessageDate(DateTime date) {
    // Hàm định dạng ngày tháng
    return '${date.day}/${date.month}/${date.year}';
  }

  void _handleSendMessage(String text) {
    if (text.trim().isEmpty) return;

    widget.viewModel.sendMessage(text);
    _messageController.clear();
    _stopTyping();

    // Cuộn xuống dưới cùng sau khi gửi tin nhắn
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  void _handleAttachmentPressed() {
    // Hiển thị bottom sheet để chọn ảnh, file...
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.photo, color: AppColor.primary),
                title: Text('Gửi ảnh'),
                onTap: () {
                  // Implement image picking here
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.attach_file, color: AppColor.primary),
                title: Text('Gửi file'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.mic, color: AppColor.primary),
                title: Text('Gửi ghi âm'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _stopTyping() {
    if (_isTyping) {
      setState(() => _isTyping = false);
      widget.viewModel.stopTypingStatus();
    }
  }
}
