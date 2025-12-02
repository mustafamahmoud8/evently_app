import 'package:evently/providers/localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_assets.dart';
import '../app_colors.dart';

class LocalizationSwitch extends StatefulWidget {
  const LocalizationSwitch({super.key});

  @override
  State<LocalizationSwitch> createState() => _LocalizationSwitchState();
}

class _LocalizationSwitchState extends State<LocalizationSwitch> {
  @override
  Widget build(BuildContext context) {
    bool switchValue =
        context.read<LocalizationProvider>().appLocalization == 'en'
            ? false
            : true;
    return Switch(
      value: switchValue,
      onChanged: (value) {
        switchValue = !switchValue;
        context.read<LocalizationProvider>().changeLocalization();
        setState(() {});
      },
      activeThumbImage: AssetImage(AppImages.arabicIcon),
      inactiveThumbImage: AssetImage(AppImages.englishIcon),
      trackColor: WidgetStatePropertyAll(Colors.transparent),
      trackOutlineColor: WidgetStatePropertyAll(AppColors.mainColor),
    );
  }
}
