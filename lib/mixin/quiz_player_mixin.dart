import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/widgets/buttons/elevated_button.dart';
import 'package:ecourse_flutter_v2/models/quiz_model.dart';
import 'package:ecourse_flutter_v2/models/quiz_question_model.dart';
import 'package:ecourse_flutter_v2/repositories/quiz_repository.dart';
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
        isQuizStarted = true;
      }

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

    if (isQuizSubmitted && quizResult != null) {
      return _buildQuizResult(context);
    }

    if (isQuizStarted && questions.isNotEmpty) {
      return _buildQuizQuestion(context);
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

  Widget _buildQuizQuestion(BuildContext context) {
    final question = questions[currentQuestionIndex];
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Câu ${currentQuestionIndex + 1}/${questions.length}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'Điểm: ${question.points}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            question.question ?? '',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          if (question.imageId != null) ...[
            SizedBox(height: 16.h),
            SmartImage(
              source: question.imageId?.url ?? '',
              width: 1.sw,
              height: 200.h,
              fit: BoxFit.cover,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ],
          SizedBox(height: 16.h),
          ...?question.answers?.map(
            (answer) => RadioListTile(
              value: answer.sId,
              groupValue: selectedAnswers[question.sId],
              onChanged: (value) => selectAnswer(question.sId!, value!),
              title: Text(answer.text ?? ''),
            ),
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (currentQuestionIndex > 0)
                CustomElevatedButton(
                  context: context,
                  text: 'Câu trước',
                  onPressed: previousQuestion,
                ),
              if (currentQuestionIndex < questions.length - 1)
                CustomElevatedButton(
                  context: context,
                  text: 'Câu tiếp',
                  onPressed: nextQuestion,
                )
              else
                CustomElevatedButton(
                  context: context,
                  text: 'Nộp bài',
                  onPressed: submitQuiz,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuizResult(BuildContext context) {
    final bool passed = quizResult?['passed'] ?? false;
    final double score = (quizResult?['score'] ?? 0).toDouble();
    final int totalQuestions = quizResult?['total_questions'] ?? 0;
    final int correctAnswers = quizResult?['correct_answers'] ?? 0;

    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            passed ? Icons.check_circle : Icons.cancel,
            size: 48.w,
            color: passed ? AppColor.success : AppColor.error,
          ),
          SizedBox(height: 16.h),
          Text(
            passed ? 'Chúc mừng!' : 'Rất tiếc!',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: passed ? AppColor.success : AppColor.error,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Điểm số: $score%\n'
            'Số câu đúng: $correctAnswers/$totalQuestions',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: 24.h),
          if (!passed)
            CustomElevatedButton(
              context: context,
              text: 'Làm lại',
              onPressed: startQuiz,
            ),
        ],
      ),
    );
  }
}
