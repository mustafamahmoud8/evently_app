import 'package:evently/auth/screens/login_screen.dart';
import 'package:evently/common/app_colors.dart';
import 'package:evently/common/custom_text_styles.dart';
import 'package:evently/common/services/firebase_services.dart';
import 'package:evently/home/tabs/profile_tab/widgets/custom_drop_down_button.dart';
import 'package:evently/home/tabs/profile_tab/widgets/custom_drop_down_menu.dart';
import 'package:evently/home/tabs/profile_tab/widgets/profile_tab_header.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/localization_provider.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileTabHeader(),
        Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Text(
            AppLocalizations.of(context)!.language,
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: CustomDropDownButton(
            item1Text: AppLocalizations.of(context)!.arabic,
            item2Text: AppLocalizations.of(context)!.english,
            onChanged: (value) {
              if (value == 'ar') {
                context.read<LocalizationProvider>().changeLocalization();
              } else if (value == 'en') {
                context.read<LocalizationProvider>().changeLocalization();
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Text(
            AppLocalizations.of(context)!.theme,
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: CustomDropDownMenu(),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
          child: FilledButton(
            onPressed: () async {
              await FirebaseServices.signOut();
              if (mounted) {
                Navigator.of(context)
                    .pushReplacementNamed(LoginScreen.routeName);
              }
            },
            style: FilledButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: AppColors.red,
                padding: EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16))),
            child: Row(
              children: [
                Icon(
                  Icons.exit_to_app_rounded,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  AppLocalizations.of(context)!.logout,
                  style: CustomTextStyles.style18w400Black
                      .copyWith(color: Colors.white, fontSize: 20),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
