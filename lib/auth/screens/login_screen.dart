import 'package:evently/auth/screens/forget_password_screen.dart';
import 'package:evently/auth/screens/signup_screen.dart';
import 'package:evently/auth/widgets/auth_text_field.dart';
import 'package:evently/common/app_assets.dart';
import 'package:evently/common/app_colors.dart';
import 'package:evently/common/custom_text_styles.dart';
import 'package:evently/common/services/firebase_services.dart';
import 'package:evently/common/widgets/custom_main_button.dart';
import 'package:evently/common/widgets/custom_main_outlined_button.dart';
import 'package:evently/common/widgets/localization_switch.dart';
import 'package:evently/home/screens/home_screen.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/user_auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/loginScreen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(ForgetPasswordScreen.routeName);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.forgetPassword1,
                        style: CustomTextStyles.style16w700Black.copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.mainColor,
                            color: AppColors.mainColor,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: context.watch<UserAuthProvider>().loading
                        ? SizedBox(
                            height: 56,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : CustomMainButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                context
                                    .read<UserAuthProvider>()
                                    .userLogin(
                                        email: emailController!.text.trim(),
                                        password: passwordController!.text,
                                        context: context)
                                    .then(
                                  (value) {
                                    if (value == null) {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              HomeScreen.routeName);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                          AppLocalizations.of(context)!
                                              .userLoggedInSuccessfully(context
                                                      .read<UserAuthProvider>()
                                                      .userModel
                                                      ?.name ??
                                                  ''),
                                          style:
                                              CustomTextStyles.style18w500White,
                                        ),
                                        backgroundColor: Colors.green,
                                        duration: Duration(seconds: 5),
                                        showCloseIcon: true,
                                      ));
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
                            buttonTitle: AppLocalizations.of(context)!.login),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text:
                                AppLocalizations.of(context)!.doNotHaveAccount,
                            style: Theme.of(context).textTheme.labelMedium),
                        TextSpan(
                          text: AppLocalizations.of(context)!.createAccount,
                          style: CustomTextStyles.style16w700Black.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.mainColor,
                              color: AppColors.mainColor,
                              fontStyle: FontStyle.italic),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context)
                                  .pushNamed(SignupScreen.routeName);
                            },
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            AppLocalizations.of(context)!.or,
                            style: CustomTextStyles.style16w500Black
                                .copyWith(color: AppColors.mainColor),
                          ),
                        ),
                        Expanded(child: Divider())
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: CustomMainOutlinedButton(
                      onPressed: () async {
                        try {
                          final user =
                              await FirebaseServices.signInWithGoogle();
                          if (user != null) {
                            //ignore: use_build_context_synchronously
                            Navigator.of(context)
                                .pushReplacementNamed(HomeScreen.routeName);
                          }
                        } on FirebaseAuthException catch (error) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  error.message ?? 'Something went wrong')));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())));
                        }
                      },
                      buttonTitle:
                          AppLocalizations.of(context)!.loginWithGoogle,
                      icon: SvgPicture.asset(AppImages.googleIcon),
                    ),
                  ),
                  LocalizationSwitch()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
