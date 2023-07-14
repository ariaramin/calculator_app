import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  SharedPreferences sharedPreferences;
  static const String _themeKey = 'theme';
  late bool _isDark;

  bool get isDark => _isDark;

  set isDark(bool value) {
    _isDark = value;
    _setTheme(value);
  }

  ThemeProvider(this.sharedPreferences) {
    _getTheme();
  }

  _setTheme(bool value) {
    sharedPreferences.setBool(_themeKey, value);
    notifyListeners();
  }

  _getTheme() {
    _isDark = sharedPreferences.getBool(_themeKey) ?? false;
    notifyListeners();
  }
}
