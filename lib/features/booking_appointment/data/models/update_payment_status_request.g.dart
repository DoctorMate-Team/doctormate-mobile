// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_payment_status_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePaymentStatusRequest _$UpdatePaymentStatusRequestFromJson(
  Map<String, dynamic> json,
) => UpdatePaymentStatusRequest(
  status: json['status'] as String,
  providerRef: json['providerRef'] as String?,
);

Map<String, dynamic> _$UpdatePaymentStatusRequestToJson(
  UpdatePaymentStatusRequest instance,
) => <String, dynamic>{
  'status': instance.status,
  'providerRef': instance.providerRef,
};
