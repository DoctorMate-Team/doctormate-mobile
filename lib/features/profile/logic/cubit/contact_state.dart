import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_state.freezed.dart';

@freezed
class ContactState with _$ContactState {
  const factory ContactState.initial() = _Initial;

  // Submit Contact Form States
  const factory ContactState.submitContactLoading() = SubmitContactLoading;
  const factory ContactState.submitContactSuccess() = SubmitContactSuccess;
  const factory ContactState.submitContactError({required String message}) =
      SubmitContactError;
}
