import 'dart:developer';

import 'package:final_project/data/auth_helper.dart';
import 'package:final_project/data/firestore_helper.dart';
import 'package:final_project/l10n/app_localizations.dart';

import 'package:final_project/models/appointment.dart';

import 'package:final_project/models/patient.dart';
import 'package:final_project/models/doctor.dart';
import 'package:final_project/utils/custom_dialog.dart';
import 'package:final_project/utils/local_notification.dart';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class FireStoreProvider extends ChangeNotifier {
  PatientModel? patient;
  DoctorModel? doctor;
  List<DoctorModel?> allDoctors = [];
  List<AppointmentModel?> allAppointments = [];
  List<AppointmentModel?> allStoredAppointments = [];
  List<AppointmentModel?> patienttodaysAppointments = [];

  List<DoctorModel?> filteredDoctors = [];
  String currentCat = "";
  bool isLoading = false;

  getPatient() async {
    patient = await FireStoreHelper.fireStoreHelper.getPatientFromFireStore(
      AuthHelper.authHelper.getUserId(),
    );
    notifyListeners();
    await getAllAppointments();
    await getAllStoredAppointments();
  }

  getDoctor() async {
    doctor = await FireStoreHelper.fireStoreHelper.getDoctorFromFireStore(
      AuthHelper.authHelper.getUserId(),
    );
    allDoctors.add(doctor);
    notifyListeners();
  }

  Future<AppointmentModel?>? getAppointment(String id) async {
    AppointmentModel? appointmentModel = await FireStoreHelper.fireStoreHelper
        .getAppointmentFromFireStore(id);

    getAllAppointments();

    return appointmentModel;
  }

  getAllAppointments() async {
    allAppointments = await FireStoreHelper.fireStoreHelper
        .getAllAppointments();
    allAppointments.sort((app1, app2) => app1!.time.compareTo(app2!.time));
    allAppointments.sort((app1, app2) => app1!.date.compareTo(app2!.date));

    notifyListeners();
  }

  getAllDoctors() async {
    allDoctors = await FireStoreHelper.fireStoreHelper.getAllDoctors();
    notifyListeners();
  }

  updateCurrentDoctors(String category) {
    currentCat = currentCat == category ? "" : category;

    if (currentCat == "") {
      filteredDoctors = allDoctors;
    } else {
      filteredDoctors = allDoctors
          .where(
            (doctor) =>
                doctor!.speciality.toLowerCase() == currentCat.toLowerCase(),
          )
          .toList();
    }

    notifyListeners();
  }

  deleteAppointment(String id) async {
    await FireStoreHelper.fireStoreHelper.deleteAppointmentFromFireStore(id);
    allAppointments.removeWhere((appointment) => appointment!.id == id);

    notifyListeners();

    await getAllAppointments();
    await getTodaysAppointment();
  }

  deleteStoredAppointment(String id) async {
    await FireStoreHelper.fireStoreHelper.deleteStoredAppointmentFromFireStore(
      id,
    );
    allStoredAppointments.removeWhere((appointment) => appointment!.id == id);

    notifyListeners();

    await getAllStoredAppointments();
  }

  updateAppointment(
    AppointmentModel updatedAppointment,
    String success,
    AppLocalizations localization,
  ) async {
    isLoading = true;
    notifyListeners();
    await FireStoreHelper.fireStoreHelper.updateAppointmentInFireStore(
      updatedAppointment,
    );
    final index = allAppointments.indexWhere(
      (appointment) => appointment!.id == updatedAppointment.id,
    );
    if (index != -1) {
      allAppointments[index] = updatedAppointment;
      CustomShowDialog.showDialogFunction(success, localization);
      isLoading = false;
      notifyListeners();
      notifyListeners();
    }
    await getAllAppointments();
    await getAllStoredAppointments();
    await getTodaysAppointment();
  }

  updateStoredAppointment(AppointmentModel updatedAppointment) async {
    await FireStoreHelper.fireStoreHelper.updateStoredAppointmentInFireStore(
      updatedAppointment,
    );

    final index = allStoredAppointments.indexWhere(
      (appointment) => appointment!.id == updatedAppointment.id,
    );
    if (index != -1) {
      allStoredAppointments[index] = updatedAppointment;
      notifyListeners();
    }

    await getAllAppointments();
    await getAllStoredAppointments();
  }

  addAppointment(
    AppointmentModel appointment,
    String content,
    String failed,
    AppLocalizations localization,
  ) async {
    try {
      isLoading = true;
      notifyListeners();
      final index = allAppointments.indexWhere((app) {
        return app!.date == appointment.date &&
            app.time == appointment.time &&
            app.doctor.id == appointment.doctor.id;
      });
      if (index != -1) {
        CustomShowDialog.showDialogFunction(failed, localization);
        return;
      }
      await FireStoreHelper.fireStoreHelper.addAppointmentToFireStore(
        appointment,
      );

      CustomShowDialog.showDialogFunction(content, localization);
      LocalNotification.localNotification.getRightTime(appointment);

      await getAllAppointments();
      await getTodaysAppointment();
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  storeAppointment(AppointmentModel appointment) async {
    final index = allStoredAppointments.indexWhere((app) {
      return app!.date == appointment.date && app.time == appointment.time;
    });
    if (index != -1) {
      return;
    }
    await FireStoreHelper.fireStoreHelper.storeAppointmentToFireStore(
      appointment,
    );
    await getAllStoredAppointments();
  }

  getAllStoredAppointments() async {
    allStoredAppointments = await FireStoreHelper.fireStoreHelper
        .getAllStoredAppointments();
    // getallPatientStoredAppointment();
    notifyListeners();
  }

  getTodaysAppointment() {
    var now = DateTime.now();
    var todaysDate = DateFormat('M/d/yyyy').format(now);
    List<AppointmentModel?> allPatientAppointments = [];

    allPatientAppointments = allAppointments
        .where((appointment) => appointment!.patient.id == patient!.id)
        .toList();

    patienttodaysAppointments = allPatientAppointments
        .where((appointment) => appointment!.date == todaysDate)
        .toList();
    patienttodaysAppointments.sort(
      (app1, app2) => app2!.time.compareTo(app1!.time),
    );

    notifyListeners();
  }
}
