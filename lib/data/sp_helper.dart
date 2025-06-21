import 'package:shared_preferences/shared_preferences.dart';

class SpHelper {
  SpHelper._();

  static final SpHelper spHelper = SpHelper._();
  SharedPreferences? prefs;

  Future<void> setUserType(String userType) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userType', userType);
  }

  Future<String?> getUserType() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? userType;
    userType = pref.getString('userType');
    return userType;
  }
}
