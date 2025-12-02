import 'package:flutter/material.dart';

import '../app_colors.dart';

class CustomMainOutlinedButton extends StatelessWidget {
  final void Function() onPressed;
  final String buttonTitle;
  final Widget? icon;

  const CustomMainOutlinedButton(
      {super.key,
      required this.onPressed,
      required this.buttonTitle,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: BorderSide(color: AppColors.mainColor),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16))),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: icon??SizedBox.shrink(),
            ),
            Text(
              buttonTitle,
              style: TextStyle(
                  color: AppColors.mainColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
