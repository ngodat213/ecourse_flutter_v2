import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/routes/app_routes.dart';
import 'package:ecourse_flutter_v2/core/widgets/buttons/elevated_button.dart';
import 'package:ecourse_flutter_v2/models/quiz_model.dart';
import 'package:ecourse_flutter_v2/models/quiz_question_model.dart';
import 'package:ecourse_flutter_v2/repositories/quiz_repository.dart';
import 'package:ecourse_flutter_v2/views/exam/exam_taking_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecourse_flutter_v2/core/widgets/smart_image.dart';

mixin QuizPlayerMixin<T extends StatefulWidget> on State<T> {
  final QuizRepository _quizRepository = QuizRepository();

  QuizModel? quiz;
  List<QuizQuestionModel> questions = [];
  Map<String, String> selectedAnswers = {};
  bool isQuizStarted = false;
  bool isQuizSubmitted = false;
  Map<String, dynamic>? quizResult;
  int currentQuestionIndex = 0;
  bool isLoading = false;

  Future<void> initQuiz(QuizModel quiz) async {
    this.quiz = quiz;
    isQuizStarted = false;
    isQuizSubmitted = false;
    selectedAnswers.clear();
    questions.clear();
    quizResult = null;
    currentQuestionIndex = 0;
    setState(() {});
  }

  Future<void> startQuiz() async {
    if (quiz?.sId == null) return;

    try {
      setState(() => isLoading = true);

      final response = await _quizRepository.startQuiz(quiz!.sId!);
      if (response.allGood) {
        questions =
            (response.body['questions'] as List)
                .map((q) => QuizQuestionModel.fromJson(q))
                .toList();
      }
      AppRoutes.push(
        context,
        AppRoutes.examTaking,
        arguments: {
          'quiz': quiz?.toJson(),
          'questions': questions.map((e) => e.toJson()).toList(),
        },
      );
      setState(() => isLoading = false);
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  void selectAnswer(String questionId, String answerId) {
    selectedAnswers[questionId] = answerId;
    setState(() {});
  }

  Future<void> submitQuiz() async {
    if (quiz?.sId == null) return;

    try {
      setState(() => isLoading = true);

      final response = await _quizRepository.submitQuiz(
        quiz!.sId!,
        selectedAnswers,
      );
      if (response.allGood) {
        quizResult = response.body;
        isQuizSubmitted = true;
      }

      setState(() => isLoading = false);
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      currentQuestionIndex++;
      setState(() {});
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex > 0) {
      currentQuestionIndex--;
      setState(() {});
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
              'Thời gian: ${quiz?.duration} phút\n'
              'Số câu hỏi: ${quiz?.totalQuestions}\n'
              'Điểm đạt: ${quiz?.passingScore}%',
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
