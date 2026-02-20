import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/appointment/data/models/appointment_list_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class DoctorInfoWidget extends StatelessWidget {
  final AppointmentDoctorModel doctor;

  const DoctorInfoWidget({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: CachedNetworkImage(
              imageUrl: doctor.image,
              width: 60.w,
              height: 60.h,
              fit: BoxFit.cover,
              placeholder:
                  (context, url) => Container(
                    color: Colors.grey[200],
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: ColorsManager.primaryColor,
                      ),
                    ),
                  ),
              errorWidget:
                  (context, url, error) => Container(
                    color: Colors.grey[200],
                    child: Icon(Iconsax.user, color: Colors.grey[400]),
                  ),
            ),
          ),
          horizantialSpacing(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dr. ${doctor.doctorName}',
                  style: TextStyles.font16DarkGreenBold.copyWith(color: Colors.black),
                ),
                verticalSpacing(4),
                Row(
                  children: [
                    Icon(
                      Iconsax.health,
                      size: 14.sp,
                      color: ColorsManager.primaryColor,
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        doctor.specialtyName,
                        style: TextStyles.font12GrayRegular.copyWith(
                          color: ColorsManager.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                verticalSpacing(4),
                Row(
                  children: [
                    Icon(Iconsax.location, size: 14.sp, color: Colors.grey),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        doctor.address,
                        style: TextStyles.font12GrayRegular,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
}
