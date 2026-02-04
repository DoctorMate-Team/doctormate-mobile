import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/chat/data/models/chat_message_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';

class ConversationCard extends StatelessWidget {
  final ChatConversationResponse conversation;
  final VoidCallback onTap;

  const ConversationCard({
    super.key,
    required this.conversation,
    required this.onTap,
  });

  String _formatTime(DateTime? dateTime) {
    if (dateTime == null) return '';

    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat('MMM dd').format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasUnread = (conversation.unreadCount ?? 0) > 0;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color:
              hasUnread
                  ? ColorsManager.primaryColor.withOpacity(0.3)
                  : Colors.grey.shade200,
          width: hasUnread ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Row(
              children: [
                _buildAvatar(),
                horizantialSpacing(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      verticalSpacing(6),
                      _buildLastMessage(),
                    ],
                  ),
                ),
                horizantialSpacing(8),
                _buildTrailing(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Stack(
      children: [
        Container(
          width: 56.w,
          height: 56.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: ColorsManager.primaryColor.withOpacity(0.2),
              width: 2,
            ),
          ),
          child: ClipOval(
            child:
                conversation.doctorImage != null
                    ? CachedNetworkImage(
                      imageUrl: conversation.doctorImage!,
                      fit: BoxFit.cover,
                      placeholder:
                          (context, url) => Container(
                            color: Colors.grey.shade200,
                            child: Icon(
                              Iconsax.user,
                              color: Colors.grey.shade400,
                              size: 28.sp,
                            ),
                          ),
                      errorWidget:
                          (context, url, error) => Container(
                            color: Colors.grey.shade200,
                            child: Icon(
                              Iconsax.user,
                              color: Colors.grey.shade400,
                              size: 28.sp,
                            ),
                          ),
                    )
                    : Container(
                      color: Colors.grey.shade200,
                      child: Icon(
                        Iconsax.user,
                        color: Colors.grey.shade400,
                        size: 28.sp,
                      ),
                    ),
          ),
        ),
        if (conversation.isOnline ?? false)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 14.w,
              height: 14.h,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Text(
            conversation.doctorName ?? 'Unknown',
            style: TextStyles.font16DarkGreenBold,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (conversation.doctorSpecialty != null) ...[
          horizantialSpacing(4),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: ColorsManager.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              conversation.doctorSpecialty!,
              style: TextStyles.font10DarkGreenRegular.copyWith(
                color: ColorsManager.primaryColor,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildLastMessage() {
    final message = conversation.lastMessage;
    if (message == null) return const SizedBox.shrink();

    IconData? messageIcon;
    if (message.messageType == 'image') {
      messageIcon = Iconsax.gallery;
    } else if (message.messageType == 'voice') {
      messageIcon = Iconsax.microphone;
    } else if (message.messageType == 'file') {
      messageIcon = Iconsax.document;
    }

    return Row(
      children: [
        if (messageIcon != null) ...[
          Icon(messageIcon, color: Colors.grey.shade600, size: 14.sp),
          horizantialSpacing(4),
        ],
        Expanded(
          child: Text(
            message.content ?? 'No message',
            style: TextStyles.font14DarkGreenMedium.copyWith(
              color:
                  (conversation.unreadCount ?? 0) > 0
                      ? Colors.grey.shade800
                      : Colors.grey.shade600,
              fontWeight:
                  (conversation.unreadCount ?? 0) > 0
                      ? FontWeight.w600
                      : FontWeight.normal,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildTrailing() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          _formatTime(conversation.lastMessageTime),
          style: TextStyles.font12DarkGreenRegular.copyWith(
            color:
                (conversation.unreadCount ?? 0) > 0
                    ? ColorsManager.primaryColor
                    : Colors.grey.shade600,
          ),
        ),
        if ((conversation.unreadCount ?? 0) > 0) ...[
          verticalSpacing(6),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: ColorsManager.primaryColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              '${conversation.unreadCount}',
              style: TextStyles.font12DarkGreenSemiBold.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
