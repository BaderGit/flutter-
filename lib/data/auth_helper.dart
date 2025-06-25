import 'dart:developer';

// import 'package:final_project/utils/app_router.dart';

import 'package:final_project/l10n/app_localizations.dart';
import 'package:final_project/utils/custom_dialog.dart';

import 'package:firebase_auth/firebase_auth.dart';

class AuthHelper {
  AuthHelper._();
  static AuthHelper authHelper = AuthHelper._();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential?> signIn(
    String emailAddress,
    String password,
    AppLocalizations localizations,
  ) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CustomShowDialog.showDialogFunction(
          localizations.userNotFound,
          localizations,
        );
      } else if (e.code == 'wrong-password') {
        CustomShowDialog.showDialogFunction(
          localizations.wrongPassword,
          localizations,
        );
      }
    }
    return null;
  }

  String? getUserId() {
    return firebaseAuth.currentUser?.uid;
  }

  Future<User?> checkUser() async {
    User? user = firebaseAuth.currentUser;
    return user;
  }

  // ignore: body_might_complete_normally_nullable
  Future<UserCredential?> signUp(
    String emailAddress,
    String password,
    AppLocalizations localization,
  ) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CustomShowDialog.showDialogFunction(
          localization.weakPassword,
          localization,
        );
      } else if (e.code == 'email-already-in-use') {
        CustomShowDialog.showDialogFunction(
          localization.emailInUse,
          localization,
        );
      }
    } catch (e) {
      log(e.toString());
    }
  }

  signOut() async {
    await firebaseAuth.signOut();
  }

  forgetPassword(String email, AppLocalizations loc) async {
    try {
      await firebaseAuth.setLanguageCode("en");
      await firebaseAuth.sendPasswordResetEmail(email: "baderahed21@gmail.com");
    } catch (e) {
      CustomShowDialog.showDialogFunction(e.toString(), loc);
    }
  }
}
