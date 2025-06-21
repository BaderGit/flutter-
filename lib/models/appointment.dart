// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:final_project/models/doctor.dart';
import 'package:final_project/models/patient.dart';

class AppointmentModel {
  String? id;
  DoctorModel doctor;
  PatientModel patient;
  final String date;
  final String day;
  final String time;
  AppointmentModel({
    this.id,
    required this.doctor,
    required this.patient,
    required this.date,
    required this.day,
    required this.time,
  });

  AppointmentModel copyWith({
    String? id,
    DoctorModel? doctor,
    PatientModel? patient,
    String? date,
    String? day,
    String? time,
  }) {
    return AppointmentModel(
      id: id ?? this.id,
      doctor: doctor ?? this.doctor,
      patient: patient ?? this.patient,
      date: date ?? this.date,
      day: day ?? this.day,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'doctor': doctor.toMap(),
      'patient': patient.toMap(),
      'date': date,
      'day': day,
      'time': time,
    };
  }

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      id: map['id'] != null ? map['id'] as String : null,
      doctor: DoctorModel.fromMap(map['doctor'] as Map<String, dynamic>),
      patient: PatientModel.fromMap(map['patient'] as Map<String, dynamic>),
      date: map['date'] as String,
      day: map['day'] as String,
      time: map['time'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppointmentModel.fromJson(String source) =>
      AppointmentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AppointmentModel(id: $id, doctor: $doctor, patient: $patient, date: $date, day: $day, time: $time)';
  }

  @override
  bool operator ==(covariant AppointmentModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.doctor == doctor &&
        other.patient == patient &&
        other.date == date &&
        other.day == day &&
        other.time == time;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        doctor.hashCode ^
        patient.hashCode ^
        date.hashCode ^
        day.hashCode ^
        time.hashCode;
  }
}
