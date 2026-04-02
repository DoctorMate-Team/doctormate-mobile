import 'package:json_annotation/json_annotation.dart';

part 'chat_message_response.g.dart';

@JsonSerializable()
class ChatConversationResponse {
  final String? id;
  final String? appointmentId;
  final String? patientId;
  final String? patientName;
  final String? patientImage;
  final String? doctorId;
  final String? doctorName;
  final String? doctorImage;
  final String? doctorSpecialty;
  final ChatMessageModel? lastMessage;
  final int? unreadCount;
  final DateTime? lastMessageTime;
  final bool? isOnline;
  final String? status; // 'active', 'archived', 'blocked'

  ChatConversationResponse({
    this.id,
    this.appointmentId,
    this.patientId,
    this.patientName,
    this.patientImage,
    this.doctorId,
    this.doctorName,
    this.doctorImage,
    this.doctorSpecialty,
    this.lastMessage,
    this.unreadCount,
    this.lastMessageTime,
    this.isOnline,
    this.status,
  });

  factory ChatConversationResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatConversationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChatConversationResponseToJson(this);
}

@JsonSerializable()
class ChatMessageModel {
  final String? id;
  final String? conversationId;
  final String? senderId;
  final String? senderName;
  final String? senderType; // 'patient' or 'doctor'
  final String? messageType; // 'text', 'image', 'voice', 'file'
  final String? content;
  final String? fileUrl;
  final DateTime? timestamp;
  final bool? isRead;
  final bool? isSent;
  final bool? isDelivered;

  ChatMessageModel({
    this.id,
    this.conversationId,
    this.senderId,
    this.senderName,
    this.senderType,
    this.messageType,
    this.content,
    this.fileUrl,
    this.timestamp,
    this.isRead,
    this.isSent,
    this.isDelivered,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageModelToJson(this);
}

@JsonSerializable()
class CallHistoryModel {
  final String? id;
  final String? conversationId;
  final String? callType; // 'voice', 'video'
  final String? initiatorId;
  final String? initiatorName;
  final DateTime? startTime;
  final DateTime? endTime;
  final int? durationSeconds;
  final String? status; // 'completed', 'missed', 'declined', 'failed'

  CallHistoryModel({
    this.id,
    this.conversationId,
    this.callType,
    this.initiatorId,
    this.initiatorName,
    this.startTime,
    this.endTime,
    this.durationSeconds,
    this.status,
  });

  factory CallHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$CallHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CallHistoryModelToJson(this);
}
