import 'package:json_annotation/json_annotation.dart';

part 'profile_response_model.g.dart';

@JsonSerializable()
class ProfileResponseModel {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String? imageUrl;
  final String role;
  final DateTime birthDate;
  final String gender;
  final String address;
  final String bloodType;
  final String? emergencyContact;
  final String? openmrsPatientUuid;

  const ProfileResponseModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.imageUrl,
    required this.role,
    required this.birthDate,
    required this.gender,
    required this.address,
    required this.bloodType,
    required this.emergencyContact,
    required this.openmrsPatientUuid,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseModelToJson(this);
}

/*
{
    "code": 200,
    "message": "Patient profile found",
    "data": {
        "id": "7450e62b-3c62-42b3-0ab4-08de1a5e33bd",
        "fullName": "Mona Ali Ahmed",
        "email": "user07@example.com",
        "phone": "01221049237",
        "imageUrl": "https://res.cloudinary.com/dukkhnflu/image/upload/v1762122739/doctormate/users/bx8qg2k30csludvk8zd2.jpg",
        "role": "Patient",
        "birthDate": "1998-05-14T00:00:00",
        "gender": "male",
        "address": "7 Tahrir Street, Giza",
        "bloodType": "A+",
        "emergencyContact": null,
        "openmrsPatientUuid": null,
        "createdAt": "2025-11-02T22:22:10.3152403",
        "updatedAt": "2025-11-02T22:31:45.8227215"
    }
}
*/
