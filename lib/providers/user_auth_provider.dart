import 'package:evently/common/services/firebase_services.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserAuthProvider extends ChangeNotifier {
  UserModel? userModel;
  bool loading = false;

  Future<String?> userLogin(
      {required String email,
      required String password,
      required BuildContext context}) async {
    loading = true;
    notifyListeners();
    try {
      userModel =
          await FirebaseServices.loginUser(email: email, password: password);
      loading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      loading = false;
      notifyListeners();
      String errorMessage = getMessageFromErrorCode(e, context);
      return errorMessage;
    } on FirebaseException catch (e) {
      loading = false;
      notifyListeners();
      return e.message;
    } catch (e) {
      loading = false;
      notifyListeners();
      return e.toString();
    }
    return null;
  }

  Future<String?> userSignup(
      {required String email,
      required String password,
      required String name,
      required BuildContext context}) async {
    loading = true;
    notifyListeners();
    try {
      userModel = await FirebaseServices.registerUser(
          email: email, password: password, name: name);
    } on FirebaseAuthException catch (e) {
      loading = false;
      notifyListeners();
      String errorMessage = getMessageFromErrorCode(e, context);
      return errorMessage;
    } on FirebaseException catch (e) {
      loading = false;
      notifyListeners();
      return e.message;
    } catch (e) {
      loading = false;
      notifyListeners();
      return e.toString();
    }
    return null;
  }

  Future<void> getUser() async {
    userModel = await FirebaseServices.getUserInfo(
        FirebaseAuth.instance.currentUser!.uid);
    notifyListeners();
  }

  String getMessageFromErrorCode(
      FirebaseAuthException e, BuildContext context) {
    switch (e.code) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return AppLocalizations.of(context)!.emailAlreadyUsedGoToLoginPage;
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return AppLocalizations.of(context)!.wrongEmailPasswordCombination;
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return AppLocalizations.of(context)!.noUserFoundWithThisEmail;
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return AppLocalizations.of(context)!.userDisabled;
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        return AppLocalizations.of(context)!
            .tooManyRequestsToLogIntoThisAccount;
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        return AppLocalizations.of(context)!.serverErrorPleaseTryAgainLater;
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return AppLocalizations.of(context)!.emailAddressIsInvalid;
      default:
        return AppLocalizations.of(context)!.loginFailedPleaseTryAgain;
    }
  }
}
