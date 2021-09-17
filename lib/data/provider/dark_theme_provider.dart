import 'package:flutter/cupertino.dart';
import 'file:///D:/Dev/Flutter/online_shop_udemy/lib/data/models/dark_theme_preferences.dart';

// difference between "extends" and "with" ?
class DarkThemeProvider with ChangeNotifier {
  DarkThemePreferences darkThemePreferences = DarkThemePreferences();
  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreferences.setDarkTheme(_darkTheme);
    notifyListeners();
  }
}
