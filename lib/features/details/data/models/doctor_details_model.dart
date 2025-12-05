import 'package:json_annotation/json_annotation.dart';

part 'doctor_details_model.g.dart';
@JsonSerializable()
class DoctorDetailsModel {
  final String id;
  final String fullName;
  final String specialty;
  final String imageUrl;
  final double consultationFee;
  final String address;
  final String workingTime;
  final List<String> workingDays;
  final String qualifications;
  final String phoneNumber;

  DoctorDetailsModel({
    required this.id,
    required this.fullName,
    required this.specialty,
    required this.imageUrl,
    required this.consultationFee,
    required this.address,
    required this.workingTime,
    required this.workingDays,
    required this.qualifications,
    required this.phoneNumber,
  });

  factory DoctorDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorDetailsModelToJson(this);
}

/*
{
    "code": 200,
    "message": "Doctor retrieved successfully",
    "data": {
        "id": "279f2676-0a36-45f1-5174-08de172a97ef",
        "fullName": "Mohamed Ali",
        "specialty": "Cardiology",
        "imageUrl": "https://res.cloudinary.com/dukkhnflu/image/upload/v1761876798/doctormate/users/lwphifll71jzpgmt8mjs.jpg",
        "consultationFee": 850.00,
        "address": "Cairo",
        "workingTime": "02:13 - 20:34",
        "workingDays": [],
        "qualifications": "MD, Ph.D. in Cardiac Electrophysiology, Cairo University",
        "phoneNumber": "0111934898"
    }
}
*/