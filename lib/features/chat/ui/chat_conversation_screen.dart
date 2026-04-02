import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:doctor_mate/features/chat/data/models/chat_message_response.dart';
import 'package:doctor_mate/features/chat/ui/widgets/chat_app_bar.dart';
import 'package:doctor_mate/features/chat/ui/widgets/message_bubble.dart';
import 'package:doctor_mate/features/chat/ui/widgets/message_input.dart';
import 'package:doctor_mate/features/chat/ui/widgets/call_options_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ChatConversationScreen extends StatefulWidget {
  final ChatConversationResponse conversation;

  const ChatConversationScreen({super.key, required this.conversation});

  @override
  State<ChatConversationScreen> createState() => _ChatConversationScreenState();
}

class _ChatConversationScreenState extends State<ChatConversationScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessageModel> _messages = [];
  bool _isTyping = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMessages() {
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _messages.addAll(_getMockMessages());
          _isLoading = false;
        });
        _scrollToBottom();
      }
    });
  }

  List<ChatMessageModel> _getMockMessages() {
    final now = DateTime.now();
    return [
      ChatMessageModel(
        id: 'MSG1',
        conversationId: widget.conversation.id,
        senderId: widget.conversation.doctorId,
        senderName: widget.conversation.doctorName,
        senderType: 'doctor',
        messageType: 'text',
        content: 'Hello! How can I help you today?',
        timestamp: now.subtract(const Duration(hours: 3)),
        isRead: true,
        isSent: true,
        isDelivered: true,
      ),
      ChatMessageModel(
        id: 'MSG2',
        conversationId: widget.conversation.id,
        senderId: widget.conversation.patientId,
        senderName: widget.conversation.patientName,
        senderType: 'patient',
        messageType: 'text',
        content: 'Hi Doctor, I\'ve been experiencing some headaches lately.',
        timestamp: now.subtract(const Duration(hours: 3, minutes: -2)),
        isRead: true,
        isSent: true,
        isDelivered: true,
      ),
      ChatMessageModel(
        id: 'MSG3',
        conversationId: widget.conversation.id,
        senderId: widget.conversation.patientId,
        senderName: widget.conversation.patientName,
        senderType: 'patient',
        messageType: 'text',
        content:
            'They usually occur in the evening and last for about 2-3 hours.',
        timestamp: now.subtract(const Duration(hours: 3, minutes: -3)),
        isRead: true,
        isSent: true,
        isDelivered: true,
      ),
      ChatMessageModel(
        id: 'MSG4',
        conversationId: widget.conversation.id,
        senderId: widget.conversation.doctorId,
        senderName: widget.conversation.doctorName,
        senderType: 'doctor',
        messageType: 'text',
        content:
            'I understand. How long have you been experiencing these headaches?',
        timestamp: now.subtract(const Duration(hours: 2, minutes: 55)),
        isRead: true,
        isSent: true,
        isDelivered: true,
      ),
      ChatMessageModel(
        id: 'MSG5',
        conversationId: widget.conversation.id,
        senderId: widget.conversation.patientId,
        senderName: widget.conversation.patientName,
        senderType: 'patient',
        messageType: 'text',
        content: 'For about a week now. It\'s been quite uncomfortable.',
        timestamp: now.subtract(const Duration(hours: 2, minutes: 50)),
        isRead: true,
        isSent: true,
        isDelivered: true,
      ),
      ChatMessageModel(
        id: 'MSG6',
        conversationId: widget.conversation.id,
        senderId: widget.conversation.doctorId,
        senderName: widget.conversation.doctorName,
        senderType: 'doctor',
        messageType: 'text',
        content:
            'I see. Have you noticed any triggers? Like stress, lack of sleep, or certain foods?',
        timestamp: now.subtract(const Duration(hours: 2, minutes: 48)),
        isRead: true,
        isSent: true,
        isDelivered: true,
      ),
      ChatMessageModel(
        id: 'MSG7',
        conversationId: widget.conversation.id,
        senderId: widget.conversation.patientId,
        senderName: widget.conversation.patientName,
        senderType: 'patient',
        messageType: 'text',
        content:
            'Now that you mention it, I have been under a lot of stress at work recently.',
        timestamp: now.subtract(const Duration(hours: 2, minutes: 45)),
        isRead: true,
        isSent: true,
        isDelivered: true,
      ),
      ChatMessageModel(
        id: 'MSG8',
        conversationId: widget.conversation.id,
        senderId: widget.conversation.doctorId,
        senderName: widget.conversation.doctorName,
        senderType: 'doctor',
        messageType: 'text',
        content:
            'That could definitely be a contributing factor. I\'d like to recommend a few things:\n\n1. Try to get at least 7-8 hours of sleep\n2. Practice stress management techniques like meditation\n3. Stay hydrated throughout the day\n4. I\'ll prescribe a mild pain reliever for when the headaches occur',
        timestamp: now.subtract(const Duration(hours: 2, minutes: 40)),
        isRead: true,
        isSent: true,
        isDelivered: true,
      ),
      ChatMessageModel(
        id: 'MSG9',
        conversationId: widget.conversation.id,
        senderId: widget.conversation.patientId,
        senderName: widget.conversation.patientName,
        senderType: 'patient',
        messageType: 'text',
        content:
            'Thank you doctor, I\'ll follow your advice. Should I schedule a follow-up if they continue?',
        timestamp: now.subtract(const Duration(minutes: 10)),
        isRead: true,
        isSent: true,
        isDelivered: true,
      ),
      ChatMessageModel(
        id: 'MSG10',
        conversationId: widget.conversation.id,
        senderId: widget.conversation.doctorId,
        senderName: widget.conversation.doctorName,
        senderType: 'doctor',
        messageType: 'text',
        content:
            'Yes, if the headaches persist for more than 2 weeks or get worse, please schedule a follow-up appointment. Feel free to message me anytime if you have concerns.',
        timestamp: now.subtract(const Duration(minutes: 5)),
        isRead: false,
        isSent: true,
        isDelivered: true,
      ),
    ];
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final newMessage = ChatMessageModel(
      id: 'MSG${_messages.length + 1}',
      conversationId: widget.conversation.id,
      senderId: widget.conversation.patientId,
      senderName: widget.conversation.patientName,
      senderType: 'patient',
      messageType: 'text',
      content: text,
      timestamp: DateTime.now(),
      isRead: false,
      isSent: true,
      isDelivered: false,
    );

    setState(() {
      _messages.add(newMessage);
      _messageController.clear();
    });

    _scrollToBottom();

    // Simulate message delivery
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          final index = _messages.indexWhere((m) => m.id == newMessage.id);
          if (index != -1) {
            _messages[index] = ChatMessageModel(
              id: newMessage.id,
              conversationId: newMessage.conversationId,
              senderId: newMessage.senderId,
              senderName: newMessage.senderName,
              senderType: newMessage.senderType,
              messageType: newMessage.messageType,
              content: newMessage.content,
              timestamp: newMessage.timestamp,
              isRead: false,
              isSent: true,
              isDelivered: true,
            );
          }
        });
      }
    });

    // Simulate typing indicator
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isTyping = true;
        });

        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) {
            setState(() {
              _isTyping = false;
            });
          }
        });
      }
    });
  }

  void _showCallOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder:
          (context) => CallOptionsSheet(
            conversation: widget.conversation,
            onVoiceCall: () {
              context.pop();
              _showCallDialog('Voice Call');
            },
            onVideoCall: () {
              context.pop();
              _showCallDialog('Video Call');
            },
          ),
    );
  }

  void _showCallDialog(String callType) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 80.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF34A853), Color(0xFF2E7D32)],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      callType == 'Voice Call' ? Iconsax.call : Iconsax.video,
                      color: Colors.white,
                      size: 36.sp,
                    ),
                  ),
                  verticalSpacing(20),
                  Text(
                    '$callType Feature',
                    style: TextStyles.font18DarkGreenBold,
                  ),
                  verticalSpacing(12),
                  Text(
                    'This feature will be available soon. You\'ll be able to make ${callType.toLowerCase()}s with your doctor directly from the app.',
                    style: TextStyles.font14DarkGreenMedium.copyWith(
                      color: Colors.grey.shade600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  verticalSpacing(24),
                  CustomMaterialButton(
                    textButton: 'Got it',
                    onPressed: () => context.pop(),
                    height: 44.h,
                    raduisBorder: 10,
                  ),
                ],
              ),
            ),
          ),
    );
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
              onCallTap: _showCallOptions,
            ),
            Expanded(
              child:
                  _isLoading
                      ? Center(
                        child: CircularProgressIndicator(
                          color: ColorsManager.primaryColor,
                        ),
                      )
                      : _buildMessageList(),
            ),
            if (_isTyping) _buildTypingIndicator(),
            MessageInput(controller: _messageController, onSend: _sendMessage),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];
        final isMe = message.senderType == 'patient';
        final showDate =
            index == 0 ||
            !_isSameDay(message.timestamp, _messages[index - 1].timestamp);

        return Column(
          children: [
            if (showDate) _buildDateDivider(message.timestamp),
            MessageBubble(message: message, isMe: isMe),
          ],
        );
      },
    );
  }

  bool _isSameDay(DateTime? date1, DateTime? date2) {
    if (date1 == null || date2 == null) return false;
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Widget _buildDateDivider(DateTime? dateTime) {
    if (dateTime == null) return const SizedBox.shrink();

    String dateText;
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      dateText = 'Today';
    } else if (difference.inDays == 1) {
      dateText = 'Yesterday';
    } else {
      dateText = '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        children: [
          Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Text(
              dateText,
              style: TextStyles.font12DarkGreenRegular.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
          ),
          Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: Icon(Iconsax.user, color: Colors.grey.shade400, size: 20.sp),
          ),
          horizantialSpacing(12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(color: Colors.grey.shade300, width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTypingDot(0),
                horizantialSpacing(4),
                _buildTypingDot(200),
                horizantialSpacing(4),
                _buildTypingDot(400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingDot(int delay) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      builder: (context, value, child) {
        return Container(
          width: 8.w,
          height: 8.h,
          decoration: BoxDecoration(
            color: Colors.grey.shade400.withOpacity(value),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}
