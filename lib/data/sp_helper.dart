import 'package:shared_preferences/shared_preferences.dart';

class SpHelper {
  SpHelper._();

  static final SpHelper spHelper = SpHelper._();
  SharedPreferences? prefs;

  Future<void> setUserType(String userType) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userType', userType);
  }

  Future<void> setLanguage(String locale) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('currentLocale', locale);
  }

  Future<String?> getUserType() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? userType;
    userType = pref.getString('userType');
    return userType;
  }

  Future<String?> getLanguage() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? currentLocale;
    currentLocale = pref.getString('currentLocale');

    return currentLocale;
  }
}
