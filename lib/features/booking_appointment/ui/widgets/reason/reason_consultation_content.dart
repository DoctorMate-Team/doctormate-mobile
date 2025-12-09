import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/theme/font_weight_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ReasonConsultationContent extends StatefulWidget {
  final Function(String)? onReasonSelected;
  final String? initialReason;

  const ReasonConsultationContent({
    super.key,
    this.onReasonSelected,
    this.initialReason,
  });

  @override
  State<ReasonConsultationContent> createState() =>
      _ReasonConsultationContentState();
}

class _ReasonConsultationContentState extends State<ReasonConsultationContent> {
  int? selectedReasonIndex;
  final TextEditingController _otherReasonController = TextEditingController();
  bool showOtherTextField = false;

  @override
  void initState() {
    super.initState();
    _initializeSelection();
  }

  void _initializeSelection() {
    if (widget.initialReason != null && widget.initialReason!.isNotEmpty) {
      // Check if it matches a predefined reason
      bool found = false;
      for (int i = 0; i < consultationReasons.length; i++) {
        if (consultationReasons[i]['title'] == widget.initialReason) {
          setState(() {
            selectedReasonIndex = i;
          });
          found = true;
          break;
        }
      }
      // If not found in predefined reasons, it's a custom reason
      if (!found) {
        setState(() {
          selectedReasonIndex = consultationReasons.length; // "Other" option
          showOtherTextField = true;
          _otherReasonController.text = widget.initialReason!;
        });
      }
    }
  }

  @override
  void didUpdateWidget(ReasonConsultationContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialReason != widget.initialReason &&
        widget.initialReason != null) {
      _initializeSelection();
    }
  }

  final List<Map<String, dynamic>> consultationReasons = [
    {
      'icon': Iconsax.heart,
      'title': 'Regular Checkup',
      'description': 'Routine health examination',
      'color': ColorsManager.primaryColor,
      'bgColor': ColorsManager.lighterMainBlue,
    },
    {
      'icon': Iconsax.health,
      'title': 'Follow-up Visit',
      'description': 'Previous treatment review',
      'color': ColorsManager.green,
      'bgColor': ColorsManager.lightGreen,
    },
    {
      'icon': Iconsax.activity,
      'title': 'New Symptoms',
      'description': 'First-time consultation',
      'color': ColorsManager.warningRed,
      'bgColor': const Color(0xFFFFEBEE),
    },
    {
      'icon': Iconsax.document_text,
      'title': 'Medical Reports',
      'description': 'Discuss test results',
      'color': ColorsManager.gold,
      'bgColor': const Color(0xFFFFF9E6),
    },
    {
      'icon': Iconsax.more,
      'title': 'Other',
      'description': 'Specify your reason',
      'color': ColorsManager.lightGray,
      'bgColor': ColorsManager.moreLighterGray,
    },
  ];

  @override
  void dispose() {
    _otherReasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reason For Consultation',
            style: TextStyles.font15DarkGreenMedium.copyWith(
              fontWeight: FontWeightHelper.semiBold,
            ),
          ),
          verticalSpacing(8),
          Text(
            'Please select the reason for your appointment',
            style: TextStyles.font12GrayRegular,
          ),
          verticalSpacing(20),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: consultationReasons.length,
            separatorBuilder: (context, index) => verticalSpacing(12),
            itemBuilder: (context, index) {
              final reason = consultationReasons[index];
              final isSelected = selectedReasonIndex == index;
              final isOther = index == consultationReasons.length - 1;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedReasonIndex = index;
                    showOtherTextField = isOther;
                    if (!isOther) {
                      _otherReasonController.clear();
                      widget.onReasonSelected?.call(reason['title']);
                    }
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color:
                        isSelected
                            ? reason['bgColor'].withOpacity(0.3)
                            : ColorsManager.moreLighterGray,
                    border: Border.all(
                      color: isSelected ? reason['color'] : Colors.transparent,
                      width: 2,
                    ),
                    boxShadow:
                        isSelected
                            ? [
                              BoxShadow(
                                color: reason['color'].withOpacity(0.15),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ]
                            : null,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12.r),
                        decoration: BoxDecoration(
                          color: reason['bgColor'],
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(
                          reason['icon'],
                          color: reason['color'],
                          size: 24.sp,
                        ),
                      ),
                      horizantialSpacing(16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              reason['title'],
                              style: TextStyles.font14GreenSemiBold.copyWith(
                                color: ColorsManager.darkBlue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            verticalSpacing(4),
                            Text(
                              reason['description'],
                              style: TextStyles.font12GrayRegular,
                            ),
                          ],
                        ),
                      ),
                      AnimatedScale(
                        scale: isSelected ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 200),
                        child: Container(
                          padding: EdgeInsets.all(4.r),
                          decoration: BoxDecoration(
                            color: reason['color'],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          if (showOtherTextField) ...[
            verticalSpacing(20),
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: ColorsManager.moreLighterGray,
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorsManager.lightGray.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Describe Your Reason',
                    style: TextStyles.font14GreenSemiBold.copyWith(
                      color: ColorsManager.darkBlue,
                    ),
                  ),
                  verticalSpacing(12),
                  TextField(
                    controller: _otherReasonController,
                    maxLines: 4,
                    onChanged: (value) {
                      widget.onReasonSelected?.call(value);
                    },
                    decoration: InputDecoration(
                      hintText:
                          'Please describe your reason for consultation...',
                      hintStyle: TextStyles.font12GrayRegular,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: ColorsManager.lighterGray,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: ColorsManager.lighterGray,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: ColorsManager.primaryColor,
                          width: 2,
                        ),
                      ),
                      filled: true,
                      fillColor: ColorsManager.moreLighterGray,
                      contentPadding: EdgeInsets.all(16.r),
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
}
