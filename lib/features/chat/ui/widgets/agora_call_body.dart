import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:flutter/material.dart';

class AgoraCallBody extends StatelessWidget {
  final bool isVideoCall;
  final bool isLoading;
  final String? errorText;
  final int? remoteUid;
  final RtcEngine? engine;
  final String channelName;
  final bool isCameraOff;
  final VoidCallback onClosePressed;

  const AgoraCallBody({
    super.key,
    required this.isVideoCall,
    required this.isLoading,
    required this.errorText,
    required this.remoteUid,
    required this.engine,
    required this.channelName,
    required this.isCameraOff,
    required this.onClosePressed,
  });

  @override
  Widget build(BuildContext context) {
    if (errorText != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                errorText!,
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              verticalSpacing(16),
              CustomMaterialButton(
                textButton: 'Close',
                onPressed: onClosePressed,
                minWidth: 140,
                height: 44,
                backgroundColor: Colors.red,
                borderColor: Colors.red,
                raduisBorder: 12,
              ),
            ],
          ),
        ),
      );
    }

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: ColorsManager.primaryColor),
      );
    }

    if (!isVideoCall) {
      return Center(
        child: Text(
          remoteUid == null ? 'Waiting for doctor to join...' : 'Connected',
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      );
    }

    final rtcEngine = engine;
    if (rtcEngine == null) {
      return const Center(
        child: Text(
          'Initializing call engine...',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return Stack(
      children: [
        Positioned.fill(
          child:
              remoteUid != null
                  ? AgoraVideoView(
                    controller: VideoViewController.remote(
                      rtcEngine: rtcEngine,
                      canvas: VideoCanvas(uid: remoteUid),
                      connection: RtcConnection(channelId: channelName),
                    ),
                  )
                  : const Center(
                    child: Text(
                      'Waiting for doctor video...',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
        ),
        Positioned(
          right: 16,
          top: 16,
          width: 120,
          height: 180,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade900,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child:
                  isCameraOff
                      ? const Center(
                        child: Icon(Icons.videocam_off, color: Colors.white),
                      )
                      : AgoraVideoView(
                        controller: VideoViewController(
                          rtcEngine: rtcEngine,
                          canvas: const VideoCanvas(uid: 0),
                        ),
                      ),
            ),
          ),
        ),
      ],
    );
  }
}
