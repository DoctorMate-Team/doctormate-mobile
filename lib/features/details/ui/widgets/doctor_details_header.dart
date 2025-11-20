import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/theme/font_weight_helper.dart';
import 'package:doctor_mate/features/details/data/models/doctor_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class DoctorDetailsHeader extends StatelessWidget {
  final DoctorDetailsModel doctor;

  const DoctorDetailsHeader({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Doctor Image with verified badge
              Stack(
                children: [
                  Hero(
                    tag: 'doctor_image_${doctor.id}',
                    child: Container(
                      height: 90.h,
                      width: 90.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: ColorsManager.primaryColor.withOpacity(0.2),
                          width: 2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18.r),
                        child: CachedNetworkImage(
                          imageUrl: doctor.imageUrl,
                          fit: BoxFit.cover,
                          placeholder:
                              (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                          errorWidget:
                              (context, url, error) => Icon(
                                Icons.person,
                                size: 40.sp,
                                color: Colors.grey,
                              ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: ColorsManager.primaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Icon(
                        Icons.verified,
                        color: Colors.white,
                        size: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),

              horizantialSpacing(16),

              // Doctor Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.fullName,
                      style: TextStyles.font16DarkGreenBold.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeightHelper.bold,
                      ),
                    ),
                    verticalSpacing(6),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: ColorsManager.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            doctor.specialty,
                            style: TextStyles.font12DarkGreenRegular.copyWith(
                              color: ColorsManager.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    verticalSpacing(10),
                    Row(
                      children: [
                        Icon(
                          Iconsax.star_1,
                          color: ColorsManager.gold,
                          size: 18.sp,
                        ),
                        horizantialSpacing(4),
                        Text(
                          '4.8',
                          style: TextStyles.font14DarkGreenMedium.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        horizantialSpacing(4),
                        Text(
                          '(4,279 reviews)',
                          style: TextStyles.font12GrayRegular,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          verticalSpacing(16),

          // Divider
          Divider(color: Colors.grey.shade200, height: 1),

          verticalSpacing(16),

          // Action Buttons Row
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
                  icon: Iconsax.video,
                  label: 'Video',
                  onTap: () {},
                ),
              ),
              horizantialSpacing(12),
              Expanded(
                child: _buildActionButton(
                  icon: Iconsax.message,
                  label: 'Message',
                  onTap: () {},
                ),
              ),
            ],
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
          color: ColorsManager.primaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: ColorsManager.primaryColor.withOpacity(0.1),
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: ColorsManager.primaryColor, size: 22.sp),
            verticalSpacing(4),
            Text(
              label,
              style: TextStyles.font12DarkGreenRegular.copyWith(
                color: ColorsManager.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
