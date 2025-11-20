import 'package:doctor_mate/features/home/data/models/doctor_model.dart';
import 'package:doctor_mate/features/home/data/models/specialty_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';
@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = _Initial;

  // Getting Specialties
  const factory HomeState.getSpecialtiesLoading() = GetSpecialtiesLoading;
  const factory HomeState.getSpecialtiesSuccess({required List<SpecialtyModel> specialties}) =
      GetSpecialtiesSuccess;
  const factory HomeState.getSpecialtiesError({required String message}) =
      GetSpecialtiesError;

   // Getting Doctors By Specialty
  const factory HomeState.getDoctorsBySpecialtyLoading() = GetDoctorsBySpecialtyLoading;
  const factory HomeState.getDoctorsBySpecialtySuccess({required List<DoctorModel> doctors}) =
      GetDoctorsBySpecialtySuccess;
  const factory HomeState.getDoctorsBySpecialtyError({required String message}) =
      GetDoctorsBySpecialtyError;   
}
