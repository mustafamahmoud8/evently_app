import 'package:evently/home/screens/home_screen.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/user_auth_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/app_assets.dart';
import '../../common/app_colors.dart';
import '../../common/custom_text_styles.dart';
import '../../common/widgets/custom_main_button.dart';
import '../../common/widgets/localization_switch.dart';
import '../widgets/auth_text_field.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signupScreen';

  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController? emailController = TextEditingController();
  TextEditingController? nameController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  TextEditingController? rePasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).dividerColor,
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.register,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).dividerColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Image.asset(
                    AppImages.splashScreenLogo,
                    height: height * 0.22,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: AuthTextField(
                    controller: nameController,
                    validator: (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return AppLocalizations.of(context)!
                            .theFieldCanNotBeEmpty;
                      } else {
                        return null;
                      }
                    },
                    prefixIcon: AppImages.personIcon,
                    hintText: AppLocalizations.of(context)!.name,
                  ),
                ),
                AuthTextField(
                  controller: emailController,
                  validator: (p0) {
                    final RegExp emailRegex = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+@"
                        r"[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?"
                        r"(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$");
                    if (p0 == null || p0.isEmpty) {
                      return AppLocalizations.of(context)!
                          .theFieldCanNotBeEmpty;
                    } else if (!emailRegex.hasMatch(p0)) {
                      return AppLocalizations.of(context)!.invalidEmail;
                    } else {
                      return null;
                    }
                  },
                  prefixIcon: AppImages.emailIcon,
                  hintText: AppLocalizations.of(context)!.email,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: AuthTextField(
                    controller: passwordController,
                    validator: (p0) {
                      final RegExp passwordRegex = RegExp(
                          r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
                      if (p0 == null || p0.isEmpty) {
                        return AppLocalizations.of(context)!
                            .theFieldCanNotBeEmpty;
                      } else if (!passwordRegex.hasMatch(p0)) {
                        return AppLocalizations.of(context)!.invalidEmail;
                      } else {
                        return null;
                      }
                    },
                    prefixIcon: AppImages.passwordIcon,
                    hintText: AppLocalizations.of(context)!.password,
                    isPassword: true,
                  ),
                ),
                AuthTextField(
                  controller: rePasswordController,
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return AppLocalizations.of(context)!
                          .theFieldCanNotBeEmpty;
                    } else if (rePasswordController!.text !=
                        passwordController!.text) {
                      return AppLocalizations.of(context)!
                          .thisFieldMustBeTheSameAsThePasswordField;
                    } else {
                      return null;
                    }
                  },
                  prefixIcon: AppImages.passwordIcon,
                  hintText: AppLocalizations.of(context)!.rePassword,
                  isPassword: true,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: context.watch<UserAuthProvider>().loading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : CustomMainButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              context
                                  .read<UserAuthProvider>()
                                  .userSignup(
                                      email: emailController!.text.trim(),
                                      password: passwordController!.text,
                                      name: nameController!.text,
                                      context: context)
                                  .then(
                                (value) {
                                  if (value == null) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                        AppLocalizations.of(context)!
                                            .userRegesteredSuccessfully,
                                        style:
                                            CustomTextStyles.style18w500White,
                                      ),
                                      backgroundColor: Colors.green,
                                      duration: Duration(seconds: 5),
                                      showCloseIcon: true,
                                    ));
                                    Navigator.of(context).pushReplacementNamed(
                                        HomeScreen.routeName); //
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                        value,
                                        style:
                                            CustomTextStyles.style18w500White,
                                      ),
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 5),
                                      showCloseIcon: true,
                                    ));
                                  }
                                },
                              );
                            }
                          },
                          buttonTitle:
                              AppLocalizations.of(context)!.createAccount),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text:
                              AppLocalizations.of(context)!.alreadyHaveAccount,
                          style: Theme.of(context).textTheme.labelMedium),
                      TextSpan(
                        text: AppLocalizations.of(context)!.login,
                        style: CustomTextStyles.style16w700Black.copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.mainColor,
                            color: AppColors.mainColor,
                            fontStyle: FontStyle.italic),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pop();
                          },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: LocalizationSwitch(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
