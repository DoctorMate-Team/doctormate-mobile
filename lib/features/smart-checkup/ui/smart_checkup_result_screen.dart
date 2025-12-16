import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:doctor_mate/features/smart-checkup/data/models/symptom_check_response.dart';
import 'package:doctor_mate/features/smart-checkup/ui/widgets/diagnosis_result_card.dart';
import 'package:doctor_mate/features/smart-checkup/ui/widgets/recommended_doctor_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SmartCheckupResultScreen extends StatelessWidget {
  final SymptomCheckResponse checkupResult;

  const SmartCheckupResultScreen({super.key, required this.checkupResult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    verticalSpacing(24),
                    if (checkupResult.diagnosis != null)
                      DiagnosisResultCard(
                        diagnosis: checkupResult.diagnosis!,
                        checkType: checkupResult.checkType ?? 'symptom',
                      ),
                    verticalSpacing(24),
                    _buildRecommendedDoctorsSection(),
                    verticalSpacing(24),
                    _buildActionButtons(context),
                    verticalSpacing(16),
                    _buildDisclaimerCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              width: 40.w,
              height: 40.h,
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
          Text('Checkup Results', style: TextStyles.font18DarkGreenBold),
          const Spacer(),
          GestureDetector(
            onTap: () {
              // TODO: Share results
            },
            child: Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: ColorsManager.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Iconsax.share,
                color: ColorsManager.primaryColor,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final diagnosis = checkupResult.diagnosis;
    Color severityColor = Colors.green;
    IconData severityIcon = Iconsax.tick_circle;

    if (diagnosis?.severity == 'moderate') {
      severityColor = Colors.orange;
      severityIcon = Iconsax.info_circle;
    } else if (diagnosis?.severity == 'severe') {
      severityColor = Colors.red;
      severityIcon = Iconsax.danger;
    }

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors:
              severityColor is MaterialColor
                  ? [severityColor.shade600, severityColor.shade400]
                  : [severityColor, severityColor.withOpacity(0.8)],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: severityColor.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
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
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Icon(severityIcon, color: Colors.white, size: 28.sp),
              ),
              horizantialSpacing(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Analysis Complete',
                      style: TextStyles.font14DarkGreenMedium.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    verticalSpacing(4),
                    Text(
                      diagnosis?.condition ?? 'Unknown Condition',
                      style: TextStyles.font18DarkGreenBold.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (diagnosis?.confidenceScore != null) ...[
            verticalSpacing(16),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Iconsax.chart, color: Colors.white, size: 16.sp),
                  horizantialSpacing(6),
                  Text(
                    'Confidence: ${(diagnosis!.confidenceScore! * 100).toStringAsFixed(0)}%',
                    style: TextStyles.font12DarkGreenSemiBold.copyWith(
                      color: Colors.white,
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

  Widget _buildRecommendedDoctorsSection() {
    if (checkupResult.recommendedDoctors == null ||
        checkupResult.recommendedDoctors!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Iconsax.user_octagon,
              color: ColorsManager.primaryColor,
              size: 24.sp,
            ),
            horizantialSpacing(8),
            Text('Recommended Doctors', style: TextStyles.font18DarkGreenBold),
          ],
        ),
        verticalSpacing(8),
        Text(
          'Top specialists for your condition',
          style: TextStyles.font14DarkGreenMedium.copyWith(
            color: Colors.grey.shade600,
          ),
        ),
        verticalSpacing(16),
        ...checkupResult.recommendedDoctors!.map((doctor) {
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: RecommendedDoctorCard(doctor: doctor),
          );
        }),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomMaterialButton(
            textButton: 'New Checkup',
            onPressed: () {
              context.pop();
            },
            backgroundColor: Colors.white,
            borderColor: ColorsManager.primaryColor,
            textColor: ColorsManager.primaryColor,
            height: 50.h,
            raduisBorder: 12,
          ),
        ),
        horizantialSpacing(12),
        Expanded(
          child: CustomMaterialButton(
            textButton: 'Save Report',
            onPressed: () {
              // TODO: Save report
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Report saved successfully'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
            height: 50.h,
            raduisBorder: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildDisclaimerCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.amber.shade200, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Iconsax.danger, color: Colors.amber.shade700, size: 20.sp),
          horizantialSpacing(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Medical Disclaimer',
                  style: TextStyles.font14GreenSemiBold.copyWith(
                    color: Colors.amber.shade900,
                  ),
                ),
                verticalSpacing(4),
                Text(
                  'This AI-generated analysis is not a substitute for professional medical advice. Please consult with a qualified healthcare provider for proper diagnosis and treatment.',
                  style: TextStyles.font12DarkGreenRegular.copyWith(
                    color: Colors.amber.shade800,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
