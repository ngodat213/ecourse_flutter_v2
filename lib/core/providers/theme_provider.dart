import 'package:flutter/material.dart';
import '../config/app_theme.dart';
import '../services/shared_prefs.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeMode _themeMode;

  ThemeProvider(String? savedThemeMode) {
    _themeMode = _getThemeModeFromString(savedThemeMode);
  }

  ThemeMode get themeMode => _themeMode;

  ThemeMode _getThemeModeFromString(String? value) {
    return ThemeMode.values.firstWhere(
      (mode) => mode.toString() == value,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    await SharedPrefs.setThemeMode(mode.toString());
    notifyListeners();
  }

  ThemeData get lightTheme => AppTheme.lightTheme;
  ThemeData get darkTheme => AppTheme.darkTheme;
}
