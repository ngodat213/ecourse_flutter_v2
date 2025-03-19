import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/routes/app_routes.dart';
import 'package:ecourse_flutter_v2/core/widgets/buttons/elevated_button.dart';
import 'package:ecourse_flutter_v2/models/lesson_content_model.dart';
import 'package:ecourse_flutter_v2/models/quiz_question_model.dart';
import 'package:ecourse_flutter_v2/repositories/quiz_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

mixin QuizPlayerMixin<T extends StatefulWidget> on State<T> {
  final QuizRepository _quizRepository = QuizRepository();

  LessonContentModel? content;
  List<QuizQuestionModel> questions = [];
  bool isLoading = false;
  Function? onQuizFinished;

  Future<void> initQuiz(
    LessonContentModel content,
    Function? onQuizFinished,
  ) async {
    this.content = content;
    onQuizFinished = onQuizFinished;
    setState(() {});
  }

  Future<void> startQuiz() async {
    if (content?.quiz?.sId == null) return;

    try {
      setState(() => isLoading = true);

      final response = await _quizRepository.startQuiz(content!.quiz!.sId!);
      if (response.allGood) {
        questions =
            (response.body['questions'] as List)
                .map((q) => QuizQuestionModel.fromJson(q))
                .toList();
      }
      final result = AppRoutes.push(
        context,
        AppRoutes.examTaking,
        arguments: {
          'content': content?.toJson(),
          'questions': questions.map((e) => e.toJson()).toList(),
        },
      );

      if (result == true) {
        onQuizFinished?.call();
      }

      setState(() => isLoading = false);
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  Widget buildQuizPlayer(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator(color: AppColor.primary));
    }

    return _buildQuizStart(context);
  }

  Widget _buildQuizStart(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColor.cardColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.quiz, size: 16.w, color: AppColor.primary),
            SizedBox(height: 16.h),
            Text(
              'Bài kiểm tra đã sẵn sàng'.toUpperCase(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Thời gian: ${content?.quiz?.duration} phút\n'
              'Số câu hỏi: ${content?.quiz?.totalQuestions}\n'
              'Điểm đạt: ${content?.quiz?.passingScore}%',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontSize: 10.sp),
            ),
            Spacer(),
            CustomElevatedButton(
              context: context,
              text: 'Bắt đầu làm bài',
              onPressed: startQuiz,
              textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 10.sp,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
