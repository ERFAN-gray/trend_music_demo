import 'package:flutter/material.dart';
import 'package:trend_music_demo/themes/dark_mode.dart';
import 'package:trend_music_demo/themes/light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _theme = darkMode;

  ThemeData get theme {
    return _theme;
  }

  set theme(ThemeData theme) {
    _theme = theme;
    notifyListeners();
  }

  bool get isDarkMode => _theme == darkMode;

  void toggleTheme() {
    if (isDarkMode) {
      theme = lightMode;
    } else {
      theme = darkMode;
    }
  }
}
