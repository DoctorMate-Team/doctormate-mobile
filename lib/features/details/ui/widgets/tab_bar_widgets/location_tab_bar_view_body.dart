import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/theme/font_weight_helper.dart';
import 'package:doctor_mate/features/details/data/models/doctor_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class LocationTabBarViewBody extends StatelessWidget {
  final DoctorDetailsModel doctor;

  const LocationTabBarViewBody({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Clinic Location',
            style: TextStyles.font16DarkGreenBold.copyWith(
              fontWeight: FontWeightHelper.bold,
              fontSize: 18.sp,
            ),
          ),
          verticalSpacing(16),

          // Map Placeholder
          Container(
            height: 200.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: ColorsManager.primaryColor.withOpacity(0.1),
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Iconsax.location,
                    size: 48.sp,
                    color: ColorsManager.primaryColor,
                  ),
                  verticalSpacing(8),
                  Text('Map View', style: TextStyles.font14GrayRegular),
                ],
              ),
            ),
          ),

          verticalSpacing(20),

          // Address Info
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: ColorsManager.primaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: ColorsManager.primaryColor.withOpacity(0.1),
              ),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: ColorsManager.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        Iconsax.building,
                        color: ColorsManager.primaryColor,
                        size: 24.sp,
                      ),
                    ),
                    horizantialSpacing(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${doctor.fullName} Clinic',
                            style: TextStyles.font14DarkGreenMedium.copyWith(
                              fontWeight: FontWeightHelper.semiBold,
                            ),
                          ),
                          verticalSpacing(6),
                          Text(
                            doctor.address,
                            style: TextStyles.font14GrayRegular.copyWith(
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                verticalSpacing(16),
                Divider(color: Colors.grey.shade300),
                verticalSpacing(16),
                Row(
                  children: [
                    Expanded(
                      child: _buildActionButton(
                        icon: Iconsax.call,
                        label: 'Call',
                        onTap: () {},
                      ),
                    ),
                    horizantialSpacing(12),
                    Expanded(
                      child: _buildActionButton(
                        icon: Iconsax.routing,
                        label: 'Direction',
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: ColorsManager.primaryColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 20.sp),
            horizantialSpacing(8),
            Text(
              label,
              style: TextStyles.font16WhiteSemiBold.copyWith(fontSize: 14.sp),
            ),
          ],
        ),
      ),
    );
  }
}
