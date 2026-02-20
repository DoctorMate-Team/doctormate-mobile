import 'package:freezed_annotation/freezed_annotation.dart';

part 'communication_state.freezed.dart';

@freezed
class CommunicationState with _$CommunicationState {
  // Initial state
  const factory CommunicationState.initial() = _Initial;

  // Checking if communication session is available
  const factory CommunicationState.checkingSession() = CheckingSession;

  // Session is active and communication is allowed
  const factory CommunicationState.sessionActive({
    required String sessionId,
    required String channelName,
  }) = SessionActive;

  // No session available - communication not allowed
  const factory CommunicationState.sessionNotAvailable({
    required String message,
  }) = SessionNotAvailable;

  // Error checking session
  const factory CommunicationState.sessionCheckError({required String error}) =
      SessionCheckError;

  // Getting call token
  const factory CommunicationState.gettingCallToken() = GettingCallToken;

  // Call token retrieved successfully
  const factory CommunicationState.callTokenRetrieved({
    required String token,
    required String channelName,
    required int expiry,
    required String callType, // 'voice' or 'video'
  }) = CallTokenRetrieved;

  // Error getting call token
  const factory CommunicationState.callTokenError({required String error}) =
      CallTokenError;
}
