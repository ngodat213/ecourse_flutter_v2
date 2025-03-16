import 'package:ecourse_flutter_v2/core/base/base_view_model.dart';
import 'package:ecourse_flutter_v2/models/course_model.dart';
import 'package:ecourse_flutter_v2/models/lesson_content_model.dart';
import 'package:ecourse_flutter_v2/models/lesson_model.dart';
import 'package:ecourse_flutter_v2/models/quiz_model.dart';
import 'package:ecourse_flutter_v2/models/user_progress_model.dart';
import 'package:ecourse_flutter_v2/repositories/course_repository.dart';
import 'package:ecourse_flutter_v2/repositories/lesson_repository.dart';
import 'package:ecourse_flutter_v2/repositories/user_progress_repository.dart';
import 'package:ecourse_flutter_v2/enums/lesson_content_type.enum.dart';

class CourseLearnVM extends BaseVM {
  final CourseRepository _courseRepository = CourseRepository();
  final LessonRepository _lessonRepository = LessonRepository();
  final UserProgressRepository _progressRepository = UserProgressRepository();

  CourseLearnVM(super.context, this.course) {
    _initData();
  }

  CourseModel? course;
  List<LessonModel> lessons = [];
  List<UserProgressModel> lessonProgress = [];
  String? currentProgressId;
  String? videoUrl;
  QuizModel? quiz;
  bool isLoadingVideo = false;
  Function? onVideoUrlChanged;
  Function? onQuizChanged;
  Future<void> _initData() async {
    try {
      if (course?.sId == null) return;
      await Future.wait([
        getCourse(course!.sId!),
        getCourseLessons(course!.sId!),
        getCourseProgress(course!.sId!),
      ]);
    } catch (e) {
      setError(e.toString());
    }
  }

  Future<void> onContentSelected(LessonContentModel content) async {
    try {
      if (content.sId == currentProgressId) return;

      currentProgressId = content.sId;

      // Nếu là video, cập nhật URL và thông báo để khởi tạo player
      if (content.type == LessonContentType.video) {
        isLoadingVideo = true;
        notifyListeners();

        // Lấy URL video nếu chưa có
        if (content.video?.url == null) {
          final response = await _lessonRepository.getLessonVideo(content.sId!);
          if (response.allGood) {
            videoUrl = response.body['url'];
          }
        } else {
          videoUrl = content.video?.url;
        }

        isLoadingVideo = false;
        // Gọi callback để khởi tạo lại video player
        onVideoUrlChanged?.call();
      } else if (content.type == LessonContentType.quiz) {
        videoUrl = null;
        quiz = content.quiz;
        notifyListeners();
        onQuizChanged?.call();
      } else {
        videoUrl = null;
        quiz = null;
        notifyListeners();
      }
    } catch (e) {
      setError(e.toString());
      isLoadingVideo = false;
      notifyListeners();
    }
  }

  Future<void> getCourse(String courseId) async {
    setLoading(true);
    final response = await _courseRepository.getCourseById(courseId);
    if (response.allGood) {
      course = CourseModel.fromJson(response.body);
      notifyListeners();
    }
    setLoading(false);
  }

  Future<void> getCourseLessons(String courseId) async {
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

  Future<void> getCourseProgress(String courseId) async {
    try {
      final response = await _progressRepository.getAllProgress(courseId);
      if (response.allGood) {
        for (var progress in response.body) {
          lessonProgress.add(UserProgressModel.fromJson(progress));
        }
      }
      currentProgressId = lessonProgress.last.lessonId;
      notifyListeners();
    } catch (e) {
      setError(e.toString());
    }
  }

  Future<void> updateLessonProgress(String lessonId, double progress) async {
    final response = await _progressRepository.updateProgress(lessonId, {
      'progress_percent': progress,
    });

    if (response.allGood) {
      lessonProgress
          .firstWhere((element) => element.lessonId == lessonId)
          .progressPercent = progress;
      notifyListeners();
    }
  }

  Future<void> markLessonComplete(String lessonId) async {
    final response = await _progressRepository.markLessonComplete(lessonId);
    if (response.allGood) {
      lessonProgress
          .firstWhere((element) => element.lessonId == lessonId)
          .progressPercent = 100;
      notifyListeners();
    }
  }

  double getLessonProgress(String lessonId) {
    return lessonProgress
            .firstWhere((element) => element.lessonId == lessonId)
            .progressPercent ??
        0;
  }

  @override
  void dispose() {
    videoUrl = null;
    currentProgressId = null;
    onVideoUrlChanged = null;
    onQuizChanged = null;
    super.dispose();
  }
}
