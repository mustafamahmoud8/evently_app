import 'package:evently/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthTextField extends StatefulWidget {
  final String? prefixIcon;
  final String? hintText;
  final bool? isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const AuthTextField(
      {super.key,
      this.hintText,
      this.prefixIcon,
      this.isPassword,
      this.controller,
      this.validator});

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late bool isObscure = widget.isPassword ?? false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      cursorColor: Theme.of(context).splashColor,
      obscureText: isObscure,
      style: Theme.of(context).textTheme.labelMedium,
      decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(16),
            child: SvgPicture.asset(
              widget.prefixIcon ?? '',
              colorFilter: ColorFilter.mode(
                  Theme.of(context).shadowColor, BlendMode.srcIn),
            ),
          ),
          prefixIconColor: Theme.of(context).shadowColor,
          suffixIcon: widget.isPassword == true
              ? GestureDetector(
                  onTap: () {
                    isObscure = !isObscure;
                    setState(() {});
                  },
                  child: isObscure
                      ? Icon(Icons.visibility_off_outlined)
                      : Icon(Icons.visibility_outlined))
              : null,
          suffixIconColor: Theme.of(context).shadowColor,
          hintText: widget.hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(color: Theme.of(context).shadowColor),
          border: customBorder(),
          enabledBorder: customBorder(),
          focusedBorder: customBorder(focusColor: AppColors.mainColor),
          errorBorder: customBorder(errorColor: AppColors.red),
          focusedErrorBorder: customBorder(errorColor: AppColors.red)),
    );
  }

  OutlineInputBorder customBorder({Color? focusColor, Color? errorColor}) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
            color: focusColor ?? errorColor ?? Theme.of(context).hoverColor));
  }
}
