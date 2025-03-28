import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/app/data/models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecourse_flutter_v2/enums/message_type.enum.dart';
import 'package:intl/intl.dart';

class ChatBubble extends StatelessWidget {
  final ChatModel message;
  final bool isMe;

  const ChatBubble({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Card(
          elevation: 0,
          color: isMe ? AppColor.primary : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
            side:
                isMe
                    ? BorderSide.none
                    : BorderSide(color: Colors.grey.shade200),
          ),
          margin: EdgeInsets.symmetric(vertical: 4.h),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMessageContent(),
                SizedBox(height: 4.h),
                _buildMessageTime(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageContent() {
    switch (message.contentType) {
      case MessageType.text:
        return Text(
          message.content!,
          style: TextStyle(
            color: isMe ? Colors.white : Colors.black,
            fontSize: 14.sp,
          ),
        );
      default:
        return Text(
          'Unsupported message type',
          style: TextStyle(color: Colors.grey),
        );
    }
  }

  Widget _buildMessageTime() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Text(
          _formatTime(message.createdAt!),
          style: TextStyle(
            color: isMe ? Colors.white.withOpacity(0.7) : Colors.grey,
            fontSize: 10.sp,
          ),
        ),
        if (isMe) ...[
          SizedBox(width: 4.w),
          Icon(
            message.readBy!.isNotEmpty ? Icons.done_all : Icons.done,
            color:
                message.readBy!.isNotEmpty
                    ? Colors.white.withOpacity(0.7)
                    : Colors.white.withOpacity(0.5),
            size: 12.sp,
          ),
        ],
      ],
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (messageDate == today) {
      return DateFormat('HH:mm').format(dateTime);
    } else if (messageDate == yesterday) {
      return 'Hôm qua, ${DateFormat('HH:mm').format(dateTime)}';
    } else {
      return DateFormat('HH:mm').format(dateTime);
    }
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      double kb = bytes / 1024;
      return '${kb.toStringAsFixed(1)} KB';
    } else if (bytes < 1024 * 1024 * 1024) {
      double mb = bytes / (1024 * 1024);
      return '${mb.toStringAsFixed(1)} MB';
    } else {
      double gb = bytes / (1024 * 1024 * 1024);
      return '${gb.toStringAsFixed(1)} GB';
    }
  }
}
