class AppConfig {
  static const String apiUrl = 'https://4a50-112-197-36-236.ngrok-free.app';
  static const String socketUrl = 'https://4a50-112-197-36-236.ngrok-free.app';
  static const int connectTimeout = 5000;
  static const int receiveTimeout = 3000;

  static const String adminUsers = '/admin/users';
  static const String setUserRole = '/admin/users/role';
  static const String uploadAvatar = '/users/avatar';
  static const String changePassword = '/users/password';

  // API Endpoints
  /// Auth
  static const String auth = '/auth';
  static const String login = '/auth/login';
  static const String register = '/auth/register/mobile';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String verifyToken = '/auth/verify-token';
  static const String refreshToken = '/auth/refresh-token';
  static const String logout = '/auth/logout';
  static const String verifyEmail = '/auth/verify-email';

  // User
  static const String users = '/users';
  static const String userProfile = '/users/profile';
  static const String teachers = '$users/teachers';

  /// Course
  static const String courses = '/courses';

  /// Lesson
  static const String lessons = '/lessons/course';

  /// Orders
  static const String orders = '/orders';

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
  static const String tokenExpiryKey = 'token_expiry';
  static const String isOnboardingSkippedKey = 'is_onboarding_skipped';
}
