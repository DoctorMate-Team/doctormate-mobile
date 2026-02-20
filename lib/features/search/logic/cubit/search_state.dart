import 'package:doctor_mate/features/home/data/models/doctor_model.dart';
import 'package:doctor_mate/features/home/data/models/specialty_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_state.freezed.dart';
@freezed
class SearchState with _$SearchState {
  const factory SearchState.initial() = _Initial;

  const factory SearchState.loadingGetDoctors() = LoadingGetDoctors;
  const factory SearchState.successGetDoctors({
    required DoctorSpecialtyResponse doctorSpecialtyResponse,
  }) = SuccessGetDoctors;
  const factory SearchState.errorGetDoctors(String error) = ErrorGetDoctors;

  const factory SearchState.loadingGetSpecialties() = LoadingGetSpecialties;
  const factory SearchState.successGetSpecialties({
    required List<SpecialtyModel> specialties,
  }) = SuccessGetSpecialties;
  const factory SearchState.errorGetSpecialties(String error) = ErrorGetSpecialties;
}
