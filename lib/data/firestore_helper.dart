import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/models/patient.dart';

import 'package:final_project/models/appointment.dart';
import 'package:final_project/models/doctor.dart';

class FireStoreHelper {
  FireStoreHelper._();
  static FireStoreHelper fireStoreHelper = FireStoreHelper._();
  FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  var paitentCollection = FirebaseFirestore.instance.collection('patients');
  var doctorCollection = FirebaseFirestore.instance.collection('doctors');
  var staffCollection = FirebaseFirestore.instance.collection('staffs');
  var appointmentCollection = FirebaseFirestore.instance.collection(
    'appointments',
  );
  var storedAppointmentCollection = FirebaseFirestore.instance.collection(
    'stored_appointments',
  );

  //backend firebase code to add user to firestore

  Future<bool> addUserToFireStore(PatientModel patient) async {
    await paitentCollection.doc(patient.id).set(patient.toMap());
    return true;
  }

  //backend firebase code to add doctor  to firestore
  addDoctorToFireStore(DoctorModel doctor) async {
    await doctorCollection.doc(doctor.id).set(doctor.toMap());
  }

  Future<String?> addAppointmentToFireStore(
    AppointmentModel appointment,
  ) async {
    await appointmentCollection.doc(appointment.id).set(appointment.toMap());
    return appointment.id;
  }

  Future<String?> storeAppointmentToFireStore(
    AppointmentModel appointment,
  ) async {
    await storedAppointmentCollection
        .doc(appointment.id)
        .set(appointment.toMap());
    return appointment.id;
  }
  //backend firebase code to get user  to firestore

  //backend firebase code to get appointment  to firestore

  Future<AppointmentModel?>? getAppointmentFromFireStore(String? id) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapShot =
          await appointmentCollection.doc(id).get();
      if (documentSnapShot.data() == null) {
        return null;
      }

      return AppointmentModel.fromMap(documentSnapShot.data()!);
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<PatientModel?>? getPatientFromFireStore(String? id) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapShot =
        await paitentCollection.doc(id).get();
    Map<String, dynamic>? data = documentSnapShot.data();
    if (data != null) {
      return PatientModel?.fromMap(data);
    }
    return null;
  }

  Future<bool> getStaffFromFireStore(String? id) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapShot =
        await staffCollection.doc(id).get();
    Map<String, dynamic>? data = documentSnapShot.data();
    if (data != null) {
      return true;
    }
    return false;
  }

  Future<DoctorModel?>? getDoctorFromFireStore(String? id) async {
    DocumentSnapshot<Map<String, dynamic>>? documentSnapShot =
        await doctorCollection.doc(id).get();

    Map<String, dynamic>? data = documentSnapShot.data();
    if (data != null) {
      return DoctorModel?.fromMap(data);
    }
    return null;
  }

  Future<List<DoctorModel>> getAllDoctors() async {
    var doctorsQuerySnapShot = await doctorCollection.get();
    List<DoctorModel> allDoctors = doctorsQuerySnapShot.docs
        .map((e) => DoctorModel.fromMap(e.data()))
        .toList();
    return allDoctors;
  }

  Future<List<AppointmentModel>> getAllAppointments() async {
    var appointmentsQuerySnapShot = await appointmentCollection.get();
    List<AppointmentModel> allAppointments = appointmentsQuerySnapShot.docs
        .map((e) => AppointmentModel.fromMap(e.data()))
        .toList();
    return allAppointments;
  }

  Future<List<AppointmentModel>> getAllStoredAppointments() async {
    var storedAppointmentsQuerySnapShot = await storedAppointmentCollection
        .get();
    List<AppointmentModel> allStoredAppointments =
        storedAppointmentsQuerySnapShot.docs
            .map((e) => AppointmentModel.fromMap(e.data()))
            .toList();
    return allStoredAppointments;
  }

  deleteAppointmentFromFireStore(String id) async {
    try {
      await appointmentCollection.doc(id).delete();
    } catch (e) {
      print('Error deleting document: $e');
    }
  }

  deleteStoredAppointmentFromFireStore(String id) async {
    try {
      await storedAppointmentCollection.doc(id).delete();
    } catch (e) {
      print('Error deleting document: $e');
    }
  }

  updateAppointmentInFireStore(AppointmentModel appointment) async {
    try {
      await appointmentCollection
          .doc(appointment.id)
          .update(appointment.toMap());
    } catch (e) {
      print('Error updating document: $e');
    }
  }

  updateStoredAppointmentInFireStore(AppointmentModel appointment) async {
    try {
      await storedAppointmentCollection
          .doc(appointment.id)
          .update(appointment.toMap());
    } catch (e) {
      print('Error updating document: $e');
    }
  }
}
