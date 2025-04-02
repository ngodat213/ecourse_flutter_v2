import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/app/data/models/lesson_content_model.dart';
import 'package:ecourse_flutter_v2/app/data/models/lesson_model.dart';
import 'package:ecourse_flutter_v2/app/data/models/user_progress_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContentTab extends StatelessWidget {
  const ContentTab({
    super.key,
    required this.lessons,
    required this.onContentSelected,
    required this.lessonProgress,
    required this.currentProgressId,
  });

  final List<LessonModel> lessons;
  final Function(LessonContentModel) onContentSelected;
  final List<UserProgressModel> lessonProgress;
  final String currentProgressId;

  @override
  Widget build(BuildContext context) {
    // Mock data cho lessons

    return Expanded(
      child: ListView.builder(
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          // position = 1 là lesson đầu tiên, position = 0 là lesson cuối cùng
          final position =
              index == 0
                  ? 1
                  : index == lessons.length - 1
                  ? 0
                  : -1;
          return Padding(
            padding: EdgeInsets.only(top: index == 0 ? 16.h : 0),
            child: SelectionItem(
              lesson: lessons[index],
              index: index,
              currentContentIndex: position,
              currentContentId: currentProgressId,
              onContentSelected: (content) => onContentSelected(content),
              lessonProgress: lessonProgress,
            ),
          );
        },
      ),
    );
  }
}

class SelectionItem extends StatelessWidget {
  final LessonModel lesson;
  final int currentContentIndex;
  final String currentContentId;
  final Function(LessonContentModel) onContentSelected;
  final int index;
  final List<UserProgressModel> lessonProgress;

  const SelectionItem({
    super.key,
    required this.lesson,
    this.currentContentIndex = -1,
    this.currentContentId = '',
    required this.onContentSelected,
    required this.index,
    required this.lessonProgress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.only(
          topLeft:
              currentContentIndex == 1 ? Radius.circular(8.r) : Radius.zero,
          topRight:
              currentContentIndex == 1 ? Radius.circular(8.r) : Radius.zero,
          bottomLeft:
              currentContentIndex == 0 ? Radius.circular(8.r) : Radius.zero,
          bottomRight:
              currentContentIndex == 0 ? Radius.circular(8.r) : Radius.zero,
        ),
        border: Border(
          top: BorderSide(color: AppColor.accent, width: 1.0),
          left: BorderSide(color: AppColor.accent, width: 1.0),
          right: BorderSide(color: AppColor.accent, width: 1.0),
          bottom:
              currentContentIndex == 0
                  ? BorderSide(color: AppColor.accent, width: 1.0)
                  : BorderSide.none,
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: true,
          backgroundColor: Colors.transparent,
          collapsedBackgroundColor: Colors.transparent,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lesson ${index + 1}: ${lesson.title}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 13.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Progress ${lessonProgress.where((lesson) => lesson.status == 'completed').length} / ${lesson.contents?.length} | ${lesson.duration != null
                    ? lesson.duration! ~/ 60 != 0
                        ? '${lesson.duration! ~/ 60}h ${lesson.duration! % 60} min'
                        : '${lesson.duration!} min'
                    : '0 min'}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                  fontSize: 10.sp,
                ),
              ),
            ],
          ),
          children: List.generate(lesson.contents?.length ?? 0, (index) {
            final content = lesson.contents![index];
            final isCompleted =
                lessonProgress
                    .firstWhere(
                      (element) => element.lessonContent?.sId == content.sId,
                      orElse:
                          () => UserProgressModel(
                            status: 'not_completed',
                            lessonContent: content,
                          ),
                    )
                    .status ==
                'completed';
            return LessonContentItem(
              content: content,
              index: index + 1,
              isSelected: content.sId == currentContentId,
              isCompleted: isCompleted,
              onTap: () => onContentSelected(content),
            );
          }),
        ),
      ),
    );
  }
}

class LessonContentItem extends StatelessWidget {
  final LessonContentModel content;
  final int index;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isCompleted;

  const LessonContentItem({
    super.key,
    required this.content,
    required this.index,
    this.isSelected = false,
    required this.onTap,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primary : Colors.transparent,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$index. ${content.title}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: 12.sp,
                      color:
                          isSelected
                              ? AppColor.textPrimaryDark
                              : AppColor.textPrimary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        _getContentTypeIcon(content.type?.name ?? ''),
                        size: 14.sp,
                        color:
                            isSelected
                                ? AppColor.textPrimaryDark
                                : AppColor.textPrimary,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        content.duration != null
                            ? content.duration! ~/ 60 != 0
                                ? '${content.duration! ~/ 60}h ${content.duration! % 60} min'
                                : '${content.duration!} min'
                            : '0 min',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color:
                              isSelected
                                  ? AppColor.textPrimaryDark
                                  : AppColor.textPrimary,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (isCompleted)
              Container(
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check, color: Colors.white, size: 16.sp),
              ),
          ],
        ),
      ),
    );
  }

  IconData _getContentTypeIcon(String type) {
    switch (type) {
      case 'video':
        return Icons.play_circle_outline;
      case 'document':
        return Icons.article_outlined;
      case 'quiz':
        return Icons.quiz_outlined;
      default:
        return Icons.play_circle_outline;
    }
  }
}
