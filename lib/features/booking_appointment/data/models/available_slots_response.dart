import 'package:json_annotation/json_annotation.dart';

part 'available_slots_response.g.dart';
@JsonSerializable()
class AvailableSlotsResponse {
  final String doctorId;
  final String date;
  final int slotDuration;
  final int buffer;
  final List<DateTime> slots;
  final bool isWorkingDay;

  AvailableSlotsResponse({
    required this.doctorId,
    required this.date,
    required this.slotDuration,
    required this.buffer,
    required this.slots,
    required this.isWorkingDay,
  });

  factory AvailableSlotsResponse.fromJson(Map<String, dynamic> json) =>
      _$AvailableSlotsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AvailableSlotsResponseToJson(this);
}

/*
{
    "code": 200,
    "message": "Available slots",
    "data": {
        "doctorId": "6259420f-b64f-4156-a3ae-08de29ac6dce",
        "date": "2025-12-24",
        "slotDuration": 15,
        "buffer": 15,
        "slots": [
            "2025-12-24T09:00:00Z",
            "2025-12-24T09:15:00Z",
            "2025-12-24T09:30:00Z",
            "2025-12-24T09:45:00Z",
            "2025-12-24T10:00:00Z",
            "2025-12-24T10:15:00Z",
            "2025-12-24T10:30:00Z",
            "2025-12-24T10:45:00Z",
            "2025-12-24T11:00:00Z",
            "2025-12-24T11:15:00Z",
            "2025-12-24T11:30:00Z",
            "2025-12-24T11:45:00Z",
            "2025-12-24T12:00:00Z",
            "2025-12-24T12:15:00Z",
            "2025-12-24T12:30:00Z",
            "2025-12-24T12:45:00Z",
            "2025-12-24T13:00:00Z",
            "2025-12-24T13:15:00Z",
            "2025-12-24T13:30:00Z",
            "2025-12-24T13:45:00Z",
            "2025-12-24T14:00:00Z",
            "2025-12-24T14:15:00Z",
            "2025-12-24T14:30:00Z",
            "2025-12-24T14:45:00Z",
            "2025-12-24T15:00:00Z",
            "2025-12-24T15:15:00Z",
            "2025-12-24T15:30:00Z",
            "2025-12-24T15:45:00Z",
            "2025-12-24T16:00:00Z",
            "2025-12-24T16:15:00Z",
            "2025-12-24T16:30:00Z",
            "2025-12-24T16:45:00Z"
        ],
        "isWorkingDay": true
    }
}
*/