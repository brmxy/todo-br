import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ActiveTheme {
  DARK_THEME,
  LIGHT_THEME,
}

class ThemeProvider extends ChangeNotifier {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<SharedPreferences> get prefs async => await _prefs;

  ActiveTheme _currentTheme = ActiveTheme.DARK_THEME;
  ActiveTheme get currentTheme => _currentTheme;

  late String _parsedThemeEnum;

  /// This method is not stable. Please don't use this method.
  // ignore: unused_element
  void _setInitialTheme() async {
    await prefs.then((value) {
      final theme = value.getString('THEME');

      if (theme!.isEmpty) {
        _currentTheme = ActiveTheme.DARK_THEME;
      } else if (theme == 'DARK_THEME') {
        _currentTheme = ActiveTheme.DARK_THEME;
      } else if (theme == 'LIGHT_THEME') {
        _currentTheme = ActiveTheme.LIGHT_THEME;
      }
    });
  }

  void toggleTheme() async {
    if (_currentTheme == ActiveTheme.LIGHT_THEME) {
      _currentTheme = ActiveTheme.DARK_THEME;
    } else if (_currentTheme == ActiveTheme.DARK_THEME) {
      _currentTheme = ActiveTheme.LIGHT_THEME;
    }

    _parsedThemeEnum = _currentTheme.toString().split('.').last;
    await prefs.then((value) => value.setString('THEME', _parsedThemeEnum));
    notifyListeners();
  }
}
