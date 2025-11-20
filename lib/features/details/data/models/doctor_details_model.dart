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

  DoctorDetailsModel({
    required this.id,
    required this.fullName,
    required this.specialty,
    required this.imageUrl,
    required this.consultationFee,
    required this.address,
    required this.workingTime,
  });

  factory DoctorDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorDetailsModelToJson(this);
}

/*
{
    "code": 0,
    "message": "string",
    "data": {
        "id": "string",
        "fullName": "string",
        "specialty": "string",
        "imageUrl": "string",
        "consultationFee": 0,
        "address": "string",
        "workingTime": "string"
    }
}
*/