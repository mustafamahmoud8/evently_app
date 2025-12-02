import 'package:evently/auth/screens/forget_password_screen.dart';
import 'package:evently/auth/screens/login_screen.dart';
import 'package:evently/auth/screens/signup_screen.dart';
import 'package:evently/common/app_constants.dart';
import 'package:evently/common/app_prefs.dart';
import 'package:evently/common/app_themes.dart';
import 'package:evently/common/services/fcm_services.dart';
import 'package:evently/events/screens/create_event_screen.dart';
import 'package:evently/events/screens/edit_event_screen.dart';
import 'package:evently/events/screens/pick_location_screen.dart';
import 'package:evently/home/screens/home_screen.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/event_data_model.dart';
import 'package:evently/onboarding/screens/onboarding_screen_1.dart';
import 'package:evently/onboarding/screens/onboarding_screen_2.dart';
import 'package:evently/providers/create_event_screen_provider.dart';
import 'package:evently/providers/localization_provider.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/providers/user_auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'events/screens/event_details_screen.dart';
import 'events/screens/pick_location_screen_for_edit_event.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FCMServices.init();
  await AppPrefs.init();
  //caching localization(shared preference)
  final localizationProvider = LocalizationProvider();
  await localizationProvider.localizationGetBool();
  //caching theme(shared preference)
  final themeProvider = ThemeProvider();
  await themeProvider.themeGetBool();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ThemeProvider>.value(value: themeProvider),
    ChangeNotifierProvider<LocalizationProvider>.value(
        value: localizationProvider),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('ar'), // Arabic
      ],
      debugShowCheckedModeBanner: false,
      locale: Locale(context.watch<LocalizationProvider>().appLocalization),
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: context.watch<ThemeProvider>().themeMode,
      routes: {
        LoginScreen.routeName: (_) => ChangeNotifierProvider(
            create: (context) => UserAuthProvider(), child: LoginScreen()),
        SignupScreen.routeName: (_) => ChangeNotifierProvider(
            create: (context) => UserAuthProvider(), child: SignupScreen()),
        ForgetPasswordScreen.routeName: (_) => ForgetPasswordScreen(),
        HomeScreen.routeName: (_) => ChangeNotifierProvider(
            create: (context) => UserAuthProvider(), child: HomeScreen()),
        CreateEventScreen.routeName: (_) =>
            ChangeNotifierProvider<CreateEventScreenProvider>(
                create: (context) => CreateEventScreenProvider(),
                child: CreateEventScreen()),
        OnboardingScreen1.routeName: (_) => OnboardingScreen1(),
        OnboardingScreen2.routeName: (_) => OnboardingScreen2(),
        EventDetailsScreen.routeName: (_) =>
            ChangeNotifierProvider<CreateEventScreenProvider>(
                create: (context) => CreateEventScreenProvider(),
                child: EventDetailsScreen()),
        EditEventScreen.routeName: (_) =>
            ChangeNotifierProvider<CreateEventScreenProvider>(
                create: (context) => CreateEventScreenProvider(),
                child: EditEventScreen()),
        PickLocationScreen.routeName: (context) {
          CreateEventScreenProvider provider = ModalRoute.of(context)!
              .settings
              .arguments as CreateEventScreenProvider;
          return PickLocationScreen(
            provider: provider,
          );
        },
        PickLocationScreenForEditEvent.routeName: (context) {
          Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
          CreateEventScreenProvider provider = arguments['provider'];
          EventDataModel eventDataModel = arguments['eventDataModel'];
          return PickLocationScreenForEditEvent(
            provider: provider,
            eventDataModel: eventDataModel,
          );
        },
      },
      initialRoute:
          AppPrefs.onboardingGetBool(AppConstants.onboardingKey) == null
              ? OnboardingScreen1.routeName
              : FirebaseAuth.instance.currentUser != null
                  ? HomeScreen.routeName
                  : LoginScreen.routeName,
    );
  }
}
