import 'package:flutter/material.dart';

class LanguageNotifier extends ChangeNotifier {
  String _selectedLanguage = 'ENGG';

  String get selectedLanguage => _selectedLanguage;

  void setLanguage(String language) {
    _selectedLanguage = language;
    notifyListeners();
  }
}
