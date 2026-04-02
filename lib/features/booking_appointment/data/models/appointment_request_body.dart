import 'package:json_annotation/json_annotation.dart';

part 'appointment_request_body.g.dart';

@JsonSerializable()
class AppointmentRequestBody {
  final String doctorId;
  final String appointmentDate;
  final String appointmentTime;
  final String reason;
  final String appointmentType;
  final String paymentMethod;

  AppointmentRequestBody({
    required this.doctorId,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.reason,
    required this.appointmentType,
    required this.paymentMethod,
  });

  factory AppointmentRequestBody.fromJson(Map<String, dynamic> json) =>
      _$AppointmentRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentRequestBodyToJson(this);
}

/*
{
    "doctorId": "5429A0F0-2A80-4522-C18E-08DE2560C74D",
    "appointmentDate": "2025-11-25",
    "appointmentTime": "12:59:00",
    "reason": "Regular checkup",
    "appointmentType": "online",
    "paymentMethod": "online"
}
*/
