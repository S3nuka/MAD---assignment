import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _themePreferenceKey = 'theme_preference';
  static const String _useSystemThemeKey = 'use_system_theme';
  final SharedPreferences _prefs;
  bool _isDarkMode;
  bool _useSystemTheme;

  ThemeProvider(this._prefs)
      : _isDarkMode = _prefs.getBool(_themePreferenceKey) ?? false,
        _useSystemTheme = _prefs.getBool(_useSystemThemeKey) ?? true;

  bool get isDarkMode => _useSystemTheme
      ? WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark
      : _isDarkMode;

  bool get useSystemTheme => _useSystemTheme;

  Future<void> toggleTheme() async {
    if (_useSystemTheme) {
      // First switch to manual mode with current system theme
      _useSystemTheme = false;
      _isDarkMode = WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
    } else {
      // Toggle the theme when in manual mode
      _isDarkMode = !_isDarkMode;
    }
    await _prefs.setBool(_themePreferenceKey, _isDarkMode);
    await _prefs.setBool(_useSystemThemeKey, _useSystemTheme);
    notifyListeners();
  }

  Future<void> toggleSystemTheme() async {
    _useSystemTheme = !_useSystemTheme;
    await _prefs.setBool(_useSystemThemeKey, _useSystemTheme);
    notifyListeners();
  }
}
