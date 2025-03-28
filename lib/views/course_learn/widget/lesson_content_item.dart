import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/app/data/models/lesson_content_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecourse_flutter_v2/enums/lesson_content_type.enum.dart';

class LessonContentItem extends StatelessWidget {
  final LessonContentModel content;
  final int index;
  final bool isSelected;
  final VoidCallback onTap;

  const LessonContentItem({
    super.key,
    required this.content,
    required this.index,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primary.withOpacity(0.1) : null,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                color: isSelected ? AppColor.primary : AppColor.accent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColor.textSecondary,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    content.title ?? '',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: isSelected ? AppColor.primary : null,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        _getContentTypeIcon(),
                        size: 16.w,
                        color: AppColor.textSecondary,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        content.duration != null
                            ? content.duration! ~/ 60 != 0
                                ? '${content.duration! ~/ 60}h ${content.duration! % 60} min'
                                : '${content.duration!} min'
                            : '0 min',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColor.textSecondary,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (content.status == 'completed')
              Icon(Icons.check_circle, color: AppColor.success, size: 20.w),
          ],
        ),
      ),
    );
  }

  IconData _getContentTypeIcon() {
    switch (content.type) {
      case LessonContentType.video:
        return Icons.play_circle_outline;
      case LessonContentType.document:
        return Icons.article_outlined;
      case LessonContentType.quiz:
        return Icons.quiz_outlined;
      default:
        return Icons.article_outlined;
    }
  }
}
