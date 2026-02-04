import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/features/smart-checkup/data/models/smart_check_response.dart';
import 'package:doctor_mate/features/smart-checkup/ui/widgets/diagnosis_result_card.dart';
import 'package:doctor_mate/features/smart-checkup/ui/widgets/recommended_doctors_section.dart';
import 'package:doctor_mate/features/smart-checkup/ui/widgets/result_action_buttons.dart';
import 'package:doctor_mate/features/smart-checkup/ui/widgets/result_app_bar.dart';
import 'package:doctor_mate/features/smart-checkup/ui/widgets/result_disclaimer_card.dart';
import 'package:doctor_mate/features/smart-checkup/ui/widgets/result_header_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmartCheckupResultScreen extends StatelessWidget {
  final SmartCheckResponse checkupResult;
  final String checkType;

  const SmartCheckupResultScreen({
    super.key,
    required this.checkupResult,
    required this.checkType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Column(
          children: [
            const ResultAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ResultHeaderCard(checkupResult: checkupResult),
                    verticalSpacing(24),
                    DiagnosisResultCard(
                      diagnosis: checkupResult,
                      checkType: checkType,
                    ),
                    verticalSpacing(24),
                    RecommendedDoctorsSection(
                      doctors: checkupResult.recommendedDoctors,
                    ),
                    verticalSpacing(24),
                    const ResultActionButtons(),
                    verticalSpacing(16),
                    ResultDisclaimerCard(disclaimer: checkupResult.disclaimer),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
