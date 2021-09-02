import 'package:todo/index.dart';

enum ActiveTheme {
  DARK_THEME,
  LIGHT_THEME,
}

class ThemeProvider extends ChangeNotifier {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<SharedPreferences> get prefs async => await _prefs;

  ActiveTheme _currentTheme = ActiveTheme.DARK_THEME;
  ActiveTheme get currentTheme => _currentTheme;

  var _parsedThemeEnum;

  void setInitialTheme() async {
    await prefs.then((value) {
      if (value.containsKey('THEME')) {
        final theme = value.getString('THEME');

        if (theme!.isEmpty) {
          _currentTheme = ActiveTheme.DARK_THEME;
        } else if (theme == 'DARK_THEME') {
          _currentTheme = ActiveTheme.DARK_THEME;
        } else if (theme == 'LIGHT_THEME') {
          _currentTheme = ActiveTheme.LIGHT_THEME;
        }
      } else {
        _parsedThemeEnum = ActiveTheme.DARK_THEME.toString().split('.').last;
        value.setString('THEME', _parsedThemeEnum);
      }
    });

    notifyListeners();
  }

  void toggleTheme() async {
    if (_currentTheme == ActiveTheme.LIGHT_THEME) {
      _currentTheme = ActiveTheme.DARK_THEME;
    } else if (_currentTheme == ActiveTheme.DARK_THEME) {
      _currentTheme = ActiveTheme.LIGHT_THEME;
    }

    _parsedThemeEnum = _currentTheme.toString().split('.').last;
    await prefs.then((value) => value.setString('THEME', _parsedThemeEnum));

    setInitialTheme();

    notifyListeners();
  }
}
