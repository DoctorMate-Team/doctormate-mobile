import 'package:doctor_mate/features/smart-checkup/data/models/smart_check_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'smart_checkup_state.freezed.dart';
@freezed
class SmartCheckupState with _$SmartCheckupState {
  const factory SmartCheckupState.initial() = _Initial;

  // Skin Checkup States
  const factory SmartCheckupState.skinCheckupLoading() = SkinCheckupLoading;
  const factory SmartCheckupState.skinCheckupSuccess(SmartCheckResponse response) = SkinCheckupSuccess;
  const factory SmartCheckupState.skinCheckupFailure(String error) = SkinCheckupFailure;

  // Symptom Checkup States
  const factory SmartCheckupState.symptomCheckupLoading() = SymptomCheckupLoading;
  const factory SmartCheckupState.symptomCheckupSuccess(SmartCheckResponse response) = SymptomCheckupSuccess;
  const factory SmartCheckupState.symptomCheckupFailure(String error) = SymptomCheckupFailure;
}
