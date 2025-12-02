import 'package:evently/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/app_assets.dart';
import '../../common/app_colors.dart';
import '../../common/custom_text_styles.dart';
import '../../providers/theme_provider.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 30),
          child: Image.asset(
            context.read<ThemeProvider>().themeMode == ThemeMode.light
                ? AppImages.onboardingScreen2Page2ImageLight
                : AppImages.onboardingScreen2Page2ImageDark,
            height: height * 0.42,
            width: width * 0.91,
          ),
        ),
        Text(
          AppLocalizations.of(context)!.onboarding3Text1,
          style: CustomTextStyles.style18w700Black
              .copyWith(color: AppColors.mainColor, fontSize: 20),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Text(
            AppLocalizations.of(context)!.onboarding3Text2,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        )
      ],
    );
  }
}
