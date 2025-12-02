import 'package:evently/common/app_colors.dart';
import 'package:evently/common/app_constants.dart';
import 'package:evently/onboarding/pageview_pages/page1.dart';
import 'package:evently/onboarding/pageview_pages/page2.dart';
import 'package:evently/onboarding/pageview_pages/page3.dart';
import 'package:evently/providers/localization_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../auth/screens/login_screen.dart';
import '../../common/app_assets.dart';
import '../../common/app_prefs.dart';
import '../../home/screens/home_screen.dart';

class OnboardingScreen2 extends StatefulWidget {
  static const String routeName = '/OnboardingScreen2';

  const OnboardingScreen2({super.key});

  @override
  State<OnboardingScreen2> createState() => _OnboardingScreen2State();
}

class _OnboardingScreen2State extends State<OnboardingScreen2> {
  List<Widget> pages = [Page1(), Page2(), Page3()];
  int index = 0;
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox.shrink(),
        title: Image.asset(
          AppImages.onboardingLogo,
          height: 50,
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    itemBuilder: (context, index) => pages[index],
                    itemCount: pages.length,
                    onPageChanged: (index) {
                      this.index = index;
                      setState(() {});
                    },
                    controller: controller,
                  ),
                ),
              ],
            ),
          ),
          index == 0
              ? SizedBox.shrink()
              : Positioned(
                  left: context.watch<LocalizationProvider>().appLocalization ==
                          'en'
                      ? 16
                      : null,
                  bottom: 12,
                  right:
                      context.watch<LocalizationProvider>().appLocalization ==
                              'en'
                          ? null
                          : 16,
                  child: GestureDetector(
                    onTap: () {
                      controller.previousPage(
                          duration: Duration(seconds: 1),
                          curve: Curves.easeInOut);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.mainColor),
                          shape: BoxShape.circle),
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: AppColors.mainColor,
                      ),
                    ),
                  ),
                ),
          Positioned(
            right: width * 0.425,
            bottom: 30,
            child: SmoothPageIndicator(
              controller: controller,
              count: pages.length,
              effect: ExpandingDotsEffect(
                activeDotColor: AppColors.mainColor,
                dotColor: Theme.of(context).textTheme.labelMedium!.color!,
                dotHeight: height * 0.0095,
                dotWidth: width * 0.02,
              ),
            ),
          ),
          Positioned(
            right: context.watch<LocalizationProvider>().appLocalization == 'en'
                ? 16
                : null,
            bottom: 12,
            left: context.watch<LocalizationProvider>().appLocalization == 'en'
                ? null
                : 16,
            child: GestureDetector(
              onTap: () async {
                if (index == 2) {
                  AppPrefs.onboardingSetBool(AppConstants.onboardingKey, true);
                  Navigator.of(context).pushReplacementNamed(
                      FirebaseAuth.instance.currentUser != null
                          ? HomeScreen.routeName
                          : LoginScreen.routeName);
                } else {
                  controller.nextPage(
                      duration: Duration(seconds: 1), curve: Curves.easeInOut);
                }
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.mainColor),
                    shape: BoxShape.circle),
                child: Icon(
                  Icons.arrow_forward_rounded,
                  color: AppColors.mainColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
