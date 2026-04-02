import 'package:json_annotation/json_annotation.dart';

part 'doctor_mate_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class DoctorMateResponse<T> {
  final int code;
  final String message;
  final T data;

  DoctorMateResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory DoctorMateResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$DoctorMateResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$DoctorMateResponseToJson(this, toJsonT);
}
