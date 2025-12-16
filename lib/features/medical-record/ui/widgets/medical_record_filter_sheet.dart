import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MedicalRecordFilterSheet extends StatefulWidget {
  const MedicalRecordFilterSheet({super.key});

  @override
  State<MedicalRecordFilterSheet> createState() =>
      _MedicalRecordFilterSheetState();
}

class _MedicalRecordFilterSheetState extends State<MedicalRecordFilterSheet> {
  String _selectedSort = 'Date (Newest)';
  String _selectedStatus = 'All';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 20.h),

          // Title
          Text('Filter & Sort', style: TextStyles.font18DarkGreenBold),
          SizedBox(height: 20.h),

          // Sort by
          Text('Sort By', style: TextStyles.font14DarkGreenMedium),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children:
                [
                  'Date (Newest)',
                  'Date (Oldest)',
                  'Title (A-Z)',
                  'Doctor Name',
                ].map((sort) {
                  return ChoiceChip(
                    label: Text(sort),
                    selected: _selectedSort == sort,
                    onSelected: (selected) {
                      setState(() {
                        _selectedSort = sort;
                      });
                    },
                    labelStyle:
                        _selectedSort == sort
                            ? TextStyles.font14GreenSemiBold
                            : TextStyles.font14GrayRegular,
                    backgroundColor: Colors.grey.shade100,
                    selectedColor: ColorsManager.primaryColor.withOpacity(0.15),
                    side: BorderSide(
                      color:
                          _selectedSort == sort
                              ? ColorsManager.primaryColor
                              : Colors.grey.shade300,
                    ),
                  );
                }).toList(),
          ),
          SizedBox(height: 20.h),

          // Status filter
          Text('Status', style: TextStyles.font14DarkGreenMedium),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children:
                ['All', 'Pending', 'Completed', 'Reviewed', 'Archived'].map((
                  status,
                ) {
                  return ChoiceChip(
                    label: Text(status),
                    selected: _selectedStatus == status,
                    onSelected: (selected) {
                      setState(() {
                        _selectedStatus = status;
                      });
                    },
                    labelStyle:
                        _selectedStatus == status
                            ? TextStyles.font14GreenSemiBold
                            : TextStyles.font14GrayRegular,
                    backgroundColor: Colors.grey.shade100,
                    selectedColor: ColorsManager.primaryColor.withOpacity(0.15),
                    side: BorderSide(
                      color:
                          _selectedStatus == status
                              ? ColorsManager.primaryColor
                              : Colors.grey.shade300,
                    ),
                  );
                }).toList(),
          ),
          SizedBox(height: 24.h),

          // Apply button
          CustomMaterialButton(
            textButton: 'Apply Filters',
            onPressed: () {
              // TODO: Apply filters
              context.pop();
            },
            height: 48.h,
            raduisBorder: 12,
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}
