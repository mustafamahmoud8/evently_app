import 'package:evently/l10n/app_localizations.dart';

import 'package:flutter/material.dart';

import '../../common/app_colors.dart';
import '../../common/custom_text_styles.dart';


class CustomTextField extends StatelessWidget {
  final String title;
  final String? hintText;
  final TextEditingController controller;
  final Widget? prefixIcon;
  final int maxLines;
  final FocusNode? focusNode;

  const CustomTextField(
      {super.key,
      required this.title,
      required this.controller,
      this.prefixIcon,
      this.maxLines = 1,
      this.hintText,
      required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),

          validator: (value) => value == null || value.isEmpty
              ? AppLocalizations.of(context)!.theFieldCanNotBeEmpty
              : null,
          maxLines: maxLines,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide:
                    BorderSide(color: Theme.of(context).hoverColor, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide:
                    BorderSide(color: Theme.of(context).primaryColor, width: 1),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: AppColors.red, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: AppColors.red, width: 1),
              ),
              focusColor: Theme.of(context).primaryColor,
              hintText: hintText,
              hintStyle: CustomTextStyles.style16w500Black.copyWith(
                  color: focusNode?.hasFocus == true

                      ? AppColors.mainColor
                      : Theme.of(context).shadowColor),
              prefixIcon: prefixIcon),
        )
      ],
    );
  }
}
