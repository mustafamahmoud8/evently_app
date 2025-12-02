import 'package:evently/common/app_assets.dart';
import 'package:evently/common/app_colors.dart';
import 'package:evently/common/custom_text_styles.dart';
import 'package:evently/common/widgets/custom_main_button.dart';
import 'package:evently/common/widgets/localization_switch.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/onboarding/screens/onboarding_screen_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';

class OnboardingScreen1 extends StatefulWidget {
  static const String routeName = '/OnboardingScreen1';

  const OnboardingScreen1({super.key});

  @override
  State<OnboardingScreen1> createState() => _OnboardingScreen1State();
}

class _OnboardingScreen1State extends State<OnboardingScreen1> {
  bool themeSwitchValue = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          AppImages.onboardingLogo,
          height: 50,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              context.read<ThemeProvider>().themeMode == ThemeMode.light
                  ? AppImages.onboardingScreen1ImageLight
                  : AppImages.onboardingScreen1ImageDark,
              height: height * 0.42,
              width: width * 0.918,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 28),
              child: Text(
                AppLocalizations.of(context)!.onboarding1Text1,
                style: CustomTextStyles.style18w700Black
                    .copyWith(color: AppColors.mainColor, fontSize: 20),
              ),
            ),
            Text(
              AppLocalizations.of(context)!.onboarding1Text2,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.language,
                    style: CustomTextStyles.style18w500Black
                        .copyWith(color: AppColors.mainColor, fontSize: 20),
                  ),
                  LocalizationSwitch()
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.theme,
                  style: CustomTextStyles.style18w500Black
                      .copyWith(color: AppColors.mainColor, fontSize: 20),
                ),
                Switch(
                  value: themeSwitchValue,
                  onChanged: (value) {
                    themeSwitchValue = !themeSwitchValue;
                    context.read<ThemeProvider>().changeAppTheme();
                    context.read<ThemeProvider>().themeMode == ThemeMode.light
                        ? themeSwitchValue = false
                        : themeSwitchValue = true;
                    setState(() {});
                  },
                  thumbIcon: themeSwitchValue
                      ? WidgetStatePropertyAll(Icon(
                          Icons.dark_mode_rounded,
                          size: 24,
                          color: AppColors.mainColor,
                        ))
                      : WidgetStatePropertyAll(Icon(
                          Icons.light_mode_rounded,
                          size: 24,
                          color: AppColors.mainColor,
                        )),
                  thumbColor: WidgetStatePropertyAll(
                      context.read<ThemeProvider>().themeMode == ThemeMode.light
                          ? AppColors.secLightColor
                          : AppColors.secDarkColor),
                  trackColor: WidgetStatePropertyAll(Colors.transparent),
                  trackOutlineColor:
                      WidgetStatePropertyAll(AppColors.mainColor),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: CustomMainButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(OnboardingScreen2.routeName);
                  },
                  buttonTitle: AppLocalizations.of(context)!.letsStart),
            )
          ],
        ),
      ),
    );
  }
}
