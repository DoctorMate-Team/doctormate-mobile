import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/chat/data/models/chat_message_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CallOptionsSheet extends StatelessWidget {
  final ChatConversationResponse conversation;
  final VoidCallback onVoiceCall;
  final VoidCallback onVideoCall;

  const CallOptionsSheet({
    super.key,
    required this.conversation,
    required this.onVoiceCall,
    required this.onVideoCall,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHandle(),
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                Text('Call Options', style: TextStyles.font18DarkGreenBold),
                verticalSpacing(8),
                Text(
                  'Choose how you\'d like to connect',
                  style: TextStyles.font14DarkGreenMedium.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
                verticalSpacing(24),
                Row(
                  children: [
                    Expanded(
                      child: _buildCallOption(
                        icon: Iconsax.call,
                        title: 'Voice Call',
                        subtitle: 'Audio only',
                        gradient: const [Color(0xFF4285F4), Color(0xFF1976D2)],
                        onTap: onVoiceCall,
                      ),
                    ),
                    horizantialSpacing(16),
                    Expanded(
                      child: _buildCallOption(
                        icon: Iconsax.video,
                        title: 'Video Call',
                        subtitle: 'Audio & video',
                        gradient: const [Color(0xFF9C27B0), Color(0xFF7B1FA2)],
                        onTap: onVideoCall,
                      ),
                    ),
                  ],
                ),
                verticalSpacing(16),
                _buildDoctorInfo(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHandle() {
    return Container(
      margin: EdgeInsets.only(top: 12.h),
      width: 40.w,
      height: 4.h,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(2.r),
      ),
    );
  }

  Widget _buildCallOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradient,
          ),
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: gradient[0].withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 56.w,
              height: 56.h,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Icon(icon, color: Colors.white, size: 28.sp),
            ),
            verticalSpacing(12),
            Text(
              title,
              style: TextStyles.font14GreenSemiBold.copyWith(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            verticalSpacing(4),
            Text(
              subtitle,
              style: TextStyles.font12DarkGreenRegular.copyWith(
                color: Colors.white.withOpacity(0.9),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorInfo() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(
              color: ColorsManager.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Iconsax.user,
              color: ColorsManager.primaryColor,
              size: 24.sp,
            ),
          ),
          horizantialSpacing(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  conversation.doctorName ?? 'Doctor',
                  style: TextStyles.font14GreenSemiBold,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                verticalSpacing(4),
                Row(
                  children: [
                    if (conversation.isOnline ?? false)
                      Container(
                        width: 6.w,
                        height: 6.h,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                    if (conversation.isOnline ?? false) horizantialSpacing(4),
                    Flexible(
                      child: Text(
                        (conversation.isOnline ?? false)
                            ? 'Available now'
                            : 'Currently offline',
                        style: TextStyles.font12DarkGreenRegular.copyWith(
                          color:
                              (conversation.isOnline ?? false)
                                  ? Colors.green
                                  : Colors.grey.shade600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Icon(Iconsax.info_circle, color: Colors.grey.shade400, size: 20.sp),
        ],
      ),
    );
  }
}
