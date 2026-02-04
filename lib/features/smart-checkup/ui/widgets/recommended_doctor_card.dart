import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:doctor_mate/features/smart-checkup/data/models/symptom_check_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class RecommendedDoctorCard extends StatelessWidget {
  final RecommendedDoctorModel doctor;

  const RecommendedDoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                Row(
                  children: [
                    _buildDoctorImage(),
                    horizantialSpacing(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctor.name ?? 'Unknown Doctor',
                            style: TextStyles.font16DarkGreenBold,
                          ),
                          verticalSpacing(4),
                          _buildSpecialtyChip(),
                          verticalSpacing(8),
                          _buildRatingRow(),
                        ],
                      ),
                    ),
                  ],
                ),
                verticalSpacing(12),
                _buildInfoRow(),
                if (doctor.isAvailable != null) ...[
                  verticalSpacing(12),
                  _buildAvailabilityBadge(),
                ],
              ],
            ),
          ),
          _buildDivider(),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Row(
              children: [
                Expanded(
                  child: CustomMaterialButton(
                    textButton: 'View Profile',
                    onPressed: () {
                      // TODO: Navigate to doctor profile
                    },
                    backgroundColor: Colors.white,
                    borderColor: ColorsManager.primaryColor,
                    textColor: ColorsManager.primaryColor,
                    height: 44.h,
                    raduisBorder: 10,
                  ),
                ),
                horizantialSpacing(8),
                Expanded(
                  child: CustomMaterialButton(
                    textButton: 'Book Now',
                    onPressed: () {
                      // TODO: Navigate to booking
                    },
                    height: 44.h,
                    raduisBorder: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorImage() {
    return Container(
      width: 80.w,
      height: 80.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: ColorsManager.primaryColor.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.primaryColor.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.r),
        child:
            doctor.image != null
                ? CachedNetworkImage(
                  imageUrl: doctor.image!,
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) => Container(
                        color: Colors.grey.shade200,
                        child: Icon(
                          Iconsax.user,
                          color: Colors.grey.shade400,
                          size: 40.sp,
                        ),
                      ),
                  errorWidget:
                      (context, url, error) => Container(
                        color: Colors.grey.shade200,
                        child: Icon(
                          Iconsax.user,
                          color: Colors.grey.shade400,
                          size: 40.sp,
                        ),
                      ),
                )
                : Container(
                  color: Colors.grey.shade200,
                  child: Icon(
                    Iconsax.user,
                    color: Colors.grey.shade400,
                    size: 40.sp,
                  ),
                ),
      ),
    );
  }

  Widget _buildSpecialtyChip() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: ColorsManager.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Iconsax.health, color: ColorsManager.primaryColor, size: 14.sp),
          horizantialSpacing(4),
          Flexible(
            child: Text(
              doctor.specialtyName ?? 'General',
              style: TextStyles.font12DarkGreenSemiBold.copyWith(
                color: ColorsManager.primaryColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingRow() {
    return Row(
      children: [
        Icon(Iconsax.star_1, color: Colors.amber, size: 16.sp),
        horizantialSpacing(4),
        Text('${doctor.rating ?? 0.0}', style: TextStyles.font14GreenSemiBold),
        horizantialSpacing(4),
        Text(
          '(${doctor.reviewCount ?? 0} reviews)',
          style: TextStyles.font12DarkGreenRegular.copyWith(
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow() {
    return Row(
      children: [
        Expanded(
          child: _buildInfoItem(
            Iconsax.wallet_money,
            doctor.consultationFee ?? '\$0',
            Colors.green,
          ),
        ),
        Container(width: 1, height: 30.h, color: Colors.grey.shade300),
        Expanded(
          child: _buildInfoItem(
            Iconsax.briefcase,
            doctor.experience ?? '0 years',
            Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem(IconData icon, String text, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 18.sp),
        horizantialSpacing(6),
        Flexible(
          child: Text(
            text,
            style: TextStyles.font14GreenSemiBold.copyWith(
              color: Colors.grey.shade700,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildAvailabilityBadge() {
    final isAvailable = doctor.isAvailable ?? false;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isAvailable ? Colors.green.shade50 : Colors.orange.shade50,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: isAvailable ? Colors.green.shade200 : Colors.orange.shade200,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8.w,
            height: 8.h,
            decoration: BoxDecoration(
              color: isAvailable ? Colors.green : Colors.orange,
              shape: BoxShape.circle,
            ),
          ),
          horizantialSpacing(8),
          Expanded(
            child: Text(
              isAvailable
                  ? 'Available: ${doctor.nextAvailableSlot ?? 'Now'}'
                  : 'Next available: ${doctor.nextAvailableSlot ?? 'TBD'}',
              style: TextStyles.font12DarkGreenSemiBold.copyWith(
                color:
                    isAvailable
                        ? Colors.green.shade800
                        : Colors.orange.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(height: 1, color: Colors.grey.shade200);
  }
}
