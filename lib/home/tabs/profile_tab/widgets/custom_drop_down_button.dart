import 'package:evently/providers/localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/custom_text_styles.dart';

class CustomDropDownButton extends StatefulWidget {
  final String item1Text;
  final String item2Text;
  final void Function(String value) onChanged;

  const CustomDropDownButton(
      {super.key,
      required this.item1Text,
      required this.item2Text,
      required this.onChanged});

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.mainColor, width: 1.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: DropdownButton<String>(
        value: context.watch<LocalizationProvider>().appLocalization == 'ar'
            ? 'ar'
            : 'en',
        style: CustomTextStyles.style18w700Black
            .copyWith(color: AppColors.mainColor, fontSize: 20),
        dropdownColor: Theme.of(context).splashColor,
        borderRadius: BorderRadius.circular(16),
        icon: Icon(
          Icons.arrow_drop_down_rounded,
          color: AppColors.mainColor,
        ),
        iconSize: 40,
        isExpanded: true,
        underline: SizedBox.shrink(),
        items: [
          DropdownMenuItem(
            value: 'ar',
            child: Text(widget.item1Text),
          ),
          DropdownMenuItem(
            value: 'en',
            child: Text(widget.item2Text),
          )
        ],
        onChanged: (value) => widget.onChanged(value ?? ''),
      ),
    );
  }
}
