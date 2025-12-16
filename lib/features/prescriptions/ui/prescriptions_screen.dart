import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:doctor_mate/features/prescriptions/data/models/prescription_details_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';

class PrescriptionsScreen extends StatefulWidget {
  final String diagnosisId;

  const PrescriptionsScreen({super.key, required this.diagnosisId});

  @override
  State<PrescriptionsScreen> createState() => _PrescriptionsScreenState();
}

class _PrescriptionsScreenState extends State<PrescriptionsScreen> {
  bool _isLoading = false;
  PrescriptionDetailsResponse? _prescription;

  @override
  void initState() {
    super.initState();
    _fetchPrescription();
  }

  void _fetchPrescription() {
    setState(() {
      _isLoading = true;
    });

    // TODO: Fetch from API using widget.diagnosisId
    // Mock data for demonstration
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _prescription = PrescriptionDetailsResponse(
            id: 'presc_001_2024',
            diagnosisId: widget.diagnosisId,
            patientId: 'pat_001',
            patientName: 'Ahmed Hassan',
            patientImage: null,
            doctorId: 'doc_004',
            doctorName: 'Dr. James Wilson',
            doctorImage: null,
            specialtyName: 'Endocrinology',
            prescribedDate:
                DateTime.now()
                    .subtract(const Duration(days: 15))
                    .toIso8601String(),
            expiryDate:
                DateTime.now().add(const Duration(days: 75)).toIso8601String(),
            status: 'Active',
            notes:
                'Take all medications with food. Monitor blood glucose levels regularly. Contact doctor if experiencing any side effects.',
            medications: [
              PrescriptionMedicationModel(
                drugName: 'Metformin 500mg',
                dosage: '500mg',
                instructions:
                    'Take 1 tablet twice daily with breakfast and dinner',
                durationDays: 90,
              ),
              PrescriptionMedicationModel(
                drugName: 'Glimepiride 2mg',
                dosage: '2mg',
                instructions: 'Take 1 tablet once daily before breakfast',
                durationDays: 90,
              ),
              PrescriptionMedicationModel(
                drugName: 'Atorvastatin 20mg',
                dosage: '20mg',
                instructions: 'Take 1 tablet once daily at bedtime',
                durationDays: 90,
              ),
              PrescriptionMedicationModel(
                drugName: 'Aspirin 100mg',
                dosage: '100mg',
                instructions: 'Take 1 tablet once daily after lunch',
                durationDays: 90,
              ),
            ],
          );
        });
      }
    });
  }

  Color _getStatusColor() {
    if (_prescription == null) return ColorsManager.gray;

    switch (_prescription!.status.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'expired':
        return Colors.red;
      case 'completed':
        return Colors.blue;
      case 'cancelled':
        return Colors.orange;
      default:
        return ColorsManager.gray;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          'Prescription Details',
          style: TextStyles.font18DarkGreenBold,
        ),
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
              : _prescription == null
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
                    _buildMedicationsCard(),
                    SizedBox(height: 16.h),
                    if (_prescription!.notes != null) _buildNotesCard(),
                    if (_prescription!.notes != null) SizedBox(height: 16.h),
                    _buildValidityCard(),
                    SizedBox(height: 24.h),
                    _buildActionButtons(),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
    );
  }

  Widget _buildHeaderCard() {
    final statusColor = _getStatusColor();

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade600, Colors.green.shade400],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
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
                child: Icon(Iconsax.note_21, color: Colors.white, size: 28.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Medical Prescription',
                      style: TextStyles.font14WhiteRegular.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Rx: ${_prescription!.id.substring(0, 12).toUpperCase()}',
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
                  color: statusColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: Colors.white.withOpacity(0.5)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _prescription!.status.toLowerCase() == 'active'
                          ? Iconsax.tick_circle
                          : Iconsax.info_circle,
                      color: Colors.white,
                      size: 14.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      _prescription!.status,
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
          Row(
            children: [
              Icon(Iconsax.calendar, color: Colors.white, size: 16.sp),
              SizedBox(width: 6.w),
              Text(
                'Prescribed: ${DateFormat('MMM dd, yyyy').format(DateTime.parse(_prescription!.prescribedDate))}',
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
                    _prescription!.patientImage != null
                        ? CachedNetworkImage(
                          imageUrl: _prescription!.patientImage!,
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
                child: Text(
                  _prescription!.patientName,
                  style: TextStyles.font16DarkGreenBold,
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
          Text('Prescribed By', style: TextStyles.font16DarkGreenBold),
          SizedBox(height: 12.h),
          Row(
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundColor: ColorsManager.primaryColor.withOpacity(0.1),
                child:
                    _prescription!.doctorImage != null
                        ? CachedNetworkImage(
                          imageUrl: _prescription!.doctorImage!,
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
                      _prescription!.doctorName,
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
                          _prescription!.specialtyName,
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

  Widget _buildMedicationsCard() {
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
                Iconsax.health,
                color: ColorsManager.primaryColor,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Medications (${_prescription!.medications.length})',
                style: TextStyles.font16DarkGreenBold,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _prescription!.medications.length,
            separatorBuilder:
                (context, index) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Divider(color: Colors.grey.shade200, height: 1),
                ),
            itemBuilder: (context, index) {
              final medication = _prescription!.medications[index];
              return _buildMedicationItem(medication, index + 1);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationItem(
    PrescriptionMedicationModel medication,
    int number,
  ) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  color: ColorsManager.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$number',
                    style: TextStyles.font14WhiteRegular.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medication.drugName,
                      style: TextStyles.font16DarkGreenBold,
                    ),
                    if (medication.dosage != null) ...[
                      SizedBox(height: 4.h),
                      Text(
                        'Dosage: ${medication.dosage}',
                        style: TextStyles.font14GrayRegular.copyWith(
                          color: ColorsManager.primaryColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          if (medication.instructions != null) ...[
            SizedBox(height: 12.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Iconsax.info_circle,
                  size: 16.sp,
                  color: ColorsManager.gray,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    medication.instructions!,
                    style: TextStyles.font14GrayRegular.copyWith(height: 1.5),
                  ),
                ),
              ],
            ),
          ],
          if (medication.durationDays != null) ...[
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Iconsax.calendar,
                    size: 14.sp,
                    color: Colors.green.shade700,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'Duration: ${medication.durationDays} days',
                    style: TextStyles.font12GrayRegular.copyWith(
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNotesCard() {
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
                Iconsax.message_text,
                color: ColorsManager.primaryColor,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text('Important Notes', style: TextStyles.font16DarkGreenBold),
            ],
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.amber.shade200),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Iconsax.danger, size: 18.sp, color: Colors.amber.shade700),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    _prescription!.notes!,
                    style: TextStyles.font14GrayRegular.copyWith(
                      height: 1.6,
                      color: Colors.amber.shade900,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValidityCard() {
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
                Iconsax.calendar_tick,
                color: ColorsManager.primaryColor,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text('Validity Period', style: TextStyles.font16DarkGreenBold),
            ],
          ),
          SizedBox(height: 12.h),
          _buildInfoRow(
            Iconsax.calendar_1,
            'Prescribed Date',
            DateFormat(
              'MMMM dd, yyyy',
            ).format(DateTime.parse(_prescription!.prescribedDate)),
          ),
          if (_prescription!.expiryDate != null) ...[
            SizedBox(height: 8.h),
            _buildInfoRow(
              Iconsax.calendar_remove,
              'Expires On',
              DateFormat(
                'MMMM dd, yyyy',
              ).format(DateTime.parse(_prescription!.expiryDate!)),
            ),
          ],
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
                textButton: 'Download',
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
                textButton: 'Share',
                onPressed: () {
                  // TODO: Implement share
                },
                backgroundColor: Colors.white,
                textColor: ColorsManager.primaryColor,
                height: 48.h,
                raduisBorder: 12,
                borderColor: ColorsManager.primaryColor,
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
            'Failed to load prescription',
            style: TextStyles.font16DarkGreenBold,
          ),
          SizedBox(height: 8.h),
          Text('Please try again later', style: TextStyles.font14GrayRegular),
          SizedBox(height: 24.h),
          CustomMaterialButton(
            textButton: 'Retry',
            onPressed: _fetchPrescription,
            height: 48.h,
            minWidth: 150.w,
            raduisBorder: 12,
          ),
        ],
      ),
    );
  }
}
