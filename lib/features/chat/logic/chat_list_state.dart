import 'package:doctor_mate/features/chat/data/models/chat_message_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_list_state.freezed.dart';

@freezed
class ChatListState with _$ChatListState {
  const factory ChatListState.initial() = _Initial;
  const factory ChatListState.loading() = _Loading;
  const factory ChatListState.success({
    required List<ChatConversationResponse> conversations,
  }) = _Success;
  const factory ChatListState.error({required String message}) = _Error;
}
