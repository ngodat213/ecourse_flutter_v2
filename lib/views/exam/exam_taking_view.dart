import 'package:easy_localization/easy_localization.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_constants.dart';
import 'package:ecourse_flutter_v2/core/config/app_image.dart';
import 'package:ecourse_flutter_v2/core/widgets/buttons/elevated_button.dart';
import 'package:ecourse_flutter_v2/core/widgets/smart_image.dart';
import 'package:ecourse_flutter_v2/models/lesson_content_model.dart';
import 'package:ecourse_flutter_v2/models/quiz_question_model.dart';
import 'package:ecourse_flutter_v2/view_models/exam_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import '../../core/base/base_view.dart';

class ExamTakingView extends BaseView<ExamVM> {
  const ExamTakingView({super.key});

  @override
  ExamVM createViewModel(
    BuildContext context,
    Map<String, dynamic>? arguments,
  ) {
    final LessonContentModel content = LessonContentModel.fromJson(
      arguments!['content'],
    );
    final List<QuizQuestionModel> questions =
        (arguments['questions'] as List)
            .map((q) => QuizQuestionModel.fromJson(q))
            .toList();
    return ExamVM(context, content: content, questions: questions);
  }

  @override
  Widget? buildBottomNavigationBar(BuildContext context, ExamVM vm) {
    return vm.status != ExamStatus.taking
        ? null
        : Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 33.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (vm.error != null)
                Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Text(
                    vm.error!,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppColor.error),
                  ),
                ),
              CustomElevatedButton(
                width: 1.sw,
                context: context,
                text: 'Finish (${vm.answeredCount}/${vm.questions.length})',
                onPressed: () {
                  StylishDialog(
                    context: context,
                    alertType: StylishDialogType.WARNING,
                    title: Text('Xác nhận nộp bài'),
                    content: Text('Bạn có chắc chắn muốn nộp bài?'),
                    cancelButton: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Hủy'),
                    ),
                    confirmButton: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        vm.submitExam();
                      },
                      child: const Text('Nộp bài'),
                    ),
                  ).show();
                },
              ),
            ],
          ),
        );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, ExamVM vm) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 0.3.sw,
      backgroundColor: AppColor.background,
      title: Align(
        alignment: Alignment.topCenter,
        child: Container(
          height: 0.35.sw,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed:
                        () => {
                          if (vm.status == ExamStatus.submit)
                            {Navigator.pop(context, true)}
                          else
                            {Navigator.pop(context)},
                        },
                    padding: EdgeInsets.all(6.w),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColor.primary.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                    ),
                    icon: SvgPicture.asset(
                      AppImage.svgArrowLeft,
                      width: 12.w,
                      height: 16.h,
                      color: AppColor.primary,
                    ),
                  ),
                  Text(
                    'Answer Sheet',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColor.primary,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    padding: EdgeInsets.all(8.w),
                    icon: SvgPicture.asset(
                      AppImage.svgBell,
                      width: 16.w,
                      height: 16.h,
                      color: AppColor.primary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              _timeCount(vm, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _timeCount(ExamVM vm, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          vm.profileUser?.user?.fullName ?? '',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.r),
                  bottomLeft: Radius.circular(8.r),
                ),
              ),
              child: Text(
                vm.status == ExamStatus.submit ? 'score'.tr() : 'time'.tr(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColor.background,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColor.cardColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8.r),
                  bottomRight: Radius.circular(8.r),
                ),
              ),
              child: Text(
                vm.status == ExamStatus.submit
                    ? vm.score.toString()
                    : vm.formattedTime,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColor.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget buildView(BuildContext context, ExamVM vm) {
    return SafeArea(
      child: Stack(
        children: [
          Positioned.fill(
            child: ListView.builder(
              itemCount: vm.questions.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                if (index == vm.questions.length - 1) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 100.h),
                    child: QuestionCard(
                      index: index,
                      question: vm.questions[index],
                      vm: vm,
                    ),
                  );
                }
                return QuestionCard(
                  index: index,
                  question: vm.questions[index],
                  vm: vm,
                );
              },
            ),
          ),
          if (vm.status == ExamStatus.submit) _draggableExamResult(vm),
        ],
      ),
    );
  }

  DraggableScrollableSheet _draggableExamResult(ExamVM vm) {
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      minChildSize: 0.1,
      maxChildSize: 0.8,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 20),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 0.25.sw,
                      height: 0.25.sw,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.background,
                      ),
                      child: SmartImage(
                        width: 0.25.sw,
                        height: 0.25.sw,
                        source:
                            vm.profileUser?.user?.profilePicture ??
                            AppConstants.defaultAvatar,
                        isCircle: true,
                      ),
                    ),
                    // Positioned(
                    //   top: 0,
                    //   child: SmartImage(
                    //     width: 0.1.sw,
                    //     height: 0.1.sw,
                    //     source: AppImage.imgCrown,
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  vm.profileUser?.user?.fullName ?? "",
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.success.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    "100% completed",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColor.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  vm.score.toString(),
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 40.sp,
                  ),
                ),
                Text(
                  "Total Score",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColor.textSecondary,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          decoration: BoxDecoration(
                            color: AppColor.warning.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "60 min",
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "Total Time",
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: AppColor.textSecondary),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          decoration: BoxDecoration(
                            color: AppColor.success.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${vm.correctAnswers}/${vm.questions.length}",
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "Question",
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: AppColor.textSecondary),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 0.1.sh),
              ],
            ),
          ),
        );
      },
    );
  }
}

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    super.key,
    required this.index,
    required this.question,
    required this.vm,
  });

  final int index;
  final QuizQuestionModel question;
  final ExamVM vm;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
      margin: EdgeInsets.symmetric(vertical: 18.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: AppColor.background,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.primary.withOpacity(0.1),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  color: AppColor.primary.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Center(
                  child: Text(
                    '0${index + 1}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 1.sw - 32.w - 64.w,
                      child: Text(
                        question.question ?? '',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 18.h),
                    Wrap(
                      spacing: 16.w,
                      runSpacing: 8.h,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AnswerItem(
                              text: 'A. ',
                              answer: question.answers?[0].text ?? '',
                            ),
                            SizedBox(height: 8.h),
                            AnswerItem(
                              text: 'C. ',
                              answer: question.answers?[2].text ?? '',
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AnswerItem(
                              text: 'B. ',
                              answer: question.answers?[1].text ?? '',
                            ),
                            SizedBox(height: 8.h),
                            AnswerItem(
                              text: 'D. ',
                              answer: question.answers?[3].text ?? '',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Container(height: 1.h, width: 1.sw, color: Colors.grey),
          SizedBox(height: 16.h),
          Row(
            children: [
              Choosee(
                text: 'A',
                isSelected: vm.isAnswerSelected(question.sId ?? '', 0),
                onTap: () => vm.selectAnswer(question.sId ?? '', 0),
              ),
              Choosee(
                text: 'B',
                isSelected: vm.isAnswerSelected(question.sId ?? '', 1),
                onTap: () => vm.selectAnswer(question.sId ?? '', 1),
              ),
              Choosee(
                text: 'C',
                isSelected: vm.isAnswerSelected(question.sId ?? '', 2),
                onTap: () => vm.selectAnswer(question.sId ?? '', 2),
              ),
              Choosee(
                text: 'D',
                isSelected: vm.isAnswerSelected(question.sId ?? '', 3),
                onTap: () => vm.selectAnswer(question.sId ?? '', 3),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Choosee extends StatelessWidget {
  const Choosee({
    required this.text,
    this.isSelected = false,
    this.isCorrect = false,
    this.isWrong = false,
    required this.onTap,
    super.key,
  });

  final String text;
  final bool isSelected;
  final bool isCorrect;
  final bool isWrong;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor =
        isSelected
            ? AppColor.primary
            : isCorrect
            ? AppColor.success
            : isWrong
            ? AppColor.error
            : AppColor.background;
    final Color textColor =
        isSelected || isCorrect || isWrong
            ? AppColor.background
            : AppColor.textPrimary;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 32.w,
        height: 32.w,
        margin: EdgeInsets.only(right: 8.w),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(100.r),
          border: Border.all(
            color: isSelected ? AppColor.primary : AppColor.accent,
            width: isSelected ? 2 : 1,
          ),
          boxShadow:
              isSelected
                  ? [
                    BoxShadow(
                      color: AppColor.primary.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                  : null,
        ),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class AnswerItem extends StatelessWidget {
  const AnswerItem({required this.text, required this.answer, super.key});

  final String text;
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: text,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          TextSpan(
            text: answer,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColor.textSecondary,
              fontWeight: FontWeight.w500,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}
