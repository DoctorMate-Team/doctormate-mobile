import 'package:json_annotation/json_annotation.dart';

part 'update_payment_status_request.g.dart';

@JsonSerializable()
class UpdatePaymentStatusRequest {
  final String status;
  final String? providerRef;

  UpdatePaymentStatusRequest({required this.status, this.providerRef});

  factory UpdatePaymentStatusRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdatePaymentStatusRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePaymentStatusRequestToJson(this);
}
