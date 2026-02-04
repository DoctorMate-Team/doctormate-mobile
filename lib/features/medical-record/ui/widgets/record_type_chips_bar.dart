import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecordTypeChipsBar extends StatelessWidget {
  final String selectedType;
  final Function(String) onTypeChanged;

  const RecordTypeChipsBar({
    super.key,
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final recordTypes = [
      'All',
      'Lab Results',
      'Prescriptions',
      'Imaging',
      'Diagnosis',
      'Vaccination',
      'Surgery',
    ];

    return Container(
      height: 50.h,
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        scrollDirection: Axis.horizontal,
        itemCount: recordTypes.length,
        separatorBuilder: (context, index) => horizantialSpacing(8),
        itemBuilder: (context, index) {
          final type = recordTypes[index];
          final isSelected = selectedType == type;

          return FilterChip(
            label: Text(type),
            selected: isSelected,
            onSelected: (selected) => onTypeChanged(type),
            labelStyle:
                isSelected
                    ? TextStyles.font14GreenSemiBold
                    : TextStyles.font14GrayRegular,
            backgroundColor: Colors.grey.shade100,
            selectedColor: ColorsManager.primaryColor.withOpacity(0.15),
            checkmarkColor: ColorsManager.primaryColor,
            side: BorderSide(
              color:
                  isSelected
                      ? ColorsManager.primaryColor
                      : Colors.grey.shade300,
            ),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          );
        },
      ),
    );
  }
}
