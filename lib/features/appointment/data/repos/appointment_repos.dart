import 'package:doctor_mate/core/models/doctor_mate_response.dart';
import 'package:doctor_mate/core/networking/api_error_handler.dart';
import 'package:doctor_mate/core/networking/api_result.dart';
import 'package:doctor_mate/features/appointment/data/apis/appointment_api_services.dart';
import 'package:doctor_mate/features/appointment/data/models/appointment_request_body.dart';
import 'package:doctor_mate/features/appointment/data/models/appointment_response_body.dart';
import 'package:doctor_mate/features/appointment/data/models/available_slots_response.dart';

class AppointmentRepos {
  final AppointmentApiServices _appointmentApiServices;

  AppointmentRepos(this._appointmentApiServices);

  Future<ApiResult<DoctorMateResponse<AvailableSlotsResponse>>>
      getAvailableSlots({
    required String doctorId,
    required String date,
  }) async {
    try {
      final response = await _appointmentApiServices.getAvailableSlots(
        doctorId,
        date,
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<DoctorMateResponse<AppointmentResponseBody>>>
      bookAppointment({
    required AppointmentRequestBody appointmentData,
  }) async {
    try {
      final response =
          await _appointmentApiServices.bookAppointment(appointmentData);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}