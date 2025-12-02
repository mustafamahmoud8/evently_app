import 'package:evently/common/app_colors.dart';
import 'package:flutter/material.dart';

class CustomMainButton extends StatelessWidget {
  final void Function() onPressed;
  final String buttonTitle;

  const CustomMainButton(
      {super.key, required this.onPressed, required this.buttonTitle});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FilledButton(
        style: FilledButton.styleFrom(
            backgroundColor: (AppColors.mainColor),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16))),
        onPressed: onPressed,
        child: Text(
          buttonTitle,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
