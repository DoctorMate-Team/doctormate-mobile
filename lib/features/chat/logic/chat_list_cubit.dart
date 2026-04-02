import 'package:doctor_mate/features/appointment/data/apis/appointment_manage_api_services.dart';
import 'package:doctor_mate/core/helper/cache_helper.dart';
import 'package:doctor_mate/features/chat/data/apis/chat_api_services.dart';
import 'package:doctor_mate/features/chat/data/models/chat_message_response.dart';
import 'package:doctor_mate/features/chat/data/services/firestore_chat_service.dart';
import 'package:doctor_mate/features/chat/logic/chat_list_state.dart';
import 'package:doctor_mate/features/profile/data/repos/profile_repos.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListCubit extends Cubit<ChatListState> {
  final AppointmentManageApiServices _appointmentApiServices;
  final ChatApiServices _chatApiServices;
  final FirestoreChatService _firestoreChatService;
  final ProfileRepos _profileRepos;

  ChatListCubit(
    this._appointmentApiServices,
    this._chatApiServices,
    this._firestoreChatService,
    this._profileRepos,
  ) : super(const ChatListState.initial());

  /// Load all conversations (appointments with active communication)
  Future<void> loadConversations() async {
    emit(const ChatListState.loading());

    try {
      // Read patient id from cache first to avoid an extra startup API call.
      String? patientId = await CacheHelper.getSecuredValue(
        'user_id',
        type: String,
      );
      String? patientName;
      String? patientImage;

      if (patientId == null || patientId.isEmpty) {
        final profileResult = await _profileRepos.getProfile();
        profileResult.when(
          success: (response) {
            patientId = response.data.id;
            patientName = response.data.fullName;
            patientImage = response.data.imageUrl;
          },
          failure: (_) {
            patientId = null;
            patientName = null;
            patientImage = null;
          },
        );
      }

      // Get confirmed and in-progress appointments
      final confirmedResponse = await _appointmentApiServices
          .getPatientAppointments(page: 1, limit: 50, status: 'confirmed');

      final inProgressResponse = await _appointmentApiServices
          .getPatientAppointments(page: 1, limit: 50, status: 'inprogress');

      // Combine both lists
      final allAppointments = [
        ...confirmedResponse.data.appointments,
        ...inProgressResponse.data.appointments,
      ];

      // Check communication status for each appointment
      final List<ChatConversationResponse> conversations = [];

      for (final appointment in allAppointments) {
        try {
          // Check if communication session exists
          final sessionResponse = await _chatApiServices
              .getCommunicationSessionByAppointment(
                appointmentId: appointment.id,
              );

          if (sessionResponse.code == 200 &&
              sessionResponse.data.status == 'active') {
            // Try to get last message from Firestore
            ChatMessageModel? lastMessage;
            int unreadCount = 0;

            try {
              // Get last message (limit 1)
              final messages =
                  await _firestoreChatService
                      .getMessagesStream(sessionResponse.data.sessionId)
                      .first;

              if (messages.isNotEmpty) {
                final firestoreMsg = messages.first;
                lastMessage = ChatMessageModel(
                  id: firestoreMsg.id,
                  content: firestoreMsg.content,
                  messageType: firestoreMsg.messageType,
                  senderType: firestoreMsg.senderType,
                  timestamp: firestoreMsg.timestamp,
                  isRead: firestoreMsg.isRead,
                );

                // Count unread messages (assuming patient views doctor messages)
                unreadCount =
                    messages
                        .where((m) => m.senderType == 'doctor' && !m.isRead)
                        .length;
              }
            } catch (e) {
              // Firestore might not have messages yet
              lastMessage = null;
              unreadCount = 0;
            }

            conversations.add(
              ChatConversationResponse(
                id: sessionResponse.data.sessionId,
                appointmentId: appointment.id,
                doctorId: appointment.doctor.id,
                doctorName: appointment.doctor.doctorName,
                doctorImage: appointment.doctor.image,
                doctorSpecialty: appointment.doctor.specialtyName,
                patientId: patientId,
                patientName: patientName,
                patientImage: patientImage,
                isOnline: true, // Can add real online status later
                unreadCount: unreadCount,
                status: sessionResponse.data.status,
                lastMessageTime:
                    lastMessage?.timestamp ?? appointment.appointmentDate,
                lastMessage: lastMessage,
              ),
            );
          }
        } catch (e) {
          // No session for this appointment, skip it
          continue;
        }
      }

      // Sort by last message time (most recent first)
      conversations.sort(
        (a, b) => (b.lastMessageTime ?? DateTime(2000)).compareTo(
          a.lastMessageTime ?? DateTime(2000),
        ),
      );

      emit(ChatListState.success(conversations: conversations));
    } catch (error) {
      emit(ChatListState.error(message: error.toString()));
    }
  }

  /// Refresh conversations
  Future<void> refreshConversations() async {
    await loadConversations();
  }
}
