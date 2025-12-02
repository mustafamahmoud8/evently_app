import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @onboarding1Text1.
  ///
  /// In en, this message translates to:
  /// **'Personalize Your Experience'**
  String get onboarding1Text1;

  /// No description provided for @onboarding1Text2.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.'**
  String get onboarding1Text2;

  /// No description provided for @onboarding2Text1.
  ///
  /// In en, this message translates to:
  /// **'Find Events That Inspire You'**
  String get onboarding2Text1;

  /// No description provided for @onboarding2Text2.
  ///
  /// In en, this message translates to:
  /// **'Dive into a world of events crafted to fit your unique interests. Whether you\'re into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.'**
  String get onboarding2Text2;

  /// No description provided for @onboarding3Text1.
  ///
  /// In en, this message translates to:
  /// **'Effortless Event Planning'**
  String get onboarding3Text1;

  /// No description provided for @onboarding3Text2.
  ///
  /// In en, this message translates to:
  /// **'Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.'**
  String get onboarding3Text2;

  /// No description provided for @onboarding4Text1.
  ///
  /// In en, this message translates to:
  /// **'Connect with Friends & Share Moments'**
  String get onboarding4Text1;

  /// No description provided for @onboarding4Text2.
  ///
  /// In en, this message translates to:
  /// **'Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.'**
  String get onboarding4Text2;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @letsStart.
  ///
  /// In en, this message translates to:
  /// **'Let’s Start'**
  String get letsStart;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgetPassword1.
  ///
  /// In en, this message translates to:
  /// **'Forget Password?'**
  String get forgetPassword1;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @doNotHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don’t Have Account ? '**
  String get doNotHaveAccount;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get or;

  /// No description provided for @loginWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Login With Google'**
  String get loginWithGoogle;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @rePassword.
  ///
  /// In en, this message translates to:
  /// **'Re Password'**
  String get rePassword;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already Have Account ? '**
  String get alreadyHaveAccount;

  /// No description provided for @forgetPassword2.
  ///
  /// In en, this message translates to:
  /// **'Forget Password'**
  String get forgetPassword2;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @theFieldCanNotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'The field can not be empty'**
  String get theFieldCanNotBeEmpty;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid Email'**
  String get invalidEmail;

  /// No description provided for @userLoggedInSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'User {userName} logged in Successfully'**
  String userLoggedInSuccessfully(Object userName);

  /// No description provided for @thisFieldMustBeTheSameAsThePasswordField.
  ///
  /// In en, this message translates to:
  /// **'This field must be the same as the password field'**
  String get thisFieldMustBeTheSameAsThePasswordField;

  /// No description provided for @userRegesteredSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'User Regestered Successfully'**
  String get userRegesteredSuccessfully;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back ✨'**
  String get welcomeBack;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @sport.
  ///
  /// In en, this message translates to:
  /// **'Sport'**
  String get sport;

  /// No description provided for @birthday.
  ///
  /// In en, this message translates to:
  /// **'Birthday'**
  String get birthday;

  /// No description provided for @bookClub.
  ///
  /// In en, this message translates to:
  /// **'Book Club'**
  String get bookClub;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @map.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get map;

  /// No description provided for @love.
  ///
  /// In en, this message translates to:
  /// **'Love'**
  String get love;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @searchForEvent.
  ///
  /// In en, this message translates to:
  /// **'Search for Event'**
  String get searchForEvent;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose Language'**
  String get chooseLanguage;

  /// No description provided for @chooseTheme.
  ///
  /// In en, this message translates to:
  /// **'Choose Theme'**
  String get chooseTheme;

  /// No description provided for @createEvent.
  ///
  /// In en, this message translates to:
  /// **'Create Event'**
  String get createEvent;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @eventTitle.
  ///
  /// In en, this message translates to:
  /// **'Event Title'**
  String get eventTitle;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @eventDescription.
  ///
  /// In en, this message translates to:
  /// **'Event Description'**
  String get eventDescription;

  /// No description provided for @eventDate.
  ///
  /// In en, this message translates to:
  /// **'Event Date'**
  String get eventDate;

  /// No description provided for @chooseDate.
  ///
  /// In en, this message translates to:
  /// **'Choose Date'**
  String get chooseDate;

  /// No description provided for @eventTime.
  ///
  /// In en, this message translates to:
  /// **'Event Time'**
  String get eventTime;

  /// No description provided for @chooseTime.
  ///
  /// In en, this message translates to:
  /// **'Choose Time'**
  String get chooseTime;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @chooseEventLocation.
  ///
  /// In en, this message translates to:
  /// **'Choose Event Location'**
  String get chooseEventLocation;

  /// No description provided for @addEvent.
  ///
  /// In en, this message translates to:
  /// **'Add Event'**
  String get addEvent;

  /// No description provided for @tapOnLocationToSelect.
  ///
  /// In en, this message translates to:
  /// **'Tap on Location To Select'**
  String get tapOnLocationToSelect;

  /// No description provided for @eventDetails.
  ///
  /// In en, this message translates to:
  /// **'Event Details'**
  String get eventDetails;

  /// No description provided for @editEvent.
  ///
  /// In en, this message translates to:
  /// **'Edit Event'**
  String get editEvent;

  /// No description provided for @updateEvent.
  ///
  /// In en, this message translates to:
  /// **'Update Event'**
  String get updateEvent;

  /// No description provided for @theEventIsAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'The Event IS Added Successfully'**
  String get theEventIsAddedSuccessfully;

  /// No description provided for @theDateOrTimeIsMissing.
  ///
  /// In en, this message translates to:
  /// **'The Date or Time is missing'**
  String get theDateOrTimeIsMissing;

  /// No description provided for @theEventIsEditedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'The Event Is Edited Successfully'**
  String get theEventIsEditedSuccessfully;

  /// No description provided for @theEventIsDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'The Event Is Deleted Successfully'**
  String get theEventIsDeletedSuccessfully;

  /// No description provided for @emailAlreadyUsedGoToLoginPage.
  ///
  /// In en, this message translates to:
  /// **'Email already used. Go to login page.'**
  String get emailAlreadyUsedGoToLoginPage;

  /// No description provided for @wrongEmailPasswordCombination.
  ///
  /// In en, this message translates to:
  /// **'Wrong email/password combination.'**
  String get wrongEmailPasswordCombination;

  /// No description provided for @noUserFoundWithThisEmail.
  ///
  /// In en, this message translates to:
  /// **'No user found with this email.'**
  String get noUserFoundWithThisEmail;

  /// No description provided for @userDisabled.
  ///
  /// In en, this message translates to:
  /// **'User disabled.'**
  String get userDisabled;

  /// No description provided for @tooManyRequestsToLogIntoThisAccount.
  ///
  /// In en, this message translates to:
  /// **'Too many requests to log into this account.'**
  String get tooManyRequestsToLogIntoThisAccount;

  /// No description provided for @serverErrorPleaseTryAgainLater.
  ///
  /// In en, this message translates to:
  /// **'Server error, please try again later.'**
  String get serverErrorPleaseTryAgainLater;

  /// No description provided for @emailAddressIsInvalid.
  ///
  /// In en, this message translates to:
  /// **'Email address is invalid.'**
  String get emailAddressIsInvalid;

  /// No description provided for @loginFailedPleaseTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Login failed. Please try again.'**
  String get loginFailedPleaseTryAgain;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
