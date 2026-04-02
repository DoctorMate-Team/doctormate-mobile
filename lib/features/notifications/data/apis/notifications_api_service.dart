import 'package:dio/dio.dart';
import 'package:doctor_mate/core/models/doctor_mate_response.dart';
import 'package:doctor_mate/core/networking/api_constants.dart';
import 'package:doctor_mate/features/notifications/data/models/notifications_response.dart';
import 'package:doctor_mate/features/notifications/data/models/unread_count_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'notifications_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class NotificationsApiService {
  factory NotificationsApiService(Dio dio, {String baseUrl}) =
      _NotificationsApiService;

  @GET(ApiConstants.notifications)
  Future<DoctorMateResponse<NotificationsResponse>> getNotifications({
    @Query("page") required int page,
    @Query("limit") required int limit,
  });

  @GET(ApiConstants.notificationsUnreadCount)
  Future<DoctorMateResponse<UnreadCountResponse>> getUnreadCount();

  @PUT(ApiConstants.notificationsMarkRead)
  Future<DoctorMateResponse<void>> markNotificationAsRead({
    @Path("notificationId") required String notificationId,
  });

  @PUT(ApiConstants.notificationsMarkAllRead)
  Future<DoctorMateResponse<void>> markAllNotificationsAsRead();
}
