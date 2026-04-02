import 'package:json_annotation/json_annotation.dart';

part 'initiate_payment_response.g.dart';

@JsonSerializable()
class InitiatePaymentResponse {
  final String paymentId;
  final String? paymentUrl;
  final String providerRef;
  final String redirectUrl;

  InitiatePaymentResponse({
    required this.paymentId,
    this.paymentUrl,
    required this.providerRef,
    required this.redirectUrl,
  });

  factory InitiatePaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$InitiatePaymentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InitiatePaymentResponseToJson(this);
}
