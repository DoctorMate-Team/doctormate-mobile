import 'package:json_annotation/json_annotation.dart';

part 'initiate_payment_request.g.dart';

@JsonSerializable()
class InitiatePaymentRequest {
  final String appointmentId;
  final String provider;

  InitiatePaymentRequest({required this.appointmentId, required this.provider});

  factory InitiatePaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$InitiatePaymentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$InitiatePaymentRequestToJson(this);
}
