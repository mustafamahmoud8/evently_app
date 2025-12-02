import 'package:evently/common/app_constants.dart';
import 'package:evently/common/app_prefs.dart';
import 'package:flutter/cupertino.dart';

class LocalizationProvider extends ChangeNotifier {
  String appLocalization = 'en';

  Future<void> changeLocalization() async {
    if (appLocalization == 'en') {
      appLocalization = 'ar';
    } else {
      appLocalization = 'en';
    }
    //caching localization(shared preference)
    await AppPrefs.localizationSetBool(
        AppConstants.localizationKey, appLocalization == 'en' ? true : false);
    notifyListeners();
  }

  String getAppLocaleString() {
    return appLocalization == 'en' ? 'ar' : 'en';
  }

  //caching localization(shared preference)
  Future<void> localizationGetBool() async {
    bool? localizationGetBool =
        AppPrefs.localizationGetBool(AppConstants.localizationKey);
    if (localizationGetBool == true) {
      appLocalization = 'en';
    } else if (localizationGetBool == false) {
      appLocalization = 'ar';
    } else {
      appLocalization = 'en';
    }
  }
}
