import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_mate/core/routing/routes.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:doctor_mate/features/dignoses/data/models/diagnosis_details_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';

class DiagnosesScreen extends StatefulWidget {
  final String recordId;

  const DiagnosesScreen({super.key, required this.recordId});

  @override
  State<DiagnosesScreen> createState() => _DiagnosesScreenState();
}

class _DiagnosesScreenState extends State<DiagnosesScreen> {
  bool _isLoading = false;
  DiagnosisDetailsResponse? _diagnosis;

  @override
  void initState() {
    super.initState();
    _fetchDiagnosis();
  }

  void _fetchDiagnosis() {
    setState(() {
      _isLoading = true;
    });

    // TODO: Fetch from API using widget.recordId
    // Mock data for demonstration
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _diagnosis = DiagnosisDetailsResponse(
            id: 'diag_001_2024',
            medicalRecordId: widget.recordId,
            medicalRecordTitle: 'Type 2 Diabetes Mellitus Diagnosis',
            appointmentId: 'apt_001',
            diagnosedBy: 'doc_004',
            doctorName: 'Dr. James Wilson',
            description:
                'Patient presents with classic symptoms of Type 2 Diabetes Mellitus including polyuria, polydipsia, and unexplained weight loss over the past 3 months. '
                'Laboratory findings confirm diagnosis with HbA1c of 7.2% (normal <5.7%). Fasting blood glucose: 145 mg/dL. '
                'Patient counseled extensively on:\n'
                '• Lifestyle modifications including diet and exercise\n'
                '• Importance of medication compliance\n'
                '• Regular blood glucose monitoring\n'
                '• Annual eye and foot examinations\n'
                '• Cardiovascular risk factor management\n\n'
                'Treatment Plan:\n'
                '1. Metformin 500mg twice daily with meals\n'
                '2. Dietary consultation scheduled\n'
                '3. Follow-up in 3 months with repeat HbA1c\n'
                '4. Patient to maintain glucose diary',
            icdCode: 'E11.9',
            severity: 'Moderate',
            openmrsConditionUuid: 'uuid-condition-001-type2dm',
            createdAt:
                DateTime.now()
                    .subtract(const Duration(days: 15))
                    .toIso8601String(),
            updatedAt:
                DateTime.now()
                    .subtract(const Duration(days: 15))
                    .toIso8601String(),
            patient: PatientInfoModel(
              id: 'pat_001',
              name: 'Ahmed Hassan',
              image: null,
              gender: 'Male',
              age: 45,
            ),
            doctor: DiagnosisDoctorModel(
              id: 'doc_004',
              name: 'James Wilson',
              image: null,
              specialtyName: 'Endocrinology',
              consultationFee: 500.0,
            ),
            appointment: DiagnosisAppointmentModel(
              id: 'apt_001',
              scheduledAt:
                  DateTime.now()
                      .subtract(const Duration(days: 15))
                      .toIso8601String(),
              status: 'Completed',
              reasonForVisit:
                  'Follow-up consultation for blood sugar management',
            ),
            medicalRecord: DiagnosisMedicalRecordModel(
              id: widget.recordId,
              title: 'Type 2 Diabetes Mellitus Diagnosis',
              recordType: 'Diagnosis',
              recordDate:
                  DateTime.now()
                      .subtract(const Duration(days: 15))
                      .toIso8601String(),
            ),
          );
        });
      }
    });
  }

  Color _getSeverityColor() {
    if (_diagnosis == null) return ColorsManager.gray;

    switch (_diagnosis!.severity.toLowerCase()) {
      case 'mild':
        return Colors.green;
      case 'moderate':
        return Colors.orange;
      case 'severe':
        return Colors.red;
      case 'critical':
        return Colors.red.shade900;
      default:
        return ColorsManager.gray;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text('Diagnosis Details', style: TextStyles.font18DarkGreenBold),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: ColorsManager.darkBlue),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Iconsax.printer,
              color: ColorsManager.darkBlue,
              size: 24.sp,
            ),
            onPressed: () {
              // TODO: Implement print
            },
          ),
          IconButton(
            icon: Icon(
              Iconsax.share,
              color: ColorsManager.darkBlue,
              size: 24.sp,
            ),
            onPressed: () {
              // TODO: Implement share
            },
          ),
        ],
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _diagnosis == null
              ? _buildErrorState()
              : SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderCard(),
                    SizedBox(height: 16.h),
                    _buildPatientCard(),
                    SizedBox(height: 16.h),
                    _buildDoctorCard(),
                    SizedBox(height: 16.h),
                    _buildDiagnosisDetailsCard(),
                    SizedBox(height: 16.h),
                    _buildAppointmentCard(),
                    SizedBox(height: 16.h),
                    _buildMedicalRecordCard(),
                    SizedBox(height: 24.h),
                    _buildActionButtons(),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
    );
  }

  Widget _buildHeaderCard() {
    final severityColor = _getSeverityColor();

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorsManager.primaryColor,
            ColorsManager.primaryColor.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.primaryColor.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(Iconsax.health, color: Colors.white, size: 28.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Diagnosis Report',
                      style: TextStyles.font14WhiteRegular.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'ID: ${_diagnosis!.id.substring(0, 12).toUpperCase()}',
                      style: TextStyles.font12GrayRegular.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: severityColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: Colors.white.withOpacity(0.5)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Iconsax.danger, color: Colors.white, size: 14.sp),
                    SizedBox(width: 4.w),
                    Text(
                      _diagnosis!.severity,
                      style: TextStyles.font12GrayRegular.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            _diagnosis!.medicalRecordTitle,
            style: TextStyles.font18DarkGreenBold.copyWith(color: Colors.white),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(Iconsax.code_circle, color: Colors.white, size: 16.sp),
              SizedBox(width: 6.w),
              Text(
                'ICD-10: ${_diagnosis!.icdCode}',
                style: TextStyles.font14GrayRegular.copyWith(
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPatientCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Patient Information', style: TextStyles.font16DarkGreenBold),
          SizedBox(height: 12.h),
          Row(
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundColor: ColorsManager.primaryColor.withOpacity(0.1),
                child:
                    _diagnosis!.patient.image != null
                        ? CachedNetworkImage(
                          imageUrl: _diagnosis!.patient.image!,
                          imageBuilder:
                              (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                        )
                        : Icon(
                          Iconsax.user,
                          color: ColorsManager.primaryColor,
                          size: 30.sp,
                        ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _diagnosis!.patient.name,
                      style: TextStyles.font16DarkGreenBold,
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          _diagnosis!.patient.gender.toLowerCase() == 'male'
                              ? Iconsax.man
                              : Iconsax.woman,
                          size: 16.sp,
                          color: ColorsManager.gray,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '${_diagnosis!.patient.gender} • ${_diagnosis!.patient.age} years old',
                          style: TextStyles.font14GrayRegular,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Diagnosed By', style: TextStyles.font16DarkGreenBold),
          SizedBox(height: 12.h),
          Row(
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundColor: ColorsManager.primaryColor.withOpacity(0.1),
                child:
                    _diagnosis!.doctor.image != null
                        ? CachedNetworkImage(
                          imageUrl: _diagnosis!.doctor.image!,
                          imageBuilder:
                              (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                        )
                        : Icon(
                          Iconsax.user_octagon,
                          color: ColorsManager.primaryColor,
                          size: 30.sp,
                        ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. ${_diagnosis!.doctor.name}',
                      style: TextStyles.font16DarkGreenBold,
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Iconsax.health,
                          size: 16.sp,
                          color: ColorsManager.primaryColor,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          _diagnosis!.doctor.specialtyName,
                          style: TextStyles.font14GrayRegular.copyWith(
                            color: ColorsManager.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDiagnosisDetailsCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Iconsax.document_text,
                color: ColorsManager.primaryColor,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Clinical Description',
                style: TextStyles.font16DarkGreenBold,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            _diagnosis!.description,
            style: TextStyles.font14GrayRegular.copyWith(height: 1.6),
          ),
          SizedBox(height: 16.h),
          Divider(color: Colors.grey.shade200),
          SizedBox(height: 12.h),
          _buildInfoRow(
            Iconsax.calendar,
            'Diagnosis Date',
            DateFormat(
              'MMMM dd, yyyy',
            ).format(DateTime.parse(_diagnosis!.createdAt)),
          ),
          SizedBox(height: 8.h),
          _buildInfoRow(
            Iconsax.refresh,
            'Last Updated',
            DateFormat(
              'MMM dd, yyyy • hh:mm a',
            ).format(DateTime.parse(_diagnosis!.updatedAt)),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Iconsax.calendar_1,
                color: ColorsManager.primaryColor,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Related Appointment',
                style: TextStyles.font16DarkGreenBold,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          _buildInfoRow(
            Iconsax.calendar,
            'Scheduled',
            DateFormat(
              'MMM dd, yyyy • hh:mm a',
            ).format(DateTime.parse(_diagnosis!.appointment.scheduledAt)),
          ),
          SizedBox(height: 8.h),
          _buildInfoRow(
            Iconsax.info_circle,
            'Status',
            _diagnosis!.appointment.status,
          ),
          SizedBox(height: 8.h),
          _buildInfoRow(
            Iconsax.note_21,
            'Reason',
            _diagnosis!.appointment.reasonForVisit,
          ),
        ],
      ),
    );
  }

  Widget _buildMedicalRecordCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Iconsax.folder_2,
                color: ColorsManager.primaryColor,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text('Medical Record', style: TextStyles.font16DarkGreenBold),
            ],
          ),
          SizedBox(height: 12.h),
          _buildInfoRow(
            Iconsax.document_text,
            'Title',
            _diagnosis!.medicalRecord.title,
          ),
          SizedBox(height: 8.h),
          _buildInfoRow(
            Iconsax.category,
            'Type',
            _diagnosis!.medicalRecord.recordType,
          ),
          SizedBox(height: 8.h),
          _buildInfoRow(
            Iconsax.calendar,
            'Record Date',
            DateFormat(
              'MMM dd, yyyy',
            ).format(DateTime.parse(_diagnosis!.medicalRecord.recordDate)),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16.sp, color: ColorsManager.gray),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyles.font12GrayRegular),
              SizedBox(height: 2.h),
              Text(value, style: TextStyles.font14DarkGreenMedium),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomMaterialButton(
                textButton: 'Download Report',
                onPressed: () {
                  // TODO: Implement download
                },
                backgroundColor: Colors.white,
                textColor: ColorsManager.primaryColor,
                height: 48.h,
                raduisBorder: 12,
                borderColor: ColorsManager.primaryColor,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: CustomMaterialButton(
                textButton: 'View Prescription',
                onPressed: () {
                  context.push(
                    '${Routes.prescriptionsScreen}?diagnosisId=${_diagnosis!.id}',
                  );
                },
                backgroundColor: Colors.green,
                height: 48.h,
                raduisBorder: 12,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        CustomMaterialButton(
          textButton: 'Contact Doctor',
          onPressed: () {
            // TODO: Implement contact
          },
          height: 48.h,
          raduisBorder: 12,
        ),
      ],
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Iconsax.danger, size: 64.sp, color: Colors.red.withOpacity(0.5)),
          SizedBox(height: 16.h),
          Text(
            'Failed to load diagnosis',
            style: TextStyles.font16DarkGreenBold,
          ),
          SizedBox(height: 8.h),
          Text('Please try again later', style: TextStyles.font14GrayRegular),
          SizedBox(height: 24.h),
          CustomMaterialButton(
            textButton: 'Retry',
            onPressed: _fetchDiagnosis,
            height: 48.h,
            minWidth: 150.w,
            raduisBorder: 12,
          ),
        ],
      ),
    );
  }
}
