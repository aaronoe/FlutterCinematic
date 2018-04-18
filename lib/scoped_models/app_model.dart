import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppModel extends Model {
  final SharedPreferences _sharedPrefs;
  static const _THEME_KEY = "theme_prefs_key";

  AppModel(this._sharedPrefs) {
    _currentTheme = _sharedPrefs.getInt(_THEME_KEY) ?? 0;
  }

  static List<ThemeData> _themes = [
    new ThemeData.dark(),
    new ThemeData.light()
  ];
  int _currentTheme = 0;

  ThemeData get theme => _themes[_currentTheme];

  void toggleTheme() {
    _currentTheme = (_currentTheme + 1) % _themes.length;
    _sharedPrefs.setInt(_THEME_KEY, _currentTheme);
    notifyListeners();
  }
}
