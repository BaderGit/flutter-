import 'dart:developer';
import 'dart:io';

import 'package:final_project/data/auth_helper.dart';
import 'package:final_project/data/firestore_helper.dart';
import 'package:final_project/data/sp_helper.dart';
import 'package:final_project/data/storage_helper.dart';
import 'package:final_project/main_layout.dart';
import 'package:final_project/models/patient.dart';
import 'package:final_project/models/doctor.dart';
import 'package:final_project/utils/app_router.dart';
import 'package:final_project/utils/custom_dialog.dart';

import 'package:final_project/views/screens/staff/staff_screen.dart';
import 'package:final_project/views/screens/auth/user_type_screen.dart';

// import 'package:final_project/utils/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:string_validator/string_validator.dart';

class AppAuthProvider extends ChangeNotifier {
  String? userType;
  GlobalKey<FormState> loginKey = GlobalKey();
  GlobalKey<FormState> signUpKey = GlobalKey();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController imgUrlController = TextEditingController();

  TextEditingController doctorEmailController = TextEditingController();
  TextEditingController doctorPasswordController = TextEditingController();
  TextEditingController doctorUserNameController = TextEditingController();
  // TextEditingController doctorSpecialityController = TextEditingController();
  TextEditingController doctorImgUrlController = TextEditingController();
  String? selectedSpeciality;

  File? selectedImage;
  bool isLoading = false;

  nullValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'this field is required';
    }
  }

  emailValidation(String? value) {
    nullValidation(value);
    if (!isEmail(value!)) {
      return "incorrect email form";
    }
  }

  passwordValidation(String? value) {
    nullValidation(value);
    if (value!.length < 6) {
      return "password must be 6 digits ";
    }
  }

  Future<UserCredential?> signIn() async {
    if (loginKey.currentState!.validate()) {
      if (userType == "doctor") {
        isLoading = true;
        notifyListeners();
        UserCredential? doctorCredentials = await AuthHelper.authHelper.signIn(
          doctorEmailController.text,
          doctorPasswordController.text,
        );
        doctorPasswordController.text = "";

        if (doctorCredentials != null) {
          isLoading = false;
          notifyListeners();
          AppRouter.navigateToWidgetWithReplacment(MainLayout());
          doctorEmailController.text = "";

          return doctorCredentials;
        }
      } else {
        isLoading = true;
        notifyListeners();
        UserCredential? credentials = await AuthHelper.authHelper.signIn(
          emailController.text,
          passwordController.text,
        );

        passwordController.text = "";
        if (credentials != null) {
          if (userType == "patient") {
            AppRouter.navigateToWidgetWithReplacment(MainLayout());
          } else {
            AppRouter.navigateToWidgetWithReplacment(StaffScreen());
          }

          emailController.text = "";
        }
        isLoading = false;
        notifyListeners();

        return credentials;
      }
      isLoading = false;
      notifyListeners();
      print("is loading after sign in ${isLoading}");
    }

    return null;
  }

  checkUser(String? userType) async {
    User? user;
    user = await AuthHelper.authHelper.checkUser();
    if (user == null) {
      AppRouter.navigateToWidgetWithReplacment(UserTypeScreen());
    } else if (userType == "patient") {
      AppRouter.navigateToWidgetWithReplacment(MainLayout());
    } else if (userType == "doctor") {
      AppRouter.navigateToWidgetWithReplacment(MainLayout());
    } else {
      AppRouter.navigateToWidgetWithReplacment(StaffScreen());
    }
  }

  signOut() {
    AuthHelper.authHelper.signOut();
    AppRouter.navigateToWidgetWithReplacment(UserTypeScreen());
    SpHelper.spHelper.setUserType("");

    emailController.text = "";
  }

  Future<UserCredential?> userSignUp() async {
    if (signUpKey.currentState!.validate()) {
      isLoading = true;
      notifyListeners();
      log("this is $isLoading before adding ");
      UserCredential? credentials = await AuthHelper.authHelper.signUp(
        emailController.text,
        passwordController.text,
      );
      if (credentials != null) {
        String? imageUrl = await StorageHelper.storageHelper.uploadImage(
          selectedImage!,
        );
        PatientModel patient = PatientModel(
          id: credentials.user!.uid,
          email: emailController.text,
          name: userNameController.text,
          age: ageController.text,
          gender: genderController.text,
          imgUrl: imageUrl ?? "",
        );

        await FireStoreHelper.fireStoreHelper.addUserToFireStore(patient);
        isLoading = false;

        notifyListeners();

        AppRouter.navigateToWidgetWithReplacment(MainLayout());
        emailController.text = "";
        passwordController.text = "";
        userNameController.text = "";
        ageController.text = "";
        genderController.text = "";
        imgUrlController.text = "";
        selectedImage = null;
        return credentials;
      }
    }

    return null;
  }

  Future<UserCredential?> doctorSignUp() async {
    if (signUpKey.currentState!.validate()) {
      isLoading = true;
      notifyListeners();
      UserCredential? credentials = await AuthHelper.authHelper.signUp(
        doctorEmailController.text,
        doctorPasswordController.text,
      );
      if (credentials != null) {
        DoctorModel doctor = DoctorModel(
          id: credentials.user!.uid,
          email: doctorEmailController.text,
          name: doctorUserNameController.text,
          speciality: selectedSpeciality!,
        );
        await FireStoreHelper.fireStoreHelper.addDoctorToFireStore(doctor);
        CustomShowDialog.showDialogFunction("successfully added doctor");
        doctorEmailController.text = "";
        doctorUserNameController.text = "";
        selectedSpeciality = null;
        doctorPasswordController.text = "";
        doctorImgUrlController.text = "";
      }
      isLoading = false;
      notifyListeners();

      return credentials;
    }

    return null;
  }

  forgetPassword() {
    AuthHelper.authHelper.forgetPassword(emailController.text);
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      notifyListeners();
    }
  }
}
