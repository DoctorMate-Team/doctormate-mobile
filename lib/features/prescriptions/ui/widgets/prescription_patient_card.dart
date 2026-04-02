import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/prescriptions/data/models/prescription_details_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class PrescriptionPatientCard extends StatelessWidget {
  final PrescriptionDetailsResponse prescription;

  const PrescriptionPatientCard({super.key, required this.prescription});

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
          Text('Patient Information', style: TextStyles.font16DarkGreenBold),
          verticalSpacing(12),
          Row(
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundColor: ColorsManager.primaryColor.withOpacity(0.1),
                child:
                    prescription.patient?.image != null
                        ? CachedNetworkImage(
                          imageUrl: prescription.patient!.image!,
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
                          Iconsax.user,
                          color: ColorsManager.primaryColor,
                          size: 30.sp,
                        ),
              ),
              horizantialSpacing(16),
              Expanded(
                child: Text(
                  prescription.patient?.name ?? 'Unknown Patient',
                  style: TextStyles.font16DarkGreenBold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
