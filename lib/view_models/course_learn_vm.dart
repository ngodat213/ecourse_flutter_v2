import 'package:ecourse_flutter_v2/app/domain/repositories/course_repository.dart';
import 'package:ecourse_flutter_v2/app/domain/repositories/lesson_repository.dart';
import 'package:ecourse_flutter_v2/app/domain/repositories/user_progress_repository.dart';
import 'package:ecourse_flutter_v2/core/base/base_view_model.dart';
import 'package:ecourse_flutter_v2/app/data/models/course_model.dart';
import 'package:ecourse_flutter_v2/app/data/models/lesson_content_model.dart';
import 'package:ecourse_flutter_v2/app/data/models/lesson_model.dart';
import 'package:ecourse_flutter_v2/app/data/models/quiz_model.dart';
import 'package:ecourse_flutter_v2/app/data/models/user_progress_model.dart';
import 'package:ecourse_flutter_v2/app/data/repositories/course_repository_imp.dart';
import 'package:ecourse_flutter_v2/app/data/repositories/lesson_repository_impl.dart';
import 'package:ecourse_flutter_v2/app/data/repositories/user_progress_repository_impl.dart';
import 'package:ecourse_flutter_v2/enums/lesson_content_type.enum.dart';

class CourseLearnVM extends BaseVM {
  final CourseRepository _courseRepository = CourseRepositoryImpl();
  final LessonRepository _lessonRepository = LessonRepositoryImpl();
  final UserProgressRepository _progressRepository =
      UserProgressRepositoryImpl();

  CourseLearnVM(super.context, this.course) {
    _initData();
  }

  CourseModel? course;
  List<LessonModel> lessons = [];
  List<UserProgressModel> lessonProgress = [];
  String? currentProgressId;
  LessonContentModel? currentContent;
  QuizModel? quiz;
  bool isLoadingVideo = false;
  Function? onVideoUrlChanged;
  Function? onQuizChanged;
  Future<void> _initData() async {
    try {
      if (course?.sId == null) return;
      await Future.wait([
        _getCourse(course!.sId!),
        _getCourseLessons(course!.sId!),
        _getCourseProgress(course!.sId!),
      ]);
    } catch (e) {
      setError(e.toString());
    }
  }

  Future<void> onContentSelected(LessonContentModel content) async {
    try {
      if (content.sId == currentProgressId) return;

      currentProgressId = content.sId;

      await _createContentProgress(content.sId!);
      // Nếu là video, cập nhật URL và thông báo để khởi tạo player
      if (content.type == LessonContentType.video) {
        isLoadingVideo = true;
        currentContent = content;

        notifyListeners();
        isLoadingVideo = false;
        onVideoUrlChanged?.call();
      } else if (content.type == LessonContentType.quiz) {
        currentContent = content;
        quiz = content.quiz;
        notifyListeners();
        onQuizChanged?.call();
      } else {
        currentContent = null;
        quiz = null;
        notifyListeners();
      }
    } catch (e) {
      setError(e.toString());
      isLoadingVideo = false;
      notifyListeners();
    }
  }

  Future<void> _createContentProgress(String contentId) async {
    if (!lessonProgress.any(
      (element) => element.lessonContent!.sId == contentId,
    )) {
      final response = await _progressRepository.createContentProgress(
        course!.sId!,
        contentId,
      );
      if (response.allGood) {
        lessonProgress.add(UserProgressModel.fromJson(response.body));
      }
      notifyListeners();
    }
  }

  Future<void> _getCourse(String courseId) async {
    setLoading(true);
    final response = await _courseRepository.getCourseById(courseId);
    if (response.allGood) {
      course = CourseModel.fromJson(response.body);
      notifyListeners();
    }
    setLoading(false);
  }

  Future<void> _getCourseLessons(String courseId) async {
    setLoading(true);
    final response = await _lessonRepository.getLessons(courseId);
    if (response.allGood) {
      for (var lesson in response.body['data']) {
        lessons.add(LessonModel.fromJson(lesson));
      }
      notifyListeners();
    }
    setLoading(false);
  }

  Future<void> _getCourseProgress(String courseId) async {
    try {
      final response = await _progressRepository.getCourseProgress(courseId);
      if (response.allGood) {
        for (var progress in response.body) {
          lessonProgress.add(UserProgressModel.fromJson(progress));
        }
      }
      onContentSelected(lessonProgress.last.lessonContent!);
      notifyListeners();
    } catch (e) {
      setError(e.toString());
    }
  }

  Future<void> markContentComplete(String contentId) async {
    // Tìm content trong lessonProgress
    final existingProgress = lessonProgress.firstWhere(
      (element) => element.lessonContent?.sId == contentId,
    );

    // Chỉ call API nếu content chưa completed
    if (existingProgress.status != 'completed') {
      final response = await _progressRepository.markContentComplete(contentId);
      if (response.allGood) {
        existingProgress.status = 'completed';
        notifyListeners();
      }
    }
  }

  @override
  void dispose() {
    currentContent = null;
    currentProgressId = null;
    onVideoUrlChanged = null;
    onQuizChanged = null;
    super.dispose();
  }
}
