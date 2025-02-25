class AppConfig {
  static const String baseUrl = 'YOUR_BASE_URL';
  static const int connectTimeout = 5000;
  static const int receiveTimeout = 3000;

  // API Endpoints
  /// Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register/mobile';
  static const String users = '/users';
  // User
  static const String userProfile = '/users/profile';

  /// Course
  static const String courses = '/courses';
  static const String courseCategories = '/course-categories';
  static const String courseChapters = '/course-chapters';
  static const String courseLessons = '/course-lessons';
  static const String courseQuizzes = '/course-quizzes';
  static const String courseQuizQuestions = '/course-quiz-questions';
  // Shared Preferences Keys
  static const String tokenKey = 'token';
  static const String refreshTokenKey = 'refresh_token';
  static const String themeKey = 'theme_mode';
  static const String languageKey = 'language';
  static const String userKey = 'user';
}
