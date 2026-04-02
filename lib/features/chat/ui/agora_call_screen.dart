import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:doctor_mate/features/chat/ui/widgets/agora_call_body.dart';
import 'package:doctor_mate/features/chat/ui/widgets/agora_call_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

class AgoraCallScreen extends StatefulWidget {
  final String token;
  final String channelName;
  final String callType; // 'voice' or 'video'

  const AgoraCallScreen({
    super.key,
    required this.token,
    required this.channelName,
    required this.callType,
  });

  @override
  State<AgoraCallScreen> createState() => _AgoraCallScreenState();
}

class _AgoraCallScreenState extends State<AgoraCallScreen> {
  static const String _agoraAppId = String.fromEnvironment(
    'AGORA_APP_ID',
    defaultValue: 'b3f698ddfea14eccbb599525c52a3dad',
  );

  RtcEngine? _engine;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  String? _currentUserAccount;
  int? _remoteUid;
  bool _isMuted = false;
  bool _isSpeakerOn = true;
  bool _isCameraOff = false;
  bool _isLoading = true;
  String? _errorText;

  bool get _isVideoCall => widget.callType == 'video';

  @override
  void initState() {
    super.initState();
    _initializeAgora();
  }

  @override
  void dispose() {
    _leaveChannel();
    super.dispose();
  }

  Future<void> _initializeAgora() async {
    if (_agoraAppId.isEmpty) {
      setState(() {
        _errorText =
            'Agora App ID is missing. Provide it with --dart-define=AGORA_APP_ID=...';
        _isLoading = false;
      });
      return;
    }

    final permissions = <Permission>[Permission.microphone];
    if (_isVideoCall) {
      permissions.add(Permission.camera);
    }

    final statuses = await permissions.request();
    final denied = statuses.values.any((status) => !status.isGranted);
    if (denied) {
      setState(() {
        _errorText = 'Microphone/camera permission is required for calls.';
        _isLoading = false;
      });
      return;
    }

    try {
      _currentUserAccount = await _secureStorage.read(key: 'user_id');

      final engine = createAgoraRtcEngine();
      await engine.initialize(
        const RtcEngineContext(
          appId: _agoraAppId,
          channelProfile: ChannelProfileType.channelProfileCommunication,
        ),
      );

      engine.registerEventHandler(
        RtcEngineEventHandler(
          onJoinChannelSuccess: (connection, elapsed) {
            if (!mounted) return;
            // Apply audio route after joining to avoid ERR_NOT_READY on some devices.
            engine.setEnableSpeakerphone(_isSpeakerOn);
            setState(() {
              _isLoading = false;
            });
          },
          onUserJoined: (connection, remoteUid, elapsed) {
            if (!mounted) return;
            setState(() => _remoteUid = remoteUid);
          },
          onUserOffline: (connection, remoteUid, reason) {
            if (!mounted) return;
            setState(() => _remoteUid = null);
          },
          onError: (err, msg) {
            if (!mounted) return;
            final normalizedMsg = msg.toLowerCase();
            final looksLikeTokenError =
                normalizedMsg.contains('invalid token') ||
                normalizedMsg.contains('token expired') ||
                err == 109 ||
                err == 110;

            setState(() {
              _errorText =
                  looksLikeTokenError
                      ? 'Agora token is invalid/expired. Please request a new call token and try again.'
                      : 'Agora error ($err): $msg';
              _isLoading = false;
            });
          },
        ),
      );

      await engine.enableAudio();

      if (_isVideoCall) {
        await engine.enableVideo();
        await engine.startPreview();
      } else {
        await engine.disableVideo();
      }

      final channelOptions = ChannelMediaOptions(
        channelProfile: ChannelProfileType.channelProfileCommunication,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      );

      if (_currentUserAccount != null && _currentUserAccount!.isNotEmpty) {
        try {
          await engine.joinChannelWithUserAccount(
            token: widget.token,
            channelId: widget.channelName,
            userAccount: _currentUserAccount!,
            options: channelOptions,
          );
        } catch (_) {
          // Fallback for backends that mint UID-based tokens.
          await engine.joinChannel(
            token: widget.token,
            channelId: widget.channelName,
            uid: 0,
            options: channelOptions,
          );
        }
      } else {
        await engine.joinChannel(
          token: widget.token,
          channelId: widget.channelName,
          uid: 0,
          options: channelOptions,
        );
      }

      _engine = engine;
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorText = 'Failed to initialize call: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _leaveChannel() async {
    final engine = _engine;
    if (engine != null) {
      await engine.leaveChannel();
      await engine.release();
      _engine = null;
    }
  }

  Future<void> _toggleMute() async {
    final engine = _engine;
    if (engine == null) return;
    final next = !_isMuted;
    await engine.muteLocalAudioStream(next);
    if (!mounted) return;
    setState(() => _isMuted = next);
  }

  Future<void> _toggleSpeaker() async {
    final engine = _engine;
    if (engine == null) return;
    final next = !_isSpeakerOn;
    await engine.setEnableSpeakerphone(next);
    if (!mounted) return;
    setState(() => _isSpeakerOn = next);
  }

  Future<void> _toggleCamera() async {
    if (!_isVideoCall) return;
    final engine = _engine;
    if (engine == null) return;
    final next = !_isCameraOff;
    await engine.muteLocalVideoStream(next);
    if (!mounted) return;
    setState(() => _isCameraOff = next);
  }

  Future<void> _switchCamera() async {
    if (!_isVideoCall || _engine == null) return;
    await _engine!.switchCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(_isVideoCall ? 'Video Call' : 'Voice Call'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: AgoraCallBody(
                isVideoCall: _isVideoCall,
                isLoading: _isLoading,
                errorText: _errorText,
                remoteUid: _remoteUid,
                engine: _engine,
                channelName: widget.channelName,
                isCameraOff: _isCameraOff,
                onClosePressed: () {
                  context.pop();
                },
              ),
            ),
            AgoraCallControls(
              isVideoCall: _isVideoCall,
              isMuted: _isMuted,
              isSpeakerOn: _isSpeakerOn,
              isCameraOff: _isCameraOff,
              onToggleMute: _toggleMute,
              onToggleSpeaker: _toggleSpeaker,
              onToggleCamera: _toggleCamera,
              onSwitchCamera: _switchCamera,
              onEndCall: () async {
                await _leaveChannel();
                if (!mounted) return;
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
