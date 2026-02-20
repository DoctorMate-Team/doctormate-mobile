import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/routing/routes.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/theme/font_weight_helper.dart';
import 'package:doctor_mate/core/widgets/custom_shimmer_loading.dart';
import 'package:doctor_mate/features/appointment/data/models/appointment_list_response.dart';
import 'package:doctor_mate/features/appointment_details/data/models/appointment_details_response.dart';
import 'package:doctor_mate/features/appointment_details/logic/cubit/appointment_details_cubit.dart';
import 'package:doctor_mate/features/appointment_details/logic/cubit/appointment_details_state.dart';
import 'package:doctor_mate/features/appointment_details/ui/widgets/appointment_info_card.dart';
import 'package:doctor_mate/features/appointment_details/ui/widgets/communication_action_buttons.dart';
import 'package:doctor_mate/features/appointment_details/ui/widgets/diagnosis_section_card.dart';
import 'package:doctor_mate/features/appointment_details/ui/widgets/medical_images_section_card.dart';
import 'package:doctor_mate/features/appointment_details/ui/widgets/medical_record_section_card.dart';
import 'package:doctor_mate/features/appointment_details/ui/widgets/prescription_section_card.dart';
import 'package:doctor_mate/features/chat/data/models/chat_message_response.dart';
import 'package:doctor_mate/features/chat/logic/communication_cubit.dart';
import 'package:doctor_mate/features/chat/logic/communication_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AppointmentDetailsScreen extends StatefulWidget {
  final PatientAppointmentModel appointment;

  const AppointmentDetailsScreen({super.key, required this.appointment});

  @override
  State<AppointmentDetailsScreen> createState() =>
      _AppointmentDetailsScreenState();
}

class _AppointmentDetailsScreenState extends State<AppointmentDetailsScreen> {
  String? _sessionId;
  String? _channelName;
  AppointmentDetailsResponse? _appointmentDetails;
  bool _isLoadingDetails = true;

  @override
  void initState() {
    super.initState();
    // Check communication availability when screen loads
    context.read<CommunicationCubit>().checkSessionAvailability(
      widget.appointment.id.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // Listen to appointment details state
        BlocListener<AppointmentDetailsCubit, AppointmentDetailsState>(
          listener: (context, state) {
            state.when(
              initial: () {},
              getAppointmentDetailsLoading: () {
                setState(() => _isLoadingDetails = true);
              },
              getAppointmentDetailsSuccess: (details) {
                setState(() {
                  _appointmentDetails = details;
                  _isLoadingDetails = false;
                });
              },
              getAppointmentDetailsError: (error) {
                setState(() => _isLoadingDetails = false);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(error), backgroundColor: Colors.red),
                );
              },
            );
          },
        ),
        // Listen to communication state
        BlocListener<CommunicationCubit, CommunicationState>(
          listener: (context, state) {
            state.whenOrNull(
              sessionActive: (sessionId, channelName) {
                _sessionId = sessionId;
                _channelName = channelName;
              },
              callTokenRetrieved: (token, channel, expiry, callType) {
                _handleCallTokenRetrieved(token, channel, expiry, callType);
              },
              callTokenError: (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to start call: $error'),
                    backgroundColor: Colors.red,
                  ),
                );
                // Return to session active state
                if (_sessionId != null && _channelName != null) {
                  context.read<CommunicationCubit>().returnToSessionActive(
                    _sessionId!,
                    _channelName!,
                  );
                }
              },
            );
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  _buildAppBar(context),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(16.w),
                      child:
                          _isLoadingDetails
                              ? _buildShimmerLoading()
                              : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppointmentInfoCard(
                                    appointment: widget.appointment,
                                  ),
                                  verticalSpacing(16),
                                  // Communication buttons
                                  CommunicationActionButtons(
                                    appointmentId:
                                        widget.appointment.id.toString(),
                                    onChatPressed: _handleChatPressed,
                                    onVoiceCallPressed: _handleVoiceCallPressed,
                                    onVideoCallPressed: _handleVideoCallPressed,
                                  ),
                                  verticalSpacing(16),
                                  MedicalRecordSectionCard(
                                    appointment: widget.appointment,
                                    medicalRecord:
                                        _appointmentDetails?.medicalRecord,
                                  ),
                                  verticalSpacing(16),
                                  DiagnosisSectionCard(
                                    appointment: widget.appointment,
                                    diagnoses:
                                        _appointmentDetails?.diagnoses ?? [],
                                  ),
                                  verticalSpacing(16),
                                  PrescriptionSectionCard(
                                    appointment: widget.appointment,
                                    prescriptions:
                                        _appointmentDetails?.prescriptions ??
                                        [],
                                  ),
                                  verticalSpacing(16),
                                  MedicalImagesSectionCard(
                                    appointment: widget.appointment,
                                    medicalImages:
                                        _appointmentDetails?.medicalImages ??
                                        [],
                                  ),
                                  verticalSpacing(24),
                                ],
                              ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Appointment info card shimmer
        Container(
          padding: EdgeInsets.all(16.w),
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
                  CustomShimmerLoading(height: 60, width: 60, borderRadius: 12),
                  horizantialSpacing(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomShimmerLoading(
                          height: 16,
                          width: 150,
                          borderRadius: 8,
                        ),
                        verticalSpacing(8),
                        CustomShimmerLoading(
                          height: 14,
                          width: 100,
                          borderRadius: 8,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              verticalSpacing(12),
              CustomShimmerLoading(
                height: 12,
                width: double.infinity,
                borderRadius: 8,
              ),
              verticalSpacing(8),
              CustomShimmerLoading(height: 12, width: 200, borderRadius: 8),
            ],
          ),
        ),
        verticalSpacing(16),

        // Communication buttons shimmer
        Container(
          padding: EdgeInsets.all(16.w),
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
          child: Row(
            children: [
              Expanded(
                child: CustomShimmerLoading(
                  height: 48,
                  width: double.infinity,
                  borderRadius: 12,
                ),
              ),
              horizantialSpacing(12),
              Expanded(
                child: CustomShimmerLoading(
                  height: 48,
                  width: double.infinity,
                  borderRadius: 12,
                ),
              ),
              horizantialSpacing(12),
              Expanded(
                child: CustomShimmerLoading(
                  height: 48,
                  width: double.infinity,
                  borderRadius: 12,
                ),
              ),
            ],
          ),
        ),
        verticalSpacing(16),

        // Section cards shimmer (4 cards)
        for (int i = 0; i < 4; i++) ...[
          _buildSectionCardShimmer(),
          verticalSpacing(16),
        ],
      ],
    );
  }

  Widget _buildSectionCardShimmer() {
    return Container(
      padding: EdgeInsets.all(16.w),
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
              CustomShimmerLoading(height: 40, width: 40, borderRadius: 12),
              horizantialSpacing(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomShimmerLoading(
                      height: 16,
                      width: 120,
                      borderRadius: 8,
                    ),
                    verticalSpacing(6),
                    CustomShimmerLoading(
                      height: 12,
                      width: 180,
                      borderRadius: 8,
                    ),
                  ],
                ),
              ),
            ],
          ),
          verticalSpacing(16),
          CustomShimmerLoading(
            height: 14,
            width: double.infinity,
            borderRadius: 8,
          ),
          verticalSpacing(8),
          CustomShimmerLoading(
            height: 14,
            width: double.infinity,
            borderRadius: 8,
          ),
          verticalSpacing(8),
          CustomShimmerLoading(height: 14, width: 150, borderRadius: 8),
        ],
      ),
    );
  }

  // Step 2: Start Chat
  void _handleChatPressed() {
    if (_sessionId == null) return;

    // Create a ChatConversationResponse for navigation
    final conversation = ChatConversationResponse(
      id: _sessionId!,
      appointmentId: widget.appointment.id.toString(),
      doctorId: widget.appointment.doctor.id,
      doctorName: widget.appointment.doctor.doctorName,
      doctorImage: widget.appointment.doctor.image,
      doctorSpecialty: widget.appointment.doctor.specialtyName,
      patientId: 'current_patient', // TODO: Get from auth
      patientName: 'Current Patient', // TODO: Get from auth
      patientImage: '', // TODO: Get from auth
      isOnline: true,
      status: 'active',
      lastMessageTime: DateTime.now(),
    );

    // Navigate to chat conversation screen
    context.push(
      '${Routes.chatConversationScreen}?conversationId=$_sessionId',
      extra: conversation,
    );
  }

  // Step 3: Start Voice Call
  void _handleVoiceCallPressed() {
    if (_sessionId == null) return;

    context.read<CommunicationCubit>().getCallToken(
      sessionId: _sessionId!,
      callType: 'voice',
    );
  }

  // Step 3: Start Video Call
  void _handleVideoCallPressed() {
    if (_sessionId == null) return;

    context.read<CommunicationCubit>().getCallToken(
      sessionId: _sessionId!,
      callType: 'video',
    );
  }

  // Handle call token retrieval
  void _handleCallTokenRetrieved(
    String token,
    String channel,
    int expiry,
    String callType,
  ) {
    // TODO: Integrate with your call SDK (Agora/Firebase/etc)
    // For now, show a dialog with the token info
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('${callType == 'voice' ? 'Voice' : 'Video'} Call'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Token: ${token.substring(0, 20)}...'),
                const SizedBox(height: 8),
                Text('Channel: $channel'),
                const SizedBox(height: 8),
                Text('Expiry: $expiry seconds'),
                const SizedBox(height: 16),
                const Text(
                  'Integrate with your call SDK to start the call.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  context.pop();
                  // Return to session active state
                  if (_sessionId != null && _channelName != null) {
                    context.read<CommunicationCubit>().returnToSessionActive(
                      _sessionId!,
                      _channelName!,
                    );
                  }
                },
                child: const Text('Close'),
              ),
            ],
          ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: ColorsManager.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: ColorsManager.primaryColor,
                size: 20.sp,
              ),
            ),
          ),
          horizantialSpacing(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Appointment Details',
                  style: TextStyles.font18DarkGreenBold.copyWith(
                    color: Colors.black,
                  ),
                ),
                Text(
                  'View complete information',
                  style: TextStyles.font12GrayRegular,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: _getStatusColor(
                widget.appointment.status,
              ).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: _getStatusColor(
                  widget.appointment.status,
                ).withOpacity(0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _getStatusIcon(widget.appointment.status),
                  size: 14.sp,
                  color: _getStatusColor(widget.appointment.status),
                ),
                SizedBox(width: 4.w),
                Text(
                  widget.appointment.status.toUpperCase(),
                  style: TextStyle(
                    color: _getStatusColor(widget.appointment.status),
                    fontSize: 11.sp,
                    fontWeight: FontWeightHelper.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'upcoming':
      case 'scheduled':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'upcoming':
      case 'scheduled':
        return Iconsax.clock;
      case 'completed':
        return Iconsax.tick_circle;
      case 'cancelled':
        return Iconsax.close_circle;
      default:
        return Iconsax.info_circle;
    }
  }
}
