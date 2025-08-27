import 'package:flutter/material.dart';

class AppSettingsProvider extends ChangeNotifier {
  // Theme mode settings
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;
  
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  
  void toggleThemeMode() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
  
  // Language settings
  Locale _locale = const Locale('fa', '');
  Locale get locale => _locale;
  
  bool get isEnglish => _locale.languageCode == 'en';
  
  void toggleLanguage() {
    _locale = _locale.languageCode == 'fa' ? const Locale('en', '') : const Locale('fa', '');
    notifyListeners();
  }
}