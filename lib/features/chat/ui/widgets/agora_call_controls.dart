import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AgoraCallControls extends StatelessWidget {
  final bool isVideoCall;
  final bool isMuted;
  final bool isSpeakerOn;
  final bool isCameraOff;
  final VoidCallback onToggleMute;
  final VoidCallback onToggleSpeaker;
  final VoidCallback onToggleCamera;
  final VoidCallback onSwitchCamera;
  final VoidCallback onEndCall;

  const AgoraCallControls({
    super.key,
    required this.isVideoCall,
    required this.isMuted,
    required this.isSpeakerOn,
    required this.isCameraOff,
    required this.onToggleMute,
    required this.onToggleSpeaker,
    required this.onToggleCamera,
    required this.onSwitchCamera,
    required this.onEndCall,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      color: Colors.black,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _AgoraControlIconButton(
                icon: isMuted ? Icons.mic_off : Icons.mic,
                onTap: onToggleMute,
              ),
              _AgoraControlIconButton(
                icon: isSpeakerOn ? Icons.volume_up : Icons.hearing_disabled,
                onTap: onToggleSpeaker,
              ),
              if (isVideoCall)
                _AgoraControlIconButton(
                  icon: isCameraOff ? Icons.videocam_off : Icons.videocam,
                  onTap: onToggleCamera,
                ),
              if (isVideoCall)
                _AgoraControlIconButton(
                  icon: Icons.cameraswitch,
                  onTap: onSwitchCamera,
                ),
            ],
          ),
          verticalSpacing(14),
          CustomMaterialButton(
            textButton: 'End Call',
            onPressed: onEndCall,
            icon: Icons.call_end,
            minWidth: 170,
            height: 46,
            raduisBorder: 24,
            backgroundColor: Colors.red,
            borderColor: Colors.red,
          ),
        ],
      ),
    );
  }
}

class _AgoraControlIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _AgoraControlIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(28),
      child: Container(
        width: 56.w,
        height: 56.h,
        decoration: const BoxDecoration(
          color: Color(0xFF1F2937),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
