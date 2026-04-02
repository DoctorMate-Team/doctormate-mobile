import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/chat/logic/communication_cubit.dart';
import 'package:doctor_mate/features/chat/logic/communication_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CommunicationActionButtons extends StatelessWidget {
  final String appointmentId;
  final VoidCallback onChatPressed;
  final VoidCallback onVoiceCallPressed;
  final VoidCallback onVideoCallPressed;
  final String? sessionType; // Current session type from backend

  const CommunicationActionButtons({
    super.key,
    required this.appointmentId,
    required this.onChatPressed,
    required this.onVoiceCallPressed,
    required this.onVideoCallPressed,
    this.sessionType,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunicationCubit, CommunicationState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          checkingSession: () => _buildLoadingState(),
          sessionActive:
              (sessionId, channelName, sessionType) => _buildActiveButtons(
                context,
                isEnabled: true,
                sessionType: sessionType,
              ),
          sessionNotAvailable:
              (message) => _buildDisabledButtons(context, message: message),
          sessionCheckError: (error) => _buildErrorState(error),
          gettingCallToken: () => _buildLoadingState(),
          callTokenRetrieved:
              (token, channel, expiry, callType) => _buildActiveButtons(
                context,
                isEnabled: true,
                sessionType: sessionType,
              ),
          callTokenError: (error) => _buildErrorState(error),
        );
      },
    );
  }

  Widget _buildLoadingState() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Column(
          children: [
            CircularProgressIndicator(
              color: ColorsManager.primaryColor,
              strokeWidth: 2,
            ),
            verticalSpacing(12),
            Text(
              'Checking communication availability...',
              style: TextStyles.font12GrayRegular,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveButtons(
    BuildContext context, {
    required bool isEnabled,
    String? sessionType,
  }) {
    // Determine which buttons to show based on session type
    final bool showChat = true; // Chat always available
    final bool showVoice = sessionType == 'voice' || sessionType == 'video';
    final bool showVideo = sessionType == 'video';
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: ColorsManager.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Iconsax.messages,
                  color: ColorsManager.primaryColor,
                  size: 20.sp,
                ),
              ),
              horizantialSpacing(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Communication',
                      style: TextStyles.font16DarkGreenBold,
                    ),
                    Text(
                      'Chat or call with your doctor',
                      style: TextStyles.font12GrayRegular,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 6.w,
                      height: 6.h,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Available',
                      style: TextStyles.font12GrayRegular.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          verticalSpacing(16),
          Row(
            children: [
              if (showChat)
                Expanded(
                  child: _buildActionButton(
                    icon: Iconsax.message_text,
                    label: 'Chat',
                    color: Colors.blue,
                    onPressed: isEnabled ? onChatPressed : null,
                  ),
                ),
              if (showChat && showVoice) horizantialSpacing(12),
              if (showVoice)
                Expanded(
                  child: _buildActionButton(
                    icon: Iconsax.call,
                    label: 'Voice Call',
                    color: Colors.green,
                    onPressed: isEnabled ? onVoiceCallPressed : null,
                  ),
                ),
              if (showVoice && showVideo) horizantialSpacing(12),
              if (showVideo)
                Expanded(
                  child: _buildActionButton(
                    icon: Iconsax.video,
                    label: 'Video Call',
                    color: Colors.purple,
                    onPressed: isEnabled ? onVideoCallPressed : null,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDisabledButtons(
    BuildContext context, {
    required String message,
  }) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(Iconsax.messages, color: Colors.grey, size: 20.sp),
              ),
              horizantialSpacing(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Communication',
                      style: TextStyles.font16DarkGreenBold.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      message,
                      style: TextStyles.font12GrayRegular.copyWith(
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          verticalSpacing(16),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  icon: Iconsax.message_text,
                  label: 'Chat',
                  color: Colors.grey,
                  onPressed: null,
                ),
              ),
              horizantialSpacing(12),
              Expanded(
                child: _buildActionButton(
                  icon: Iconsax.call,
                  label: 'Voice Call',
                  color: Colors.grey,
                  onPressed: null,
                ),
              ),
              horizantialSpacing(12),
              Expanded(
                child: _buildActionButton(
                  icon: Iconsax.video,
                  label: 'Video Call',
                  color: Colors.grey,
                  onPressed: null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.red.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(Iconsax.info_circle, color: Colors.red, size: 24.sp),
          horizantialSpacing(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Error',
                  style: TextStyles.font14DarkGreenMedium.copyWith(
                    color: Colors.red,
                  ),
                ),
                Text(error, style: TextStyles.font12GrayRegular),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback? onPressed,
  }) {
    final bool isEnabled = onPressed != null;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color:
              isEnabled
                  ? color.withOpacity(0.1)
                  : Colors.grey.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color:
                isEnabled
                    ? color.withOpacity(0.3)
                    : Colors.grey.withOpacity(0.2),
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: isEnabled ? color : Colors.grey, size: 24.sp),
            verticalSpacing(6),
            Text(
              label,
              style: TextStyles.font12GrayRegular.copyWith(
                color: isEnabled ? color : Colors.grey,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
