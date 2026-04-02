import 'package:doctor_mate/core/models/doctor_mate_response.dart';
import 'package:doctor_mate/core/networking/api_error_handler.dart';
import 'package:doctor_mate/core/networking/api_result.dart';
import 'package:doctor_mate/features/medical-record/data/api/medical_records_api_services.dart';
import 'package:doctor_mate/features/medical-record/data/models/medical_record_list_response.dart';

class MedicalRecordsRepos {
  final MedicalRecordsApiServices _medicalRecordsApiServices;

  MedicalRecordsRepos(this._medicalRecordsApiServices);


  Future<ApiResult<DoctorMateResponse<MedicalRecordListResponse>>>
      getMedicalRecords({required int page, required int limit}) async {
    try {
      final response = await _medicalRecordsApiServices.getMedicalRecords(
        page,
        limit,
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}