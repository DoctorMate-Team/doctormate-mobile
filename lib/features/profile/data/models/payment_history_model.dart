import 'package:doctor_mate/core/models/pagination.dart';

class PaymentHistoryResponse {
  final List<PaymentHistoryModel> payments;
  final Pagination pagination;

  PaymentHistoryResponse({
    required this.payments,
    required this.pagination,
  });

  factory PaymentHistoryResponse.fromJson(Map<String, dynamic> json) {
    return PaymentHistoryResponse(
      payments: (json['payments'] as List<dynamic>)
          .map((e) => PaymentHistoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );
  }
}

class PaymentHistoryModel {
  final String id;
  final String date;    
  final double amount;
  final String status; // 'Success' or 'Pending' etc
  final String doctorName;
  final String appointmentType;
  final String currency;
  final String provider;

  PaymentHistoryModel({
    required this.id,
    required this.date,
    required this.amount,
    required this.status,
    required this.doctorName,
    required this.appointmentType,
    required this.currency,
    required this.provider,
  });

  factory PaymentHistoryModel.fromJson(Map<String, dynamic> json) {
    final appointment = json['appointment'] as Map<String, dynamic>?;
    return PaymentHistoryModel(
      id: json['id'] as String? ?? '',
      date: json['createdAt'] as String? ?? json['paidAt'] as String? ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] as String? ?? '',
      doctorName: appointment?['doctorName'] as String? ?? 'Unknown Doctor',
      appointmentType: appointment?['appointmentType'] as String? ?? 'Unknown Type',
      currency: json['currency'] as String? ?? 'EGP',
      provider: json['provider'] as String? ?? '',
    );
  }
}
