import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/routing/routes.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/theme/font_weight_helper.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:doctor_mate/features/home/data/models/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class DoctorsListForSpecialist extends StatelessWidget {
  final List<DoctorModel> doctors;

  const DoctorsListForSpecialist({super.key, required this.doctors});

  @override
  Widget build(BuildContext context) {
    if (doctors.isEmpty) {
      return Container(
        padding: EdgeInsets.all(32.w),
        child: Column(
          children: [
            Icon(Iconsax.user_minus, size: 48.sp, color: Colors.grey.shade400),
            verticalSpacing(16),
            Text(
              'No doctors available for this specialty',
              style: TextStyles.font18DarkGreenBold.copyWith(
                fontSize: 16.sp,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Column(
      children:
          doctors
              .map(
                (doctor) => Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to details screen with doctor ID
                      context.pushNamed(Routes.detailsScreen, extra: doctor.id);
                    },
                    child: DoctorCard(doctor: doctor),
                  ),
                ),
              )
              .toList(),
    );
  }
}

// Individual Doctor Card
class DoctorCard extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorCard({super.key, required this.doctor});

  bool _isValidImageUrl(String? url) {
    if (url == null || url.isEmpty) return false;
    if (url.startsWith('//')) return false; // Invalid scheme
    if (url.toLowerCase().contains('default image')) return false;
    return Uri.tryParse(url)?.hasScheme ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Doctor Image
              Container(
                width: 70.w,
                height: 70.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: Colors.grey.shade200,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child:
                      _isValidImageUrl(doctor.imageUrl)
                          ? CachedNetworkImage(
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
                          )
                          : Icon(Icons.person, size: 40.sp, color: Colors.grey),
                ),
              ),
              horizantialSpacing(16),

              // Doctor Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.fullName,
                      style: TextStyles.font16DarkGreenBold,
                    ),
                    verticalSpacing(4),
                    Text(
                      doctor.address ?? 'Address not available',
                      style: TextStyles.font14GrayRegular,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (doctor.qualifications != null) ...[
                      verticalSpacing(8),
                      Row(
                        children: [
                          Icon(Icons.verified, size: 16.sp, color: Colors.blue),
                          horizantialSpacing(4),
                          Expanded(
                            child: Text(
                              doctor.qualifications!,
                              style: TextStyles.font14DarkGreenMedium.copyWith(
                                fontWeight: FontWeightHelper.semiBold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              // Price
              if (doctor.consultationFee != null)
                Column(
                  children: [
                    Text(
                      'EGP ${doctor.consultationFee!.toStringAsFixed(0)}',
                      style: TextStyles.font16DarkGreenBold,
                    ),
                    Text('per visit', style: TextStyles.font12GrayRegular),
                  ],
                ),
            ],
          ),

          verticalSpacing(16),

          // Availability and Book Button
          Row(
            children: [
              if (doctor.workingTime != null)
                Container(
                  height: 36.h,
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.access_time, size: 14.sp, color: Colors.green),
                      horizantialSpacing(6),
                      Text(
                        doctor.workingTime!,
                        style: TextStyles.font12DarkGreenSemiBold,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

              const Spacer(),

              // Book Button
              CustomMaterialButton(
                minWidth: 100.w,
                height: 36.h,
                textButton: 'Book Now',
                onPressed: () {
                  context.pushNamed(Routes.detailsScreen, extra: doctor.id);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
