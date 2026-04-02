import 'package:doctor_mate/core/models/doctor_mate_response.dart';
import 'package:doctor_mate/core/networking/api_error_handler.dart';
import 'package:doctor_mate/core/networking/api_result.dart';
import 'package:doctor_mate/features/details/data/apis/details_apis_services.dart';
import 'package:doctor_mate/features/details/data/models/doctor_details_model.dart';

class DetailsRepos {
  final DetailsApiServices _detailsApiServices;

  DetailsRepos(this._detailsApiServices);

  Future<ApiResult<DoctorMateResponse<DoctorDetailsModel>>> getDoctorDetails({
    required String doctorId,
  }) async {
    try {
      final response =
          await _detailsApiServices.getDoctorDetails(doctorId: doctorId);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(
        ErrorHandler.handle(e),
      );
    }
  }
}