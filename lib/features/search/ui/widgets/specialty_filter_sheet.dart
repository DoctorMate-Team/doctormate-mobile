import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/home/data/models/specialty_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SpecialtyFilterSheet extends StatelessWidget {
  final List<SpecialtyModel> specialties;
  final String? selectedSpecialtyId;
  final Function(SpecialtyModel) onSpecialtySelected;

  const SpecialtyFilterSheet({
    super.key,
    required this.specialties,
    required this.selectedSpecialtyId,
    required this.onSpecialtySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          verticalSpacing(20),

          // Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Icon(
                  Iconsax.category,
                  color: ColorsManager.primaryColor,
                  size: 24.sp,
                ),
                horizantialSpacing(12),
                Text('Select Specialty', style: TextStyles.font18DarkGreenBold),
                const Spacer(),
                if (selectedSpecialtyId != null)
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: Text(
                      'Clear',
                      style: TextStyles.font14DarkGreenMedium.copyWith(
                        color: Colors.red.shade600,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          verticalSpacing(20),

          // Specialties List
          Container(
            constraints: BoxConstraints(maxHeight: 400.h),
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemCount: specialties.length,
              separatorBuilder:
                  (context, index) =>
                      Divider(height: 1, color: Colors.grey.shade200),
              itemBuilder: (context, index) {
                final specialty = specialties[index];
                final isSelected = specialty.id == selectedSpecialtyId;

                return InkWell(
                  onTap: () {
                    onSpecialtySelected(specialty);
                    context.pop();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Row(
                      children: [
                        // Specialty Icon (placeholder)
                        Container(
                          width: 48.w,
                          height: 48.h,
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? ColorsManager.primaryColor.withOpacity(
                                      0.1,
                                    )
                                    : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            Iconsax.health,
                            color:
                                isSelected
                                    ? ColorsManager.primaryColor
                                    : Colors.grey.shade600,
                            size: 24.sp,
                          ),
                        ),

                        horizantialSpacing(12),

                        // Specialty Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                specialty.name,
                                style: TextStyles.font16DarkGreenBold.copyWith(
                                  color:
                                      isSelected
                                          ? ColorsManager.primaryColor
                                          : null,
                                ),
                              ),
                              verticalSpacing(4),
                              Text(
                                specialty.description,
                                style: TextStyles.font12GrayRegular,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),

                        // Selection Indicator
                        if (isSelected)
                          Icon(
                            Iconsax.tick_circle_copy,
                            color: ColorsManager.primaryColor,
                            size: 24.sp,
                          )
                        else
                          Container(
                            width: 24.w,
                            height: 24.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 2,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          verticalSpacing(20),
        ],
      ),
    );
  }
}
