import 'dart:developer';

import 'package:final_project/data/sp_helper.dart';
import 'package:final_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale currentLocale = Locale("en");
  bool isArabic = false;
  LanguageProvider() {
    getCurrentLocale();
  }
  getCurrentLocale() async {
    currentLocale = Locale(await SpHelper.spHelper.getLanguage() ?? "en");
    notifyListeners();
  }

  void toggleLanguage() async {
    isArabic = isArabic ? false : true;
    log("language is arabic now $isArabic");
    currentLocale = currentLocale.languageCode == 'en'
        ? const Locale('ar')
        : const Locale('en');
    await SpHelper.spHelper.setLanguage(currentLocale.toString());
    notifyListeners();
  }

  String getSpecialityLocalization(
    String specialityKey,
    AppLocalizations localization,
  ) {
    switch (specialityKey.toLowerCase()) {
      case 'general':
        return localization.general;
      case 'cardiology':
        return localization.cardiology;
      case 'respirations':
        return localization.respirations;
      case 'dermatology':
        return localization.dermatology;
      case 'gynecology':
        return localization.gynecology;
      case 'dental':
        return localization.dental;

      default:
        return specialityKey;
    }
  }

  String getGenderLocalization(String gender, AppLocalizations localization) {
    switch (gender.toLowerCase()) {
      case 'male':
        return localization.male;
      case 'female':
        return localization.female;

      default:
        return gender;
    }
  }

  String getTimeLocalization(String time, AppLocalizations localization) {
    switch (time.toLowerCase()) {
      case '9:00 am':
        return localization.time_9am;
      case '10:00 am':
        return localization.time_10am;
      case '11:00 am':
        return localization.time_11am;
      case '12:00 pm':
        return localization.time_12pm;
      case '13:00 pm':
        return localization.time_1pm;
      case '14:00 pm':
        return localization.time_2pm;
      case '15:00 pm':
        return localization.time_3pm;
      case '16:00 pm':
        return localization.time_4pm;

      default:
        return time;
    }
  }

  // "monday": "Monday",
  // "tuesday": "Tuesday",
  // "wednesday": "Wednesday",
  // "thursday": "Thursday",
  // "friday": "Friday",
  // "saturday": "Saturday",
  // "sunday": "Sunday",

  String getDayLocalization(String day, AppLocalizations localization) {
    switch (day.toLowerCase()) {
      case 'monday':
        return localization.monday;
      case 'tuesday':
        return localization.tuesday;
      case 'wednesday':
        return localization.wednesday;
      case 'thursday':
        return localization.thursday;
      case 'friday':
        return localization.friday;
      case 'saturday':
        return localization.saturday;
      case 'sunday':
        return localization.sunday;

      default:
        return day;
    }
  }
}
