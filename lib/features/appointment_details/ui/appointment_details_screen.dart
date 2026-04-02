import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/routing/routes.dart';
import 'package:doctor_mate/features/appointment_details/data/models/appointment_details_response.dart';
import 'package:doctor_mate/features/appointment_details/logic/cubit/appointment_details_cubit.dart';
import 'package:doctor_mate/features/appointment_details/logic/cubit/appointment_details_state.dart';
import 'package:doctor_mate/features/appointment_details/ui/widgets/appointment_details_app_bar.dart';
import 'package:doctor_mate/features/appointment_details/ui/widgets/appointment_details_shimmer_loading.dart';
import 'package:doctor_mate/features/appointment_details/ui/widgets/appointment_info_card.dart';
import 'package:doctor_mate/features/appointment_details/ui/widgets/communication_action_buttons.dart';
import 'package:doctor_mate/features/appointment_details/ui/widgets/diagnosis_section_card.dart';
import 'package:doctor_mate/features/appointment_details/ui/widgets/medical_images_section_card.dart';
import 'package:doctor_mate/features/appointment_details/ui/widgets/medical_record_section_card.dart';
import 'package:doctor_mate/features/appointment_details/ui/widgets/prescription_section_card.dart';
import 'package:doctor_mate/features/chat/data/models/chat_message_response.dart';
import 'package:doctor_mate/features/chat/logic/communication_cubit.dart';
import 'package:doctor_mate/features/chat/logic/communication_state.dart';
import 'package:doctor_mate/features/reviews/logic/cubit/reviews_cubit.dart';
import 'package:doctor_mate/features/reviews/logic/cubit/reviews_state.dart';
import 'package:doctor_mate/features/reviews/data/models/review_model.dart';
import 'package:doctor_mate/features/reviews/ui/widgets/review_section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AppointmentDetailsScreen extends StatefulWidget {
  final String appointmentId;

  const AppointmentDetailsScreen({super.key, required this.appointmentId});

  @override
  State<AppointmentDetailsScreen> createState() =>
      _AppointmentDetailsScreenState();
}

class _AppointmentDetailsScreenState extends State<AppointmentDetailsScreen> {
  String? _sessionId;
  String? _channelName;
  String? _sessionType; // 'chat', 'voice', or 'video'
  ReviewModel? _myReview;

  @override
  void initState() {
    super.initState();
    context.read<AppointmentDetailsCubit>().getAppointmentDetails(
      widget.appointmentId,
    );
    context.read<CommunicationCubit>().checkSessionAvailability(
      widget.appointmentId,
    );
    context.read<ReviewsCubit>().getMyReviewForAppointment(
      widget.appointmentId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CommunicationCubit, CommunicationState>(
          listenWhen:
              (previous, current) => current.maybeWhen(
                orElse: () => false,
                sessionActive: (_, __, ___) => true,
                callTokenRetrieved: (_, __, ___, ____) => true,
                callTokenError: (_) => true,
              ),
          listener: (context, state) {
            state.whenOrNull(
              sessionActive: (sessionId, channelName, sessionType) {
                setState(() {
                  _sessionId = sessionId;
                  _channelName = channelName;
                  _sessionType = sessionType;
                });
              },
              callTokenRetrieved: (token, channel, expiry, callType) {
                _startAgoraCall(token, channel, callType);
              },
              callTokenError: (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to start call: $error'),
                    backgroundColor: Colors.red,
                  ),
                );
                _returnToSessionActive();
              },
            );
          },
        ),
        BlocListener<ReviewsCubit, ReviewsState>(
          listenWhen:
              (previous, current) => current.maybeWhen(
                orElse: () => false,
                getMyReviewSuccess: (_) => true,
                createReviewSuccess: (_) => true,
                updateReviewSuccess: (_) => true,
                deleteReviewSuccess: (_) => true,
              ),
          listener: (context, state) {
            state.whenOrNull(
              getMyReviewSuccess: (review) {
                setState(() {
                  _myReview = review;
                });
              },
              createReviewSuccess: (review) {
                setState(() {
                  _myReview = review;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Review submitted successfully'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              updateReviewSuccess: (review) {
                setState(() {
                  _myReview = review;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Review updated successfully'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              deleteReviewSuccess: (_) {
                setState(() {
                  _myReview = null;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Review deleted successfully'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
            );
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: SafeArea(
          child: BlocBuilder<AppointmentDetailsCubit, AppointmentDetailsState>(
            buildWhen:
                (previous, current) => current.maybeWhen(
                  orElse: () => false,
                  getAppointmentDetailsLoading: () => true,
                  getAppointmentDetailsSuccess: (_) => true,
                  getAppointmentDetailsError: (_) => true,
                ),
            builder: (context, state) {
              return state.maybeWhen(
                getAppointmentDetailsLoading: () => _buildLoadingState(),
                getAppointmentDetailsSuccess:
                    (details) => _buildContentState(details),
                getAppointmentDetailsError: (error) => _buildErrorState(error),
                orElse: () => _buildLoadingState(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: AppointmentDetailsShimmerLoading(),
          ),
        ),
      ],
    );
  }

  Widget _buildContentState(AppointmentDetailsResponse details) {
    return Column(
      children: [
        AppointmentDetailsAppBar(status: details.status),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppointmentInfoCard(appointmentDetails: details),
                verticalSpacing(16),
                CommunicationActionButtons(
                  appointmentId: widget.appointmentId,
                  onChatPressed: () => _handleChatPressed(details),
                  onVoiceCallPressed: _handleVoiceCallPressed,
                  onVideoCallPressed: _handleVideoCallPressed,
                  sessionType: _sessionType,
                ),
                verticalSpacing(16),
                MedicalRecordSectionCard(
                  appointmentDetails: details,
                  medicalRecord: details.medicalRecord,
                ),
                verticalSpacing(16),
                DiagnosisSectionCard(
                  appointmentDetails: details,
                  diagnoses: details.diagnoses,
                ),
                verticalSpacing(16),
                PrescriptionSectionCard(
                  appointmentDetails: details,
                  prescriptions: details.prescriptions,
                ),
                verticalSpacing(16),
                MedicalImagesSectionCard(
                  appointmentDetails: details,
                  medicalImages: details.medicalImages,
                ),
                verticalSpacing(16),
                ReviewSectionCard(
                  appointmentId: widget.appointmentId,
                  myReview: _myReview,
                  onReviewSubmitted: () {
                    context.read<ReviewsCubit>().getMyReviewForAppointment(
                      widget.appointmentId,
                    );
                  },
                ),
                verticalSpacing(24),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(String error) {
    return Column(
      children: [
        const AppointmentDetailsAppBar(status: 'unknown'),
        Expanded(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64.sp, color: Colors.red),
                  verticalSpacing(16),
                  Text(
                    'Failed to load appointment details',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  verticalSpacing(8),
                  Text(
                    error,
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  verticalSpacing(24),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<AppointmentDetailsCubit>()
                          .getAppointmentDetails(widget.appointmentId);
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _handleChatPressed(AppointmentDetailsResponse details) {
    if (_sessionId == null) return;

    final conversation = ChatConversationResponse(
      id: _sessionId!,
      appointmentId: widget.appointmentId,
      doctorId: details.doctorId,
      doctorName: details.doctorName,
      doctorImage: details.doctorImage,
      doctorSpecialty: details.specialty,
      patientId: details.patientId,
      patientName: details.patientName,
      patientImage: details.patientImage,
      isOnline: true,
      status: 'active',
      lastMessageTime: DateTime.now(),
    );

    context.push(
      '${Routes.chatConversationScreen}?conversationId=$_sessionId',
      extra: conversation,
    );
  }

  void _handleVoiceCallPressed() {
    context.read<CommunicationCubit>().getCallToken(
      appointmentId: widget.appointmentId,
      callType: 'voice',
    );
  }

  void _handleVideoCallPressed() {
    context.read<CommunicationCubit>().getCallToken(
      appointmentId: widget.appointmentId,
      callType: 'video',
    );
  }

  void _startAgoraCall(String token, String channel, String callType) {
    context
        .pushNamed(
          Routes.agoraCallScreen,
          queryParameters: {
            'token': token,
            'channel': channel,
            'callType': callType,
          },
        )
        .then((_) {
          _returnToSessionActive();
        });
  }

  void _returnToSessionActive() {
    if (_sessionId != null && _channelName != null && _sessionType != null) {
      context.read<CommunicationCubit>().returnToSessionActive(
        _sessionId!,
        _channelName!,
        _sessionType!,
      );
    }
  }
}
