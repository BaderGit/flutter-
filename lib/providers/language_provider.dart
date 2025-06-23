import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale currentLocale = Locale("en");
  void toggleLanguage() {
    currentLocale = currentLocale.languageCode == 'en'
        ? const Locale('ar')
        : const Locale('en');
    notifyListeners();
  }
}
