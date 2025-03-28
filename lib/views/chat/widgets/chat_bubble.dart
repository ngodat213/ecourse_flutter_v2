import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/app/data/models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ChatBubble extends StatelessWidget {
  final MessageModel message;
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
    switch (message.type) {
      case MessageType.text:
        return Text(
          message.content,
          style: TextStyle(
            color: isMe ? Colors.white : Colors.black,
            fontSize: 14.sp,
          ),
        );

      case MessageType.image:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                message.fileUrl ?? '',
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 150.h,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      value:
                          loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                      color: isMe ? Colors.white : AppColor.primary,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 150.h,
                    width: double.infinity,
                    color: Colors.grey.shade300,
                    alignment: Alignment.center,
                    child: Icon(Icons.error, color: Colors.red),
                  );
                },
              ),
            ),
            if (message.content.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Text(
                  message.content,
                  style: TextStyle(
                    color: isMe ? Colors.white : Colors.black,
                    fontSize: 14.sp,
                  ),
                ),
              ),
          ],
        );

      case MessageType.file:
        return Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: isMe ? Colors.white.withOpacity(0.1) : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              Icon(
                Icons.insert_drive_file,
                color: isMe ? Colors.white : AppColor.primary,
                size: 24.sp,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message.content,
                      style: TextStyle(
                        color: isMe ? Colors.white : Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (message.fileSize != null)
                      Text(
                        _formatFileSize(message.fileSize!),
                        style: TextStyle(
                          color:
                              isMe
                                  ? Colors.white.withOpacity(0.8)
                                  : Colors.grey.shade600,
                          fontSize: 12.sp,
                        ),
                      ),
                  ],
                ),
              ),
              Icon(
                Icons.download,
                color: isMe ? Colors.white : AppColor.primary,
                size: 20.sp,
              ),
            ],
          ),
        );

      case MessageType.voice:
        return Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: isMe ? Colors.white.withOpacity(0.1) : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              Icon(
                Icons.play_circle_fill,
                color: isMe ? Colors.white : AppColor.primary,
                size: 24.sp,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 30.h,
                      decoration: BoxDecoration(
                        color:
                            isMe
                                ? Colors.white.withOpacity(0.2)
                                : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Center(
                        child: Text(
                          'Ghi âm',
                          style: TextStyle(
                            color: isMe ? Colors.white : Colors.black,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      message.content,
                      style: TextStyle(
                        color: isMe ? Colors.white : Colors.black,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
    }
  }

  Widget _buildMessageTime() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Text(
          _formatTime(message.createdAt),
          style: TextStyle(
            color: isMe ? Colors.white.withOpacity(0.7) : Colors.grey,
            fontSize: 10.sp,
          ),
        ),
        if (isMe) ...[
          SizedBox(width: 4.w),
          Icon(
            message.isRead ? Icons.done_all : Icons.done,
            color:
                message.isRead
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
      return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
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
