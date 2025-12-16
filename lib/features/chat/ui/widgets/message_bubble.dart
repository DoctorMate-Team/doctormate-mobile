import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/chat/data/models/chat_message_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessageModel message;
  final bool isMe;

  const MessageBubble({super.key, required this.message, required this.isMe});

  String _formatTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    return DateFormat('HH:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) ...[_buildAvatar(), horizantialSpacing(8)],
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                gradient:
                    isMe
                        ? LinearGradient(
                          colors: [
                            ColorsManager.primaryColor,
                            ColorsManager.primaryColor.withOpacity(0.8),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                        : null,
                color: isMe ? null : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18.r),
                  topRight: Radius.circular(18.r),
                  bottomLeft:
                      isMe ? Radius.circular(18.r) : Radius.circular(4.r),
                  bottomRight:
                      isMe ? Radius.circular(4.r) : Radius.circular(18.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.content ?? '',
                    style: TextStyles.font14DarkGreenMedium.copyWith(
                      color: isMe ? Colors.white : Colors.grey.shade800,
                      height: 1.5,
                    ),
                  ),
                  verticalSpacing(6),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _formatTime(message.timestamp),
                        style: TextStyles.font12DarkGreenRegular.copyWith(
                          color:
                              isMe
                                  ? Colors.white.withOpacity(0.8)
                                  : Colors.grey.shade500,
                        ),
                      ),
                      if (isMe) ...[
                        horizantialSpacing(4),
                        _buildMessageStatus(),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (isMe) ...[horizantialSpacing(8), _buildAvatar()],
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 32.w,
      height: 32.h,
      decoration: BoxDecoration(
        color:
            isMe
                ? ColorsManager.primaryColor.withOpacity(0.2)
                : Colors.grey.shade200,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Iconsax.user,
        color: isMe ? ColorsManager.primaryColor : Colors.grey.shade400,
        size: 16.sp,
      ),
    );
  }

  Widget _buildMessageStatus() {
    IconData icon;
    Color color;

    if (message.isRead ?? false) {
      icon = Iconsax.tick_circle;
      color = Colors.white;
    } else if (message.isDelivered ?? false) {
      icon = Iconsax.tick_circle;
      color = Colors.white.withOpacity(0.7);
    } else if (message.isSent ?? false) {
      icon = Iconsax.clock;
      color = Colors.white.withOpacity(0.7);
    } else {
      icon = Iconsax.clock;
      color = Colors.white.withOpacity(0.5);
    }

    return Icon(icon, color: color, size: 14.sp);
  }
}
