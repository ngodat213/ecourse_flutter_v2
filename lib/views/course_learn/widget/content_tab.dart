import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/models/lesson_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContentTab extends StatelessWidget {
  const ContentTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data cho lessons
    final lessons = [
      LessonModel(
        id: '1',
        number: '1',
        title: 'Introduction',
        duration: '10min',
        contents: [
          LessonContentModel(
            id: '1-1',
            title: 'Course Introduction',
            duration: '5min',
            type: LessonContentType.video,
            isCompleted: true,
          ),
          LessonContentModel(
            id: '1-2',
            title: 'Premiere Pro Introduction',
            duration: '4min',
            type: LessonContentType.video,
            isCompleted: false,
          ),
          LessonContentModel(
            id: '1-3',
            title: 'Convenient Resources',
            duration: '1min',
            type: LessonContentType.document,
            isCompleted: false,
          ),
        ],
      ),
      LessonModel(
        id: '2',
        number: '2',
        title: 'Getting Started',
        duration: '15min',
        contents: [
          LessonContentModel(
            id: '2-1',
            title: 'Setting Up Your Workspace',
            duration: '5min',
            type: LessonContentType.video,
            isCompleted: false,
          ),
          LessonContentModel(
            id: '2-2',
            title: 'Basic Editing Techniques',
            duration: '7min',
            type: LessonContentType.video,
            isCompleted: false,
          ),
          LessonContentModel(
            id: '2-3',
            title: 'First Quiz',
            duration: '3min',
            type: LessonContentType.quiz,
            isCompleted: false,
          ),
        ],
      ),
    ];

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
              currentContentIndex: position,
              onContentSelected: (lessonId, contentIndex) {
                print('Selected lesson: $lessonId, content: $contentIndex');
              },
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
  final Function(String, int) onContentSelected;

  const SelectionItem({
    super.key,
    required this.lesson,
    this.currentContentIndex = -1,
    required this.onContentSelected,
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
                'Lesson ${lesson.number}: ${lesson.title}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 13.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Progress ${lesson.number} / ${lesson.contents.length} | ${lesson.duration}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                  fontSize: 10.sp,
                ),
              ),
            ],
          ),
          children: List.generate(
            lesson.contents.length,
            (index) => LessonContentItem(
              content: lesson.contents[index],
              index: index + 1,
              isSelected: index == currentContentIndex,
              onTap: () => onContentSelected(lesson.id, index),
            ),
          ),
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
                        _getContentTypeIcon(content.type),
                        size: 14.sp,
                        color:
                            isSelected
                                ? AppColor.textPrimaryDark
                                : AppColor.textPrimary,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        content.duration,
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
            if (content.isCompleted)
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

  IconData _getContentTypeIcon(LessonContentType type) {
    switch (type) {
      case LessonContentType.video:
        return Icons.play_circle_outline;
      case LessonContentType.document:
        return Icons.article_outlined;
      case LessonContentType.quiz:
        return Icons.quiz_outlined;
    }
  }
}
