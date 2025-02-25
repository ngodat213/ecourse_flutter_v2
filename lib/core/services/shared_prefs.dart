import 'dart:convert';
import 'package:ecourse_flutter_v2/models/user_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/app_config.dart';

class SharedPrefs {
  static late SharedPreferences _prefs;

  // Initialize SharedPreferences instance
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Token management
  static String? getToken() => _prefs.getString(AppConfig.tokenKey);

  static Future<void> setToken(String token) async {
    await _prefs.setString(AppConfig.tokenKey, token);
  }

  static String? getRefreshToken() =>
      _prefs.getString(AppConfig.refreshTokenKey);

  static Future<void> setRefreshToken(String refreshToken) async {
    await _prefs.setString(AppConfig.refreshTokenKey, refreshToken);
  }

  static Future<void> removeToken() async {
    await _prefs.remove(AppConfig.tokenKey);
  }

  static Future<void> setUser(UserProfile userProfile) async {
    await _prefs.setString(AppConfig.userKey, jsonEncode(userProfile.toJson()));
  }

  static UserProfile? getUser() {
    final String? jsonString = _prefs.getString(AppConfig.userKey);
    if (jsonString == null) return null;
    return UserProfile.fromJson(jsonDecode(jsonString));
  }

  static Future<void> removeUser() async {
    await _prefs.remove(AppConfig.userKey);
  }

  // Theme management
  static String? getThemeMode() => _prefs.getString(AppConfig.themeKey);

  static Future<void> setThemeMode(String themeMode) async {
    await _prefs.setString(AppConfig.themeKey, themeMode);
  }

  // Language management
  static String? getLanguage() => _prefs.getString(AppConfig.languageKey);

  static Future<void> setLanguage(String languageCode) async {
    await _prefs.setString(AppConfig.languageKey, languageCode);
  }

  // Generic methods for different types
  static Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  static String? getString(String key) => _prefs.getString(key);

  static Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  static int? getInt(String key) => _prefs.getInt(key);

  static Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  static bool? getBool(String key) => _prefs.getBool(key);

  // Object storage
  static Future<void> setObject(String key, Map<String, dynamic> value) async {
    await _prefs.setString(key, jsonEncode(value));
  }

  static Map<String, dynamic>? getObject(String key) {
    final String? jsonString = _prefs.getString(key);
    if (jsonString == null) return null;
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }

  // Clear specific key
  static Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  // Clear all data
  static Future<void> clear() async {
    await _prefs.clear();
  }

  // Check if key exists
  static bool containsKey(String key) => _prefs.containsKey(key);
}
