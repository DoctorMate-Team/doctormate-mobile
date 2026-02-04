import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/prescriptions/data/models/prescription_details_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class PrescriptionDoctorCard extends StatelessWidget {
  final PrescriptionDetailsResponse prescription;

  const PrescriptionDoctorCard({super.key, required this.prescription});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Prescribed By', style: TextStyles.font16DarkGreenBold),
          verticalSpacing(12),
          Row(
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundColor: ColorsManager.primaryColor.withOpacity(0.1),
                child:
                    prescription.doctor?.image != null
                        ? CachedNetworkImage(
                          imageUrl: prescription.doctor!.image!,
                          imageBuilder:
                              (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                        )
                        : Icon(
                          Iconsax.user_octagon,
                          color: ColorsManager.primaryColor,
                          size: 30.sp,
                        ),
              ),
              horizantialSpacing(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      prescription.doctor?.name ?? 'Unknown Doctor',
                      style: TextStyles.font16DarkGreenBold,
                    ),
                    verticalSpacing(4),
                    Row(
                      children: [
                        Icon(
                          Iconsax.health,
                          size: 16.sp,
                          color: ColorsManager.primaryColor,
                        ),
                        horizantialSpacing(4),
                        Text(
                          prescription.doctor?.specialty ?? 'General',
                          style: TextStyles.font14GrayRegular.copyWith(
                            color: ColorsManager.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
