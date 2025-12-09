import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter Appointments',
                style: TextStyles.font18DarkGreenBold,
              ),
              IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          verticalSpacing(20),
          Text('Sort By', style: TextStyles.font14GreenSemiBold),
          verticalSpacing(12),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children:
                [
                  'Date (Newest)',
                  'Date (Oldest)',
                  'Doctor Name',
                  'Specialty',
                ].map((filter) {
                  return ChoiceChip(
                    label: Text(filter),
                    selected: false,
                    onSelected: (selected) {
                      // TODO: Apply filter
                      context.pop();
                    },
                    selectedColor: ColorsManager.primaryColor,
                    backgroundColor: Colors.grey.shade100,
                    labelStyle: TextStyles.font12GrayRegular,
                  );
                }).toList(),
          ),
          verticalSpacing(20),
          CustomMaterialButton(
            textButton: 'Apply Filters',
            onPressed: () => context.pop(),
            backgroundColor: ColorsManager.primaryColor,
            height: 48.h,
            raduisBorder: 12,
          ),
        ],
      ),
    );
  }
}
