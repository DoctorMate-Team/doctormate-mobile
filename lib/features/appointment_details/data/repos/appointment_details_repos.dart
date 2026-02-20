import 'package:doctor_mate/core/models/doctor_mate_response.dart';
import 'package:doctor_mate/core/networking/api_error_handler.dart';
import 'package:doctor_mate/core/networking/api_result.dart';
import 'package:doctor_mate/features/appointment_details/data/apis/appointment_details_api_services.dart';
import 'package:doctor_mate/features/appointment_details/data/models/appointment_details_response.dart';

class AppointmentDetailsRepos {
  final AppointmentDetailsApiServices _apiServices;

  AppointmentDetailsRepos(this._apiServices);

  Future<ApiResult<DoctorMateResponse<AppointmentDetailsResponse>>>
  getAppointmentDetails(String appointmentId) async {
    try {
      final response = await _apiServices.getAppointmentDetails(
        appointmentId: appointmentId,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
