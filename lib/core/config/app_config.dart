class AppConfig {
  static const String baseUrl = 'YOUR_BASE_URL';
  static const int connectTimeout = 5000;
  static const int receiveTimeout = 3000;

  // API Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String users = '/users';

  // Shared Preferences Keys
  static const String tokenKey = 'token';
  static const String themeKey = 'theme_mode';
  static const String languageKey = 'language';
}
