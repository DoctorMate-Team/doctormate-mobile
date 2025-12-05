import 'package:doctor_mate/core/models/pagination.dart';
import 'package:doctor_mate/features/home/data/models/specialty_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'doctor_model.g.dart';

@JsonSerializable()
class DoctorSpecialtyResponse {
  final Pagination pagination;
  final List<DoctorModel> doctors;

  DoctorSpecialtyResponse({
    required this.pagination,
    required this.doctors,
  });

  factory DoctorSpecialtyResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorSpecialtyResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DoctorSpecialtyResponseToJson(this);
}

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
    "code": 200,
    "message": "Found 11 doctors",
    "data": {
        "pagination": {
            "page": 1,
            "limit": 1,
            "totalItems": 11,
            "totalPages": 11
        },
        "doctors": [
            {
                "id": "279f2676-0a36-45f1-5174-08de172a97ef",
                "fullName": "Mohamed Ali",
                "specialty": {
                    "id": "a1111111-a1a1-a1a1-a1a1-a1a1a1a1a1a1",
                    "name": "Cardiology",
                    "description": "Specializes in the treatment of the heart and blood vessels.",
                    "imageUrl": "https://example.com/images/cardio.png"
                },
                "imageUrl": "https://res.cloudinary.com/dukkhnflu/image/upload/v1761876798/doctormate/users/lwphifll71jzpgmt8mjs.jpg",
                "consultationFee": 850.00,
                "address": "Cairo",
                "workingTime": "02:13 - 20:34",
                "qualifications": "MD, Ph.D. in Cardiac Electrophysiology, Cairo University",
                "licenseNumber": "DOC-789321-EG"
            }
        ]
    }
}
*/