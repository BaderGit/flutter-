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
    try {
      if (loginKey.currentState!.validate()) {
        isLoading = true;
        notifyListeners();
        if (userType == "doctor") {
          UserCredential? doctorCredentials = await AuthHelper.authHelper
              .signIn(
                doctorEmailController.text,
                doctorPasswordController.text,
              );

          if (doctorCredentials != null) {
            final doctor = await FireStoreHelper.fireStoreHelper
                .getDoctorFromFireStore(doctorCredentials.user!.uid);
            if (doctor != null) {
              isLoading = false;
              notifyListeners();
              AppRouter.navigateToWidgetWithReplacment(MainLayout());

              return doctorCredentials;
            }
            AppRouter.navigateToWidgetWithReplacment(UserTypeScreen());

            CustomShowDialog.showDialogFunction(
              "please select the right user type",
            );
            // doctorEmailController.clear();
            // doctorPasswordController.clear();

            isLoading = false;
            notifyListeners();

            return null;
          }
        } else {
          // isLoading = true;
          // notifyListeners();
          UserCredential? credentials = await AuthHelper.authHelper.signIn(
            emailController.text,
            passwordController.text,
          );

          if (credentials != null) {
            if (userType == "patient") {
              final patient = await FireStoreHelper.fireStoreHelper
                  .getPatientFromFireStore(credentials.user!.uid);

              if (patient != null) {
                AppRouter.navigateToWidgetWithReplacment(MainLayout());
                return credentials;
              } else {
                AppRouter.navigateToWidgetWithReplacment(UserTypeScreen());

                CustomShowDialog.showDialogFunction(
                  "please select the right user type",
                );
              }
            } else if (userType == "staff") {
              final staff = await FireStoreHelper.fireStoreHelper
                  .getStaffFromFireStore(credentials.user!.uid);
              log("this is a staff $staff");
              if (staff) {
                log("in staff if ");
                AppRouter.navigateToWidgetWithReplacment(StaffScreen());
              } else {
                AppRouter.navigateToWidgetWithReplacment(UserTypeScreen());

                CustomShowDialog.showDialogFunction(
                  "please select the right user type",
                );
                return null;
              }
            }
          }
          // isLoading = false;
          // emailController.clear();
          // passwordController.clear();
          // notifyListeners();

          // emailController.clear();

          // isLoading = false;
          // notifyListeners();
        }
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading = false;
      emailController.clear();
      passwordController.clear();
      doctorEmailController.clear();
      doctorPasswordController.clear();
    }

    return null;
  }

  checkUser(String? userType) async {
    User? user;
    user = await AuthHelper.authHelper.checkUser();
    if (user == null) {
      AppRouter.navigateToWidgetWithReplacment(UserTypeScreen());
    } else if (userType == "patient") {
      final patient = await FireStoreHelper.fireStoreHelper
          .getPatientFromFireStore(user.uid);
      if (patient == null) {
        AppRouter.navigateToWidgetWithReplacment(UserTypeScreen());
      } else {
        AppRouter.navigateToWidgetWithReplacment(MainLayout());
      }
    } else if (userType == "staff") {
      final staff = await FireStoreHelper.fireStoreHelper.getStaffFromFireStore(
        user.uid,
      );
      if (staff) {
        AppRouter.navigateToWidgetWithReplacment(StaffScreen());
      } else {
        AppRouter.navigateToWidgetWithReplacment(UserTypeScreen());
      }
    } else if (userType == "doctor") {
      final doctor = await FireStoreHelper.fireStoreHelper
          .getDoctorFromFireStore(user.uid);
      if (doctor == null) {
        AppRouter.navigateToWidgetWithReplacment(UserTypeScreen());
      } else {
        AppRouter.navigateToWidgetWithReplacment(MainLayout());
      }
    }
  }

  signOut() {
    AuthHelper.authHelper.signOut();
    AppRouter.navigateToWidgetWithReplacment(UserTypeScreen());
    SpHelper.spHelper.setUserType("");

    emailController.text = "";
  }

  Future<UserCredential?> userSignUp() async {
    try {
      isLoading = true;
      notifyListeners();
      if (selectedImage == null) {
        CustomShowDialog.showDialogFunction("please enter a profile picture");
        isLoading = false;
        notifyListeners();
        return null;
      }
      if (signUpKey.currentState!.validate()) {
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
            isDoc: false,
          );

          await FireStoreHelper.fireStoreHelper.addUserToFireStore(patient);

          AppRouter.navigateToWidgetWithReplacment(MainLayout());
          emailController.clear();
          userNameController.clear();
          ageController.clear();
          genderController.clear();
          passwordController.clear();
          selectedImage = null;

          return credentials;
        }
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }

    return null;
  }

  Future<UserCredential?> doctorSignUp() async {
    try {
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
            isDoc: true,
          );
          await FireStoreHelper.fireStoreHelper.addDoctorToFireStore(doctor);
          CustomShowDialog.showDialogFunction("successfully added doctor");
          isLoading = false;
          doctorEmailController.clear();
          doctorUserNameController.clear();
          selectedSpeciality = null;
          doctorPasswordController.clear();
          doctorImgUrlController.clear();
          notifyListeners();
        }

        return credentials;
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
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
