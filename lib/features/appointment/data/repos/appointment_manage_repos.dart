import 'package:doctor_mate/core/models/doctor_mate_response.dart';
import 'package:doctor_mate/core/networking/api_error_handler.dart';
import 'package:doctor_mate/core/networking/api_result.dart';
import 'package:doctor_mate/features/appointment/data/apis/appointment_manage_api_services.dart';
import 'package:doctor_mate/features/appointment/data/models/appointment_list_response.dart';

class AppointmentManageRepos {
  final AppointmentManageApiServices _apiServices;

  AppointmentManageRepos(this._apiServices);

  Future<ApiResult<DoctorMateResponse<AppointmentListResponse>>>
  getPatientAppointments({required int page, required int limit}) async {
    try {
      final response = await _apiServices.getPatientAppointments(
        page: page,
        limit: limit,
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<DoctorMateResponse<void>>> updateAppointmentStatus({
    required String appointmentId,
  }) async {
    try {
      final response = await _apiServices.updateAppointmentStatus(
        appointmentId: appointmentId,
        statusUpdate: {'status': "Cancelled"},
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
