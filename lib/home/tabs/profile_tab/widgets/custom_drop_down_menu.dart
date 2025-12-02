import 'package:evently/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/custom_text_styles.dart';
import '../../../../providers/theme_provider.dart';

class CustomDropDownMenu extends StatefulWidget {
  const CustomDropDownMenu({super.key});

  @override
  State<CustomDropDownMenu> createState() => _CustomDropDownMenuState();
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return DropdownMenu<ThemeMode>(
      menuHeight: height,
      width: width - 30,
      hintText: context.watch<ThemeProvider>().themeMode == ThemeMode.light
          ? AppLocalizations.of(context)!.light
          : AppLocalizations.of(context)!.dark,
      onSelected: (value) {
        if (value == ThemeMode.light) {
          context.read<ThemeProvider>().changeAppTheme();
        } else if (value == ThemeMode.dark) {
          context.read<ThemeProvider>().changeAppTheme();
        }
      },
      trailingIcon: Icon(
        Icons.arrow_drop_down_rounded,
        size: 40,
        color: AppColors.mainColor,
      ),
      selectedTrailingIcon: Icon(
        Icons.arrow_drop_up_rounded,
        size: 40,
        color: AppColors.mainColor,
      ),
      textStyle: CustomTextStyles.style18w700Black
          .copyWith(color: AppColors.mainColor, fontSize: 20),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: CustomTextStyles.style18w700Black
            .copyWith(color: AppColors.mainColor, fontSize: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.mainColor, width: 1.5),
        ),
      ),
      menuStyle: MenuStyle(
        padding: WidgetStatePropertyAll(EdgeInsets.zero),
        backgroundColor: WidgetStatePropertyAll(Theme.of(context).splashColor),
        shadowColor: WidgetStatePropertyAll(Colors.black),
        surfaceTintColor: WidgetStatePropertyAll(Theme.of(context).splashColor),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: AppColors.mainColor, width: 1.5)),
        ),
      ),
      dropdownMenuEntries: [
        DropdownMenuEntry(
          value: ThemeMode.light,
          label: AppLocalizations.of(context)!.light,
          style: ButtonStyle(
            backgroundColor:
                WidgetStatePropertyAll(Theme.of(context).splashColor),
            foregroundColor: WidgetStatePropertyAll(AppColors.mainColor),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            textStyle: WidgetStatePropertyAll(
              CustomTextStyles.style18w700Black
                  .copyWith(color: AppColors.mainColor, fontSize: 20),
            ),
          ),
        ),
        DropdownMenuEntry(
          value: ThemeMode.dark,
          label: AppLocalizations.of(context)!.dark,
          style: ButtonStyle(
            backgroundColor:
                WidgetStatePropertyAll(Theme.of(context).splashColor),
            foregroundColor: WidgetStatePropertyAll(AppColors.mainColor),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            textStyle: WidgetStatePropertyAll(
              CustomTextStyles.style18w700Black
                  .copyWith(color: AppColors.mainColor, fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}
