// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initiate_payment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InitiatePaymentRequest _$InitiatePaymentRequestFromJson(
  Map<String, dynamic> json,
) => InitiatePaymentRequest(
  appointmentId: json['appointmentId'] as String,
  provider: json['provider'] as String,
);

Map<String, dynamic> _$InitiatePaymentRequestToJson(
  InitiatePaymentRequest instance,
) => <String, dynamic>{
  'appointmentId': instance.appointmentId,
  'provider': instance.provider,
};
