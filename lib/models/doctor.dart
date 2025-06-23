// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DoctorModel {
  String? id;

  final String name;
  final String email;
  final String speciality;
  final bool isDoc;

  DoctorModel({
    this.id,
    required this.name,
    required this.email,
    required this.speciality,
    required this.isDoc,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'speciality': speciality,
      'isDoc': isDoc,
    };
  }

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] as String,
      email: map['email'] as String,
      speciality: map['speciality'] as String,
      isDoc: map['isDoc'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory DoctorModel.fromJson(String source) =>
      DoctorModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
