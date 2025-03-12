import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_image.dart';
import 'package:ecourse_flutter_v2/core/widgets/buttons/elevated_button.dart';
import 'package:ecourse_flutter_v2/view_models/exam_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/base/base_view.dart';

class ExamTakingView extends BaseView<ExamVM> {
  const ExamTakingView({super.key});

  @override
  ExamVM createViewModel(
    BuildContext context,
    Map<String, dynamic>? arguments,
  ) {
    return ExamVM(context);
  }

  @override
  Widget? buildBottomNavigationBar(BuildContext context, ExamVM vm) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 33.h),
      child: CustomElevatedButton(
        context: context,
        text: 'Finish',
        onPressed: () {},
      ),
    );
  }

  @override
  Widget buildView(BuildContext context, ExamVM vm) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 0.35.sw),
              child: ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return QuestionCard(index: index);
                },
              ),
            ),
            Align(
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
                          onPressed: () => Navigator.pop(context),
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
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Anatomy',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 8.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.primary,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8.r),
                                  bottomLeft: Radius.circular(8.r),
                                ),
                              ),
                              child: Text(
                                'Time',
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.copyWith(
                                  color: AppColor.background,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 8.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.cardColor,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8.r),
                                  bottomRight: Radius.circular(8.r),
                                ),
                              ),
                              child: Text(
                                '50:50',
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.copyWith(
                                  color: AppColor.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionCard extends StatelessWidget {
  const QuestionCard({super.key, required this.index});

  final int index;

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
                    Text(
                      'What is the capital of France?',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 18.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 0.37.sw,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AnswerItem(text: 'A. ', answer: 'Haha'),
                              SizedBox(height: 8.h),
                              AnswerItem(text: 'C. ', answer: 'Paris'),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 0.37.sw,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AnswerItem(text: 'A. ', answer: 'Hihi'),
                              SizedBox(height: 8.h),
                              AnswerItem(text: 'C. ', answer: 'Mama'),
                            ],
                          ),
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
                isSelected: false,
                isCorrect: false,
                isWrong: false,
                onTap: () {},
              ),
              Choosee(
                text: 'B',
                isSelected: false,
                isCorrect: true,
                isWrong: false,
                onTap: () {},
              ),
              Choosee(
                text: 'C',
                isSelected: false,
                isCorrect: false,
                isWrong: true,
                onTap: () {},
              ),
              Choosee(
                text: 'D',
                isSelected: true,
                isCorrect: false,
                isWrong: true,
                onTap: () {},
              ),
              Expanded(child: SizedBox()),
              Container(
                height: 32.w,
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                decoration: BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Text(
                    '0.5 Mark',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColor.background,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
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
    required this.isSelected,
    required this.isCorrect,
    required this.isWrong,
    required this.onTap,
    super.key,
  });

  final String text;
  final bool isSelected;
  final bool isCorrect;
  final bool isWrong;
  final Function() onTap;

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
        isSelected
            ? AppColor.background
            : isCorrect
            ? AppColor.background
            : isWrong
            ? AppColor.background
            : AppColor.textPrimary;

    return Container(
      width: 32.w,
      height: 32.w,
      margin: EdgeInsets.only(right: 8.w),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(100.r),
        border: Border.all(color: AppColor.accent),
      ),
      child: Center(
        child: Text(
          'A',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: textColor,
            fontWeight: FontWeight.w600,
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
            ),
          ),
        ],
      ),
    );
  }
}
