// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initiate_payment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InitiatePaymentResponse _$InitiatePaymentResponseFromJson(
  Map<String, dynamic> json,
) => InitiatePaymentResponse(
  paymentId: json['paymentId'] as String,
  paymentUrl: json['paymentUrl'] as String?,
  providerRef: json['providerRef'] as String,
  redirectUrl: json['redirectUrl'] as String,
);

Map<String, dynamic> _$InitiatePaymentResponseToJson(
  InitiatePaymentResponse instance,
) => <String, dynamic>{
  'paymentId': instance.paymentId,
  'paymentUrl': instance.paymentUrl,
  'providerRef': instance.providerRef,
  'redirectUrl': instance.redirectUrl,
};
