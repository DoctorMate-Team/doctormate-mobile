import 'package:doctor_mate/features/chat/data/apis/chat_api_services.dart';
import 'package:doctor_mate/features/chat/logic/communication_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunicationCubit extends Cubit<CommunicationState> {
  final ChatApiServices _chatApiServices;

  CommunicationCubit(this._chatApiServices)
    : super(const CommunicationState.initial());

  /// Check if communication session is available for the appointment
  /// Step 1: Check Communication Availability
  Future<void> checkSessionAvailability(String appointmentId) async {
    emit(const CommunicationState.checkingSession());

    try {
      final response = await _chatApiServices
          .getCommunicationSessionByAppointment(appointmentId: appointmentId);

      if (response.code == 200 && response.data.status == 'active') {
        // Session is active - enable communication
        emit(
          CommunicationState.sessionActive(
            sessionId: response.data.sessionId,
            channelName:
                response.data.sessionId, // Use sessionId as channel name
            sessionType: response.data.type, // 'chat', 'voice', or 'video'
          ),
        );
      } else {
        // No session or session not active
        emit(
          const CommunicationState.sessionNotAvailable(
            message: 'Communication will be available near appointment time',
          ),
        );
      }
    } catch (error) {
      // Handle 404 or any other error
      if (error.toString().contains('404')) {
        emit(
          const CommunicationState.sessionNotAvailable(
            message: 'Communication will be available near appointment time',
          ),
        );
      } else {
        emit(CommunicationState.sessionCheckError(error: error.toString()));
      }
    }
  }

  /// Get call token for voice or video call
  /// Step 3: Start Call (Voice / Video)
  Future<void> getCallToken({
    required String appointmentId,
    required String callType, // 'voice' or 'video'
  }) async {
    emit(const CommunicationState.gettingCallToken());

    try {
      final response = await _chatApiServices.getCallToken(
        body: {'appointmentId': appointmentId},
      );

      if (response.code == 200) {
        // Calculate expiry in seconds
        final now = DateTime.now();
        final expirySeconds = response.data.expiresAt.difference(now).inSeconds;
        final resolvedCallType = response.data.callType ?? callType;

        emit(
          CommunicationState.callTokenRetrieved(
            token: response.data.token,
            channelName: response.data.channel,
            expiry: expirySeconds > 0 ? expirySeconds : 3600, // Default 1 hour
            callType: resolvedCallType,
          ),
        );
      } else {
        emit(CommunicationState.callTokenError(error: response.message));
      }
    } catch (error) {
      emit(CommunicationState.callTokenError(error: error.toString()));
    }
  }

  /// Reset state to initial
  void resetState() {
    emit(const CommunicationState.initial());
  }

  /// Reset to session active state (after call token flow completes)
  void returnToSessionActive(
    String sessionId,
    String channelName,
    String sessionType,
  ) {
    emit(
      CommunicationState.sessionActive(
        sessionId: sessionId,
        channelName: channelName,
        sessionType: sessionType,
      ),
    );
  }
}
