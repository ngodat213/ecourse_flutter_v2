class AppConfig {
  static const String baseUrl = 'http://192.168.0.105:3333/api';
  static const int connectTimeout = 5000;
  static const int receiveTimeout = 3000;

  static const String adminUsers = '/admin/users';
  static const String setUserRole = '/admin/users/role';
  static const String uploadAvatar = '/users/avatar';
  static const String changePassword = '/users/password';

  // API Endpoints
  /// Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register/mobile';
  // User
  static const String users = '/users';
  static const String userProfile = '/users/profile';
  static const String teachers = '$users/teachers';

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
  static const String savedEmailKey = 'saved_email';
  static const String savedPasswordKey = 'saved_password';
  static const String savedBiometricsKey = 'saved_biometrics';
  static const String userRoleKey = 'user_role';
  static const String userIdKey = 'user_id';
}
