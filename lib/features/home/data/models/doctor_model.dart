import 'package:doctor_mate/features/home/data/models/specialty_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'doctor_model.g.dart';
@JsonSerializable()
class DoctorModel {
  final String id;
  final String fullName;
  final SpecialtyModel specialty;
  final String imageUrl;
  final double consultationFee;
  final String address;
  final String workingTime;
  final String qualifications;
  final String licenseNumber;

  DoctorModel({
    required this.id,
    required this.fullName,
    required this.specialty,
    required this.imageUrl,
    required this.consultationFee,
    required this.address,
    required this.workingTime,
    required this.qualifications,
    required this.licenseNumber,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorModelToJson(this);
}

/*
{
    "code": 0,
    "message": "string",
    "data": [
        {
            "id": "string",
            "fullName": "string",
            "specialty": {
                "id": "string",
                "name": "string",
                "description": "string",
                "imageUrl": "string"
            },
            "imageUrl": "string",
            "consultationFee": 0,
            "address": "string",
            "workingTime": "string",
            "qualifications": "string",
            "licenseNumber": "string"
        }
    ]
}
*/