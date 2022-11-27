
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  String _theme = "light";

  String get theme => _theme;

  set theme(String value) {
    _theme = value;
    notifyListeners();
  }

  ThemeMode getTheme() {
    switch (_theme) {
      case "dark":
        return ThemeMode.dark;
      default:
        return ThemeMode.light;
    }
  }
}


