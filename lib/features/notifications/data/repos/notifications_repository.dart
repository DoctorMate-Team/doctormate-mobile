import 'package:doctor_mate/core/models/doctor_mate_response.dart';
import 'package:doctor_mate/core/networking/api_error_handler.dart';
import 'package:doctor_mate/core/networking/api_result.dart';
import 'package:doctor_mate/features/notifications/data/apis/notifications_api_service.dart';
import 'package:doctor_mate/features/notifications/data/models/notifications_response.dart';
import 'package:doctor_mate/features/notifications/data/models/unread_count_response.dart';

class NotificationsRepository {
  final NotificationsApiService _notificationsApiService;

  NotificationsRepository(this._notificationsApiService);

  Future<ApiResult<DoctorMateResponse<NotificationsResponse>>>
  getNotifications({required int page, required int limit}) async {
    try {
      final response = await _notificationsApiService.getNotifications(
        page: page,
        limit: limit,
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<DoctorMateResponse<UnreadCountResponse>>>
  getUnreadCount() async {
    try {
      final response = await _notificationsApiService.getUnreadCount();
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<DoctorMateResponse<void>>> markNotificationAsRead({
    required String notificationId,
  }) async {
    try {
      final response = await _notificationsApiService.markNotificationAsRead(
        notificationId: notificationId,
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<DoctorMateResponse<void>>>
  markAllNotificationsAsRead() async {
    try {
      final response =
          await _notificationsApiService.markAllNotificationsAsRead();
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
