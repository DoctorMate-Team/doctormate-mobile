import 'package:dio/dio.dart';
import 'package:doctor_mate/core/models/doctor_mate_response.dart';
import 'package:doctor_mate/core/networking/api_constants.dart';
import 'package:doctor_mate/features/medical-record/data/models/medical_record_list_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'medical_records_api_services.g.dart';
@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class MedicalRecordsApiServices {
  factory MedicalRecordsApiServices(Dio dio, {String? baseUrl}) =>
      _MedicalRecordsApiServices(dio);

  @GET(ApiConstants.medicalRecords)
  Future<DoctorMateResponse<MedicalRecordListResponse>> getMedicalRecords(
    @Query("page") int page,
    @Query("limit") int limit,
  );
}
