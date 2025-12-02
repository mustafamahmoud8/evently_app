import 'package:shared_preferences/shared_preferences.dart';

class AppPrefs {
  static late SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

//onboarding
  static Future<void> onboardingSetBool(String key, bool value) async {
    await prefs.setBool(key, value);
  }

  static bool? onboardingGetBool(String key) {
    return prefs.getBool(key);
  }

//user location
  static Future<void> userLocationLatitudeSetDouble(
      String key, double value) async {
    await prefs.setDouble(key, value);
  }

  static double? userLocationLatitudeGetDouble(String key) {
    return prefs.getDouble(key);
  }

  static Future<void> userLocationLongitudeSetDouble(
      String key, double value) async {
    await prefs.setDouble(key, value);
  }

  static double? userLocationLongitudeGetDouble(String key) {
    return prefs.getDouble(key);
  }
//localization
  static Future<void> localizationSetBool(
      String key, bool value) async {
    await prefs.setBool(key, value);
  }

  static bool? localizationGetBool(String key) {
    return prefs.getBool(key);
  }
//theme
  static Future<void> themeSetBool(
      String key, bool value) async {
    await prefs.setBool(key, value);
  }

  static bool? themeGetBool(String key) {
    return prefs.getBool(key);
  }
}
