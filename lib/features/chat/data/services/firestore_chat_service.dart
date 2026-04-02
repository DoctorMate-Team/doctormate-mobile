import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_mate/features/chat/data/models/firestore_message_model.dart';

class FirestoreChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection references
  CollectionReference get _sessionsCollection =>
      _firestore.collection('chat_sessions');

  /// Get messages stream for a session (real-time)
  Stream<List<FirestoreMessageModel>> getMessagesStream(String sessionId) {
    return _sessionsCollection
        .doc(sessionId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => FirestoreMessageModel.fromFirestore(doc))
              .toList();
        });
  }

  /// Send a text message
  Future<void> sendMessage({
    required String sessionId,
    required String content,
    required String senderId,
    required String senderType, // 'patient' or 'doctor'
    String messageType = 'text',
  }) async {
    try {
      final messageRef =
          _sessionsCollection.doc(sessionId).collection('messages').doc();

      final message = FirestoreMessageModel(
        id: messageRef.id,
        sessionId: sessionId,
        content: content,
        senderId: senderId,
        senderType: senderType,
        messageType: messageType,
        timestamp: DateTime.now(),
        isRead: false,
      );

      // Create message
      await messageRef.set(message.toFirestore());

      // Update session last message time (or create if doesn't exist)
      await _sessionsCollection.doc(sessionId).set({
        'lastMessageAt': FieldValue.serverTimestamp(),
        'lastMessage': content,
        'lastMessageSenderId': senderId,
      }, SetOptions(merge: true));
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  /// Mark message as read
  Future<void> markMessageAsRead(String sessionId, String messageId) async {
    try {
      await _sessionsCollection
          .doc(sessionId)
          .collection('messages')
          .doc(messageId)
          .update({'isRead': true});
    } catch (e) {
      throw Exception('Failed to mark message as read: $e');
    }
  }

  /// Mark all messages as read for current user
  Future<void> markAllMessagesAsRead(
    String sessionId,
    String currentUserId,
  ) async {
    try {
      final messagesSnapshot =
          await _sessionsCollection.doc(sessionId).collection('messages').get();

      final batch = _firestore.batch();
      for (var doc in messagesSnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>?;
        if (data != null &&
            data['senderId'] != currentUserId &&
            data['isRead'] == false) {
          batch.update(doc.reference, {'isRead': true});
        }
      }
      await batch.commit();
    } catch (e) {
      throw Exception('Failed to mark messages as read: $e');
    }
  }

  /// Get unread messages count
  Stream<int> getUnreadCountStream(String sessionId, String currentUserId) {
    return _sessionsCollection
        .doc(sessionId)
        .collection('messages')
        .snapshots()
        .map((snapshot) {
          int count = 0;
          for (var doc in snapshot.docs) {
            final data = doc.data() as Map<String, dynamic>?;
            if (data != null &&
                data['senderId'] != currentUserId &&
                data['isRead'] == false) {
              count++;
            }
          }
          return count;
        });
  }

  /// Check if session exists and is active
  Future<bool> isSessionActive(String sessionId) async {
    try {
      final doc = await _sessionsCollection.doc(sessionId).get();
      if (!doc.exists) return false;

      final data = doc.data() as Map<String, dynamic>?;
      return data?['status'] == 'active';
    } catch (e) {
      return false;
    }
  }

  /// Get session info
  Future<Map<String, dynamic>?> getSessionInfo(String sessionId) async {
    try {
      final doc = await _sessionsCollection.doc(sessionId).get();
      if (!doc.exists) return null;
      return doc.data() as Map<String, dynamic>?;
    } catch (e) {
      return null;
    }
  }

  /// Listen to session status changes
  Stream<String?> getSessionStatusStream(String sessionId) {
    return _sessionsCollection.doc(sessionId).snapshots().map((snapshot) {
      if (!snapshot.exists) return null;
      final data = snapshot.data() as Map<String, dynamic>?;
      return data?['status'] as String?;
    });
  }

  /// Delete message (soft delete - mark as deleted)
  Future<void> deleteMessage(String sessionId, String messageId) async {
    try {
      await _sessionsCollection
          .doc(sessionId)
          .collection('messages')
          .doc(messageId)
          .update({
            'isDeleted': true,
            'deletedAt': FieldValue.serverTimestamp(),
          });
    } catch (e) {
      throw Exception('Failed to delete message: $e');
    }
  }

  /// Send image message
  Future<void> sendImageMessage({
    required String sessionId,
    required String imageUrl,
    required String senderId,
    required String senderType,
    String? caption,
  }) async {
    await sendMessage(
      sessionId: sessionId,
      content: imageUrl,
      senderId: senderId,
      senderType: senderType,
      messageType: 'image',
    );
  }

  /// Send file message
  Future<void> sendFileMessage({
    required String sessionId,
    required String fileUrl,
    required String fileName,
    required String senderId,
    required String senderType,
  }) async {
    await sendMessage(
      sessionId: sessionId,
      content: fileUrl,
      senderId: senderId,
      senderType: senderType,
      messageType: 'file',
    );
  }
}
