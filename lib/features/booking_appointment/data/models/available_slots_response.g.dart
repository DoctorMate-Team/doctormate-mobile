// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_slots_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvailableSlotsResponse _$AvailableSlotsResponseFromJson(
  Map<String, dynamic> json,
) => AvailableSlotsResponse(
  doctorId: json['doctorId'] as String,
  date: json['date'] as String,
  slotDuration: (json['slotDuration'] as num).toInt(),
  buffer: (json['buffer'] as num).toInt(),
  slots:
      (json['slots'] as List<dynamic>)
          .map((e) => DateTime.parse(e as String))
          .toList(),
  isWorkingDay: json['isWorkingDay'] as bool,
);

Map<String, dynamic> _$AvailableSlotsResponseToJson(
  AvailableSlotsResponse instance,
) => <String, dynamic>{
  'doctorId': instance.doctorId,
  'date': instance.date,
  'slotDuration': instance.slotDuration,
  'buffer': instance.buffer,
  'slots': instance.slots.map((e) => e.toIso8601String()).toList(),
  'isWorkingDay': instance.isWorkingDay,
};
