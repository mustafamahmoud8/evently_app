import 'package:evently/common/app_constants.dart';
import 'package:evently/common/app_prefs.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  Future<void> changeAppTheme() async {
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
    //caching theme(shared preference)
    await AppPrefs.themeSetBool(
        AppConstants.themeKey, themeMode == ThemeMode.light ? true : false);
    notifyListeners();
  }

//caching theme(shared preference)
  Future<void> themeGetBool() async {
    bool? themeGetBool = AppPrefs.themeGetBool(AppConstants.themeKey);
    if (themeGetBool == true) {
      themeMode = ThemeMode.light;
    } else if (themeGetBool == false) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
  }
}
