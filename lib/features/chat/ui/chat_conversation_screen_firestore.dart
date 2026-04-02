import 'package:doctor_mate/core/di/dependency_injection.dart';
import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/chat/data/models/chat_message_response.dart';
import 'package:doctor_mate/features/chat/data/models/firestore_message_model.dart';
import 'package:doctor_mate/features/chat/data/services/firestore_chat_service.dart';
import 'package:doctor_mate/features/chat/ui/widgets/chat_app_bar.dart';
import 'package:doctor_mate/features/chat/ui/widgets/message_input.dart';
import 'package:doctor_mate/features/profile/data/repos/profile_repos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ChatConversationScreenFirestore extends StatefulWidget {
  final ChatConversationResponse conversation;

  const ChatConversationScreenFirestore({
    super.key,
    required this.conversation,
  });

  @override
  State<ChatConversationScreenFirestore> createState() =>
      _ChatConversationScreenFirestoreState();
}

class _ChatConversationScreenFirestoreState
    extends State<ChatConversationScreenFirestore> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FirestoreChatService _chatService = FirestoreChatService();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  String? _currentUserId;
  bool _isSessionActive = false;
  bool _isCheckingSession = true;

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _initializeChat() async {
    try {
      // Get current user ID from secure storage or conversation
      _currentUserId = await _secureStorage.read(key: 'user_id');

      // If not in secure storage, try from conversation
      if (_currentUserId == null || _currentUserId!.isEmpty) {
        _currentUserId = widget.conversation.patientId;
      }

      // If still null, fetch from profile as fallback
      if (_currentUserId == null || _currentUserId!.isEmpty) {
        try {
          final profileRepos = getIt<ProfileRepos>();
          final result = await profileRepos.getProfile();
          result.when(
            success: (response) async {
              _currentUserId = response.data.id;
              // Save for future use
              await _secureStorage.write(
                key: 'user_id',
                value: response.data.id,
              );
            },
            failure: (_) {
              _currentUserId = null;
            },
          );
        } catch (e) {
          _currentUserId = null;
        }
      }

      // Use sessionId (id field) or fallback to appointmentId
      final sessionId =
          widget.conversation.id ?? widget.conversation.appointmentId ?? '';

      if (sessionId.isEmpty) {
        setState(() {
          _isCheckingSession = false;
          _isSessionActive = false;
        });
        return;
      }

      // Session is active if we have a valid sessionId
      // The backend controls session creation, so if we're here with an id, it's active
      setState(() {
        _isSessionActive = true;
        _isCheckingSession = false;
      });

      // Mark messages as read
      await _chatService.markAllMessagesAsRead(sessionId, _currentUserId!);

      // Scroll to bottom after messages load
      Future.delayed(const Duration(milliseconds: 500), _scrollToBottom);
    } catch (e) {
      setState(() {
        _isCheckingSession = false;
        _isSessionActive = true; // Still allow chat even if mark as read fails
      });
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _sendMessage() async {
    final content = _messageController.text.trim();
    if (content.isEmpty || _currentUserId == null) return;

    final sessionId =
        widget.conversation.id ?? widget.conversation.appointmentId ?? '';
    if (sessionId.isEmpty) return;

    try {
      await _chatService.sendMessage(
        sessionId: sessionId,
        content: content,
        senderId: _currentUserId!,
        senderType: 'patient',
        messageType: 'text',
      );

      _messageController.clear();
      _scrollToBottom();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send message: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Column(
          children: [
            ChatAppBar(
              conversation: widget.conversation,
              onCallTap: _isSessionActive ? _showCallOptions : () {},
            ),
            Expanded(
              child:
                  _isCheckingSession
                      ? _buildLoadingState()
                      : !_isSessionActive
                      ? _buildSessionInactiveState()
                      : Column(
                        children: [
                          Expanded(child: _buildMessagesStream()),
                          MessageInput(
                            controller: _messageController,
                            onSend: _sendMessage,
                          ),
                        ],
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: ColorsManager.primaryColor),
          verticalSpacing(16),
          Text(
            'Checking session availability...',
            style: TextStyles.font14GrayRegular,
          ),
        ],
      ),
    );
  }

  Widget _buildSessionInactiveState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120.w,
              height: 120.h,
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Iconsax.lock,
                size: 56.sp,
                color: Colors.orange.shade400,
              ),
            ),
            verticalSpacing(24),
            Text(
              'Communication Not Available',
              style: TextStyles.font18DarkGreenBold,
              textAlign: TextAlign.center,
            ),
            verticalSpacing(12),
            Text(
              'Chat will be available near your appointment time. The doctor will start the session when ready.',
              style: TextStyles.font14GrayRegular,
              textAlign: TextAlign.center,
            ),
            verticalSpacing(24),
            Text(
              'Appointment: ${widget.conversation.appointmentId}',
              style: TextStyles.font12GrayRegular.copyWith(
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessagesStream() {
    final sessionId =
        widget.conversation.id ?? widget.conversation.appointmentId ?? '';
    return StreamBuilder<List<FirestoreMessageModel>>(
      stream: _chatService.getMessagesStream(sessionId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: ColorsManager.primaryColor),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 48.sp, color: Colors.red),
                verticalSpacing(16),
                Text(
                  'Failed to load messages',
                  style: TextStyles.font16DarkGreenBold,
                ),
                verticalSpacing(8),
                Text(
                  snapshot.error.toString(),
                  style: TextStyles.font14GrayRegular,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        final messages = snapshot.data ?? [];

        if (messages.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Iconsax.message_text,
                  size: 64.sp,
                  color: Colors.grey.shade300,
                ),
                verticalSpacing(16),
                Text(
                  'No messages yet',
                  style: TextStyles.font16DarkGreenBold.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
                verticalSpacing(8),
                Text(
                  'Start the conversation',
                  style: TextStyles.font14GrayRegular,
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          controller: _scrollController,
          reverse: true,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            final isMyMessage = message.senderId == _currentUserId;
            final showAvatar = _shouldShowAvatar(messages, index);

            return _buildMessageBubble(message, isMyMessage, showAvatar);
          },
        );
      },
    );
  }

  bool _shouldShowAvatar(List<FirestoreMessageModel> messages, int index) {
    if (index == 0) return true;
    final currentMessage = messages[index];
    final previousMessage = messages[index - 1];
    return currentMessage.senderId != previousMessage.senderId;
  }

  Widget _buildMessageBubble(
    FirestoreMessageModel message,
    bool isMyMessage,
    bool showAvatar,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment:
            isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMyMessage && showAvatar) ...[
            CircleAvatar(
              radius: 16.r,
              backgroundImage:
                  widget.conversation.doctorImage != null
                      ? NetworkImage(widget.conversation.doctorImage!)
                      : null,
              child:
                  widget.conversation.doctorImage == null
                      ? Icon(Icons.person, size: 20.sp)
                      : null,
            ),
            horizantialSpacing(8),
          ],
          if (!isMyMessage && !showAvatar) SizedBox(width: 40.w),
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: isMyMessage ? ColorsManager.primaryColor : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                  bottomLeft: Radius.circular(isMyMessage ? 16.r : 4.r),
                  bottomRight: Radius.circular(isMyMessage ? 4.r : 16.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (message.isImageMessage)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.network(
                        message.content,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 200.h,
                            color: Colors.grey.shade200,
                            child: Icon(Icons.broken_image, size: 48.sp),
                          );
                        },
                      ),
                    )
                  else
                    Text(
                      message.content,
                      style: TextStyles.font14DarkGreenMedium.copyWith(
                        color: isMyMessage ? Colors.white : Colors.black87,
                      ),
                    ),
                  verticalSpacing(4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        message.formattedTime,
                        style: TextStyles.font12GrayRegular.copyWith(
                          color:
                              isMyMessage
                                  ? Colors.white.withOpacity(0.7)
                                  : Colors.grey.shade500,
                          fontSize: 11.sp,
                        ),
                      ),
                      if (isMyMessage) ...[
                        horizantialSpacing(4),
                        Icon(
                          message.isRead ? Icons.done_all : Icons.done,
                          size: 14.sp,
                          color:
                              message.isRead
                                  ? Colors.blue.shade200
                                  : Colors.white.withOpacity(0.7),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (isMyMessage && showAvatar) ...[
            horizantialSpacing(8),
            CircleAvatar(
              radius: 16.r,
              backgroundImage:
                  widget.conversation.patientImage != null
                      ? NetworkImage(widget.conversation.patientImage!)
                      : null,
              child:
                  widget.conversation.patientImage == null
                      ? Icon(Icons.person, size: 20.sp)
                      : null,
            ),
          ],
          if (isMyMessage && !showAvatar) SizedBox(width: 40.w),
        ],
      ),
    );
  }

  void _showCallOptions() {
    // TODO: Implement call options bottom sheet
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Start a Call', style: TextStyles.font18DarkGreenBold),
              verticalSpacing(24),
              // Voice Call Option
              ListTile(
                leading: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(Iconsax.call, color: Colors.green, size: 24.sp),
                ),
                title: Text(
                  'Voice Call',
                  style: TextStyles.font16DarkGreenBold,
                ),
                subtitle: Text(
                  'Start an audio call',
                  style: TextStyles.font14GrayRegular,
                ),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Start voice call
                },
              ),
              verticalSpacing(12),
              // Video Call Option
              ListTile(
                leading: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(Iconsax.video, color: Colors.blue, size: 24.sp),
                ),
                title: Text(
                  'Video Call',
                  style: TextStyles.font16DarkGreenBold,
                ),
                subtitle: Text(
                  'Start a video call',
                  style: TextStyles.font14GrayRegular,
                ),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Start video call
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
