import 'package:doctor_mate/core/models/doctor_mate_response.dart';
import 'package:doctor_mate/core/networking/api_error_handler.dart';
import 'package:doctor_mate/core/networking/api_result.dart';
import 'package:doctor_mate/features/prescriptions/data/api/prescriptions_api_services.dart';
import 'package:doctor_mate/features/prescriptions/data/models/prescription_details_response.dart';

class PrescriptionsRepos {
  final PrescriptionsApiServices _prescriptionsApiServices;

  PrescriptionsRepos(this._prescriptionsApiServices);

  Future<ApiResult<DoctorMateResponse<PrescriptionDetailsResponse>>> getPrescriptionDetails({
    required String appointmentId,
  }) async {
    try {
      final response = await _prescriptionsApiServices
          .getPrescriptionDetails(appointmentId);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}