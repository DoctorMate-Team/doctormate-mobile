// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatConversationResponse _$ChatConversationResponseFromJson(
  Map<String, dynamic> json,
) => ChatConversationResponse(
  id: json['id'] as String?,
  appointmentId: json['appointmentId'] as String?,
  patientId: json['patientId'] as String?,
  patientName: json['patientName'] as String?,
  patientImage: json['patientImage'] as String?,
  doctorId: json['doctorId'] as String?,
  doctorName: json['doctorName'] as String?,
  doctorImage: json['doctorImage'] as String?,
  doctorSpecialty: json['doctorSpecialty'] as String?,
  lastMessage:
      json['lastMessage'] == null
          ? null
          : ChatMessageModel.fromJson(
            json['lastMessage'] as Map<String, dynamic>,
          ),
  unreadCount: (json['unreadCount'] as num?)?.toInt(),
  lastMessageTime:
      json['lastMessageTime'] == null
          ? null
          : DateTime.parse(json['lastMessageTime'] as String),
  isOnline: json['isOnline'] as bool?,
  status: json['status'] as String?,
);

Map<String, dynamic> _$ChatConversationResponseToJson(
  ChatConversationResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'appointmentId': instance.appointmentId,
  'patientId': instance.patientId,
  'patientName': instance.patientName,
  'patientImage': instance.patientImage,
  'doctorId': instance.doctorId,
  'doctorName': instance.doctorName,
  'doctorImage': instance.doctorImage,
  'doctorSpecialty': instance.doctorSpecialty,
  'lastMessage': instance.lastMessage,
  'unreadCount': instance.unreadCount,
  'lastMessageTime': instance.lastMessageTime?.toIso8601String(),
  'isOnline': instance.isOnline,
  'status': instance.status,
};

ChatMessageModel _$ChatMessageModelFromJson(Map<String, dynamic> json) =>
    ChatMessageModel(
      id: json['id'] as String?,
      conversationId: json['conversationId'] as String?,
      senderId: json['senderId'] as String?,
      senderName: json['senderName'] as String?,
      senderType: json['senderType'] as String?,
      messageType: json['messageType'] as String?,
      content: json['content'] as String?,
      fileUrl: json['fileUrl'] as String?,
      timestamp:
          json['timestamp'] == null
              ? null
              : DateTime.parse(json['timestamp'] as String),
      isRead: json['isRead'] as bool?,
      isSent: json['isSent'] as bool?,
      isDelivered: json['isDelivered'] as bool?,
    );

Map<String, dynamic> _$ChatMessageModelToJson(ChatMessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'conversationId': instance.conversationId,
      'senderId': instance.senderId,
      'senderName': instance.senderName,
      'senderType': instance.senderType,
      'messageType': instance.messageType,
      'content': instance.content,
      'fileUrl': instance.fileUrl,
      'timestamp': instance.timestamp?.toIso8601String(),
      'isRead': instance.isRead,
      'isSent': instance.isSent,
      'isDelivered': instance.isDelivered,
    };

CallHistoryModel _$CallHistoryModelFromJson(Map<String, dynamic> json) =>
    CallHistoryModel(
      id: json['id'] as String?,
      conversationId: json['conversationId'] as String?,
      callType: json['callType'] as String?,
      initiatorId: json['initiatorId'] as String?,
      initiatorName: json['initiatorName'] as String?,
      startTime:
          json['startTime'] == null
              ? null
              : DateTime.parse(json['startTime'] as String),
      endTime:
          json['endTime'] == null
              ? null
              : DateTime.parse(json['endTime'] as String),
      durationSeconds: (json['durationSeconds'] as num?)?.toInt(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$CallHistoryModelToJson(CallHistoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'conversationId': instance.conversationId,
      'callType': instance.callType,
      'initiatorId': instance.initiatorId,
      'initiatorName': instance.initiatorName,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'durationSeconds': instance.durationSeconds,
      'status': instance.status,
    };
