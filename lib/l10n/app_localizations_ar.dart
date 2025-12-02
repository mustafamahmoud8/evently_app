// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get onboarding1Text1 => 'إضفاء الطابع الشخصي على تجربتك';

  @override
  String get onboarding1Text2 => 'اختر السمة واللغة المفضلة لديك للبدء بتجربة مريحة ومصممة خصيصًا لتناسب أسلوبك.';

  @override
  String get onboarding2Text1 => 'ابحث عن الأحداث التي تلهمك';

  @override
  String get onboarding2Text2 => 'انغمس في عالم من الفعاليات المصممة خصيصًا لتناسب اهتماماتك الفريدة. سواء كنت من محبي الموسيقى الحية، أو ورش العمل الفنية، أو التواصل المهني، أو حتى اكتشاف تجارب جديدة، فلدينا ما يناسبك. ستساعدك توصياتنا المختارة على الاستكشاف والتواصل والاستفادة القصوى من كل فرصة متاحة أمامك.';

  @override
  String get onboarding3Text1 => 'تخطيط الأحداث بسهولة';

  @override
  String get onboarding3Text2 => 'تخلص من عناء تنظيم فعالياتك مع أدواتنا المتكاملة للتخطيط. من إعداد الدعوات وإدارة الردود، إلى جدولة التذكيرات وتنسيق التفاصيل، نحن نلبي جميع احتياجاتك. خطط بسهولة وركّز على ما يهمك - اصنع تجربة لا تُنسى لك ولضيوفك.';

  @override
  String get onboarding4Text1 => 'تواصل مع الأصدقاء وشارك اللحظات';

  @override
  String get onboarding4Text2 => 'اجعل كل مناسبة لا تُنسى بمشاركة تجربتك مع الآخرين. تتيح لك منصتنا دعوة الأصدقاء، وإبقاء الجميع على اطلاع، والاحتفال باللحظات معًا. صوّر لحظات الإثارة وشاركها مع أصدقائك، لتستعيد لحظاتها المميزة وتعتز بالذكريات.';

  @override
  String get language => 'اللغة';

  @override
  String get theme => 'السمة';

  @override
  String get letsStart => 'لنبدأ';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get forgetPassword1 => 'نسيت كلمة المرور؟';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get doNotHaveAccount => 'ليس لديك حساب ؟ ';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get or => 'أو';

  @override
  String get loginWithGoogle => 'تسجيل الدخول مع جوجل';

  @override
  String get register => 'يسجل';

  @override
  String get name => 'الاسم';

  @override
  String get rePassword => 'إعادة كلمة المرور';

  @override
  String get alreadyHaveAccount => 'هل لديك حساب بالفعل ؟ ';

  @override
  String get forgetPassword2 => 'نسيت كلمة المرور';

  @override
  String get resetPassword => 'إعادة تعيين كلمة المرور';

  @override
  String get theFieldCanNotBeEmpty => 'لا يمكن أن يكون الحقل فارغا';

  @override
  String get invalidEmail => 'البريد الإلكتروني غير صالح';

  @override
  String userLoggedInSuccessfully(Object userName) {
    return 'تم  تسجيل دخول المستخدم $userName بنجاح';
  }

  @override
  String get thisFieldMustBeTheSameAsThePasswordField => 'يجب أن يكون هذا الحقل هو نفسه حقل كلمة المرور';

  @override
  String get userRegesteredSuccessfully => 'تم تسجيل المستخدم بنجاح';

  @override
  String get welcomeBack => 'مرحباً بعودتك ✨';

  @override
  String get all => 'الكل';

  @override
  String get sport => 'رياضة';

  @override
  String get birthday => 'عيد ميلاد';

  @override
  String get bookClub => 'نادي الكتاب';

  @override
  String get home => 'الرئيسية';

  @override
  String get map => 'الخريطة';

  @override
  String get love => 'المفضلة';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get searchForEvent => 'البحث عن الحدث';

  @override
  String get arabic => 'اللغة العربية';

  @override
  String get english => 'اللغة الإنجليزية';

  @override
  String get light => 'فاتح';

  @override
  String get dark => 'مظلم';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get chooseLanguage => 'اختر اللغة';

  @override
  String get chooseTheme => 'اختر السمة';

  @override
  String get createEvent => 'إنشاء حدث';

  @override
  String get title => 'العنوان';

  @override
  String get eventTitle => 'عنوان الحدث';

  @override
  String get description => 'الوصف';

  @override
  String get eventDescription => 'وصف الحدث';

  @override
  String get eventDate => 'تاريخ الحدث';

  @override
  String get chooseDate => 'اختر التاريخ';

  @override
  String get eventTime => 'وقت الحدث';

  @override
  String get chooseTime => 'اختر الوقت';

  @override
  String get location => 'الموقع';

  @override
  String get chooseEventLocation => 'اختر موقع الحدث';

  @override
  String get addEvent => 'أضف حدثًا';

  @override
  String get tapOnLocationToSelect => 'اضغط على الموقع للتحديد';

  @override
  String get eventDetails => 'تفاصيل الحدث';

  @override
  String get editEvent => 'تحرير الحدث';

  @override
  String get updateEvent => 'تحديث الحدث';

  @override
  String get theEventIsAddedSuccessfully => 'تمت إضافة الحدث بنجاح';

  @override
  String get theDateOrTimeIsMissing => 'التاريخ أو الوقت مفقود';

  @override
  String get theEventIsEditedSuccessfully => 'تم تعديل الحدث بنجاح';

  @override
  String get theEventIsDeletedSuccessfully => 'تم حذف الحدث بنجاح';

  @override
  String get emailAlreadyUsedGoToLoginPage => 'تم استخدام البريد الإلكتروني. انتقل إلى صفحة تسجيل الدخول.';

  @override
  String get wrongEmailPasswordCombination => 'مزيج خاطئ من البريد الإلكتروني وكلمة المرور.';

  @override
  String get noUserFoundWithThisEmail => 'لم يتم العثور على مستخدم بهذا البريد الإلكتروني.';

  @override
  String get userDisabled => 'تم تعطيل المستخدم.';

  @override
  String get tooManyRequestsToLogIntoThisAccount => 'هناك الكثير من الطلبات لتسجيل الدخول إلى هذا الحساب.';

  @override
  String get serverErrorPleaseTryAgainLater => 'خطأ في الخادم، يرجى المحاولة مرة أخرى لاحقًا.';

  @override
  String get emailAddressIsInvalid => 'عنوان البريد الإلكتروني غير صالح.';

  @override
  String get loginFailedPleaseTryAgain => 'فشل تسجيل الدخول. يُرجى المحاولة مرة أخرى.';
}
