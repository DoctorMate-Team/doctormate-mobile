import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreMessageModel {
  final String id;
  final String sessionId;
  final String content;
  final String senderId;
  final String senderType;
  final String messageType;
  final DateTime timestamp;
  final bool isRead;
  final bool? isDeleted;
  final DateTime? deletedAt;

  FirestoreMessageModel({
    required this.id,
    required this.sessionId,
    required this.content,
    required this.senderId,
    required this.senderType,
    required this.messageType,
    required this.timestamp,
    required this.isRead,
    this.isDeleted,
    this.deletedAt,
  });

  factory FirestoreMessageModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FirestoreMessageModel(
      id: doc.id,
      sessionId: data['sessionId'] as String? ?? '',
      content: data['content'] as String? ?? data['text'] as String? ?? '',
      senderId: data['senderId'] as String? ?? '',
      senderType: data['senderType'] as String? ?? 'patient',
      messageType:
          data['messageType'] as String? ?? data['type'] as String? ?? 'text',
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      isRead: data['isRead'] as bool? ?? false,
      isDeleted: data['isDeleted'] as bool?,
      deletedAt: (data['deletedAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'sessionId': sessionId,
      'content': content,
      'text': content, // Added to match other platform
      'senderId': senderId,
      'senderType': senderType,
      'messageType': messageType,
      'type': messageType, // Added to match other platform
      'timestamp': Timestamp.fromDate(timestamp),
      'createdAt':
          DateTime.now()
              .toUtc()
              .toIso8601String(), // Optional: Match other's expected keys
      'isRead': isRead,
      if (isDeleted != null) 'isDeleted': isDeleted,
      if (deletedAt != null) 'deletedAt': Timestamp.fromDate(deletedAt!),
    };
  }

  bool get isPatientMessage => senderType == 'patient';
  bool get isDoctorMessage => senderType == 'doctor';
  bool get isTextMessage => messageType == 'text';
  bool get isImageMessage => messageType == 'image';
  bool get isFileMessage => messageType == 'file';

  String get formattedTime {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }

  FirestoreMessageModel copyWith({
    String? id,
    String? sessionId,
    String? content,
    String? senderId,
    String? senderType,
    String? messageType,
    DateTime? timestamp,
    bool? isRead,
    bool? isDeleted,
    DateTime? deletedAt,
  }) {
    return FirestoreMessageModel(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      content: content ?? this.content,
      senderId: senderId ?? this.senderId,
      senderType: senderType ?? this.senderType,
      messageType: messageType ?? this.messageType,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
      isDeleted: isDeleted ?? this.isDeleted,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
}
