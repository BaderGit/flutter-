import 'dart:developer';

// import 'package:final_project/utils/app_router.dart';

import 'package:final_project/utils/custom_dialog.dart';

import 'package:firebase_auth/firebase_auth.dart';

class AuthHelper {
  AuthHelper._();
  static AuthHelper authHelper = AuthHelper._();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential?> signIn(String emailAddress, String password) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CustomShowDialog.showDialogFunction("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        CustomShowDialog.showDialogFunction(
          "Wrong password provided for that user.",
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
  Future<UserCredential?> signUp(String emailAddress, String password) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CustomShowDialog.showDialogFunction(
          "The password provided is too weak.",
        );
      } else if (e.code == 'email-already-in-use') {
        CustomShowDialog.showDialogFunction("email-already-in-use");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  signOut() async {
    await firebaseAuth.signOut();
  }

  forgetPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      CustomShowDialog.showDialogFunction("request was sent to ur email");
    } catch (e) {
      log(e.toString());
    }
  }
}
