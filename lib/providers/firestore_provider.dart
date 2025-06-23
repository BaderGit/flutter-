import 'dart:developer';

import 'package:final_project/data/auth_helper.dart';
import 'package:final_project/data/firestore_helper.dart';
import 'package:final_project/models/appointment.dart';

import 'package:final_project/models/patient.dart';
import 'package:final_project/models/doctor.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class FireStoreProvider extends ChangeNotifier {
  PatientModel? patient;
  DoctorModel? doctor;
  List<DoctorModel?> allDoctors = [];
  List<AppointmentModel?> allAppointments = [];
  List<AppointmentModel?> allStoredAppointments = [];
  List<AppointmentModel?> patienttodaysAppointments = [];
  List<AppointmentModel?> allPatientAppointments = [];
  List<DoctorModel?> filteredDoctors = [];
  String currentCat = "";

  List<Map<String, dynamic>> medCat = [
    {"icon": FontAwesomeIcons.userDoctor, "category": "General"},
    {"icon": FontAwesomeIcons.heartPulse, "category": "Cardiology"},
    {"icon": FontAwesomeIcons.lungs, "category": "Respirations"},
    {"icon": FontAwesomeIcons.hand, "category": "Dermatology"},
    {"icon": FontAwesomeIcons.personPregnant, "category": "Gynecology"},
    {"icon": FontAwesomeIcons.teeth, "category": "Dental"},
  ];

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
    FireStoreHelper.fireStoreHelper.deleteAppointmentFromFireStore(id);
    allAppointments.removeWhere((appointment) => appointment!.id == id);

    notifyListeners();

    await getAllAppointments();
    await getTodaysAppointment();
  }

  deleteStoredAppointment(String id) {
    FireStoreHelper.fireStoreHelper.deleteStoredAppointmentFromFireStore(id);
    allAppointments.removeWhere((appointment) => appointment!.id == id);

    notifyListeners();

    getAllStoredAppointments();
  }

  updateAppointment(AppointmentModel updatedAppointment) async {
    await FireStoreHelper.fireStoreHelper.updateAppointmentInFireStore(
      updatedAppointment,
    );
    final index = allAppointments.indexWhere(
      (appointment) => appointment!.id == updatedAppointment.id,
    );
    if (index != -1) {
      allAppointments[index] = updatedAppointment;
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

  addAppointment(AppointmentModel appointment) async {
    await FireStoreHelper.fireStoreHelper.addAppointmentToFireStore(
      appointment,
    );
    await getAllAppointments();
    await getTodaysAppointment();
  }

  storeAppointment(AppointmentModel appointment) async {
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
    log("this is all appointments${allAppointments.length}");
    allPatientAppointments = allAppointments
        .where((appointment) => appointment!.patient.id == patient!.id)
        .toList();

    log("this is all patient appointments${allPatientAppointments.length}");
    patienttodaysAppointments = allPatientAppointments
        .where((appointment) => appointment!.date == todaysDate)
        .toList();
    patienttodaysAppointments.sort(
      (app1, app2) => app2!.time.compareTo(app1!.time),
    );

    notifyListeners();
    log(
      "this is all patient todays appointments${patienttodaysAppointments.length}",
    );
  }

  // getallPatientAppointment() {
  //   allPatientAppointments = allAppointments
  //       .where((app) => app!.patient.id == patient!.id)
  //       .toList();

  //   notifyListeners();
  //   log("${allPatientAppointments.length}");
  //   // getTodaysAppointment();
  // }

  // getallPatientStoredAppointment() {
  // allPatientAppointments = allStoredAppointments
  //     .where((app) => app!.patient.id == patient!.id)
  //     .toList();

  //   notifyListeners();
  // }
}
