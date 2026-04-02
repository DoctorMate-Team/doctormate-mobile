import 'package:doctor_mate/features/notifications/data/models/notification_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notifications_state.freezed.dart';

@freezed
class NotificationsState with _$NotificationsState {
  const factory NotificationsState.initial() = _Initial;

  // Get notifications states
  const factory NotificationsState.loadingNotifications() =
      LoadingNotifications;

  const factory NotificationsState.successNotifications({
    required List<NotificationModel> notifications,
    required int totalItems,
    required int currentPage,
    required bool hasNextPage,
    required bool hasPreviousPage,
  }) = SuccessNotifications;

  const factory NotificationsState.errorNotifications({
    required String message,
  }) = ErrorNotifications;

  // Load more notifications states
  const factory NotificationsState.loadingMoreNotifications({
    required List<NotificationModel> currentNotifications,
  }) = LoadingMoreNotifications;

  const factory NotificationsState.successLoadMore({
    required List<NotificationModel> notifications,
    required int totalItems,
    required int currentPage,
    required bool hasNextPage,
    required bool hasPreviousPage,
  }) = SuccessLoadMore;

  const factory NotificationsState.errorLoadMore({
    required List<NotificationModel> currentNotifications,
    required String message,
  }) = ErrorLoadMore;

  // Unread count states
  const factory NotificationsState.unreadCountUpdated({required int count}) =
      UnreadCountUpdated;

  // Mark as read states
  const factory NotificationsState.successMarkAsRead({
    required String notificationId,
  }) = SuccessMarkAsRead;

  const factory NotificationsState.errorMarkAsRead({required String message}) =
      ErrorMarkAsRead;

  // Mark all as read states
  const factory NotificationsState.successMarkAllAsRead() =
      SuccessMarkAllAsRead;

  const factory NotificationsState.errorMarkAllAsRead({
    required String message,
  }) = ErrorMarkAllAsRead;
}
