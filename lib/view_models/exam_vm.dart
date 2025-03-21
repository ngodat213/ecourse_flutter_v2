import 'dart:async';

import 'package:ecourse_flutter_v2/core/base/base_view_model.dart';
import 'package:ecourse_flutter_v2/models/lesson_content_model.dart';
import 'package:ecourse_flutter_v2/models/quiz_question_model.dart';
import 'package:ecourse_flutter_v2/models/user_profile.dart';
import 'package:ecourse_flutter_v2/repositories/quiz_repository.dart';
import 'package:ecourse_flutter_v2/view_models/user_vm.dart';
import 'package:provider/provider.dart';

/// Enum định nghĩa trạng thái của bài thi
enum ExamStatus { taking, submit }

class ExamVM extends BaseVM {
  // Constructor
  ExamVM(super.context, {required this.content, required this.questions}) {
    _quizRepository = QuizRepository();
    startTimer();
  }

  // Dependencies
  late final QuizRepository _quizRepository;

  // Properties
  final LessonContentModel content;
  final List<QuizQuestionModel> questions;
  ExamStatus status = ExamStatus.taking;
  UserProfile? profileUser;

  // Timer related
  Timer? _timer;
  int _time = 0;
  int get time => _time;

  String get formattedTime {
    final minutes = _time ~/ 60;
    final seconds = _time % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // Answer related
  final Map<String, int> _selectedAnswers = {};
  int? getSelectedAnswer(String questionId) => _selectedAnswers[questionId];
  bool get isAllAnswered => _selectedAnswers.length == questions.length;
  int get answeredCount => _selectedAnswers.length;

  // Result related
  int _score = 0;
  int get score => _score;
  int _correctAnswers = 0;
  int get correctAnswers => _correctAnswers;
  bool _passed = false;
  bool get passed => _passed;

  // Methods
  @override
  void onInit() {
    super.onInit();
    profileUser = context.read<UserVM>().userProfile;
  }

  /// Kiểm tra xem đáp án có được chọn không
  bool isAnswerSelected(String questionId, int answerIndex) {
    return _selectedAnswers[questionId] == answerIndex;
  }

  /// Xử lý khi user chọn đáp án
  void selectAnswer(String questionId, int answerIndex) {
    if (_selectedAnswers[questionId] == answerIndex) {
      _selectedAnswers.remove(questionId);
    } else {
      _selectedAnswers[questionId] = answerIndex;
    }
    notifyListeners();
  }

  /// Khởi động timer đếm ngược
  void startTimer() {
    _time = content.quiz?.duration ?? 0;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_time > 0) {
        _time--;
        notifyListeners();
      } else {
        _timer?.cancel();
        submitExam(); // Tự động nộp bài khi hết giờ
      }
    });
  }

  /// Submit bài thi
  Future<void> submitExam() async {
    if (!isAllAnswered) {
      setError('Vui lòng trả lời hết các câu hỏi');
      return;
    }

    try {
      setLoading(true);

      // Format answers theo yêu cầu API
      final Map<String, String> answers = _formatAnswers();

      // Gọi API submit
      final response = await _quizRepository.submitQuiz(
        content.quiz?.sId ?? '',
        answers,
      );

      if (response.allGood) {
        // Cập nhật kết quả từ response
        _updateExamResult(response.body);
        // Chuyển trạng thái sang đã nộp bài
        status = ExamStatus.submit;
        notifyListeners();
      } else {
        setError(response.message);
      }
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  /// Format câu trả lời theo yêu cầu API
  Map<String, String> _formatAnswers() {
    final Map<String, String> answers = {};
    _selectedAnswers.forEach((questionId, answerIndex) {
      final question = questions.firstWhere((q) => q.sId == questionId);
      final answerId = question.answers?[answerIndex].sId;
      if (answerId != null) {
        answers[questionId] = answerId;
      }
    });
    return answers;
  }

  /// Cập nhật kết quả bài thi từ response
  void _updateExamResult(Map<String, dynamic> response) {
    _score = response['score'] ?? 0;
    _correctAnswers = response['correct_answers'] ?? 0;
    _passed = response['passed'] ?? false;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
