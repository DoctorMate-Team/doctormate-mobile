import 'package:doctor_mate/features/notifications/data/models/notification_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notifications_response.g.dart';

@JsonSerializable()
class NotificationsResponse {
  final List<NotificationModel> data;
  final int page;
  final int limit;
  final int totalItems;
  final int totalPages;
  final bool hasPreviousPage;
  final bool hasNextPage;

  NotificationsResponse({
    required this.data,
    required this.page,
    required this.limit,
    required this.totalItems,
    required this.totalPages,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsResponseToJson(this);
}
