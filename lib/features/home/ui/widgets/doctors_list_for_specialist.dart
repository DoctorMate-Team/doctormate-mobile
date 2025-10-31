import 'package:doctor_mate/core/helper/app_images.dart';
import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/theme/font_weight_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class DoctorsListForSpecialist extends StatelessWidget {
  final String specialist;

  const DoctorsListForSpecialist({super.key, required this.specialist});

  List<Map<String, dynamic>> _getDoctorsForSpecialist(String specialist) {
    // Sample data - replace with actual data source
    final Map<String, List<Map<String, dynamic>>> doctorsBySpecialty = {
      'Cardiology': [
        {
          'name': 'Dr. Sarah Johnson',
          'rating': 4.9,
          'experience': '15 years',
          'hospital': 'Heart Care Center',
          'price': '150',
          'image': AppImages.homeDoctorBanner,
          'availability': 'Available Today',
        },
        {
          'name': 'Dr. Michael Chen',
          'rating': 4.8,
          'experience': '12 years',
          'hospital': 'Cardiac Institute',
          'price': '120',
          'image': AppImages.homeDoctorBanner,
          'availability': 'Available Tomorrow',
        },
      ],
      'Neurology': [
        {
          'name': 'Dr. Emily Rodriguez',
          'rating': 4.9,
          'experience': '18 years',
          'hospital': 'Neuro Specialist Center',
          'price': '200',
          'image': AppImages.homeDoctorBanner,
          'availability': 'Available Today',
        },
        {
          'name': 'Dr. James Wilson',
          'rating': 4.7,
          'experience': '10 years',
          'hospital': 'Brain Health Clinic',
          'price': '180',
          'image': AppImages.homeDoctorBanner,
          'availability': 'Available Friday',
        },
      ],
      'Orthopedic': [
        {
          'name': 'Dr. Amanda Taylor',
          'rating': 4.8,
          'experience': '14 years',
          'hospital': 'Bone & Joint Center',
          'price': '130',
          'image': AppImages.homeDoctorBanner,
          'availability': 'Available Today',
        },
        {
          'name': 'Dr. Robert Davis',
          'rating': 4.6,
          'experience': '16 years',
          'hospital': 'Orthopedic Institute',
          'price': '140',
          'image': AppImages.homeDoctorBanner,
          'availability': 'Available Monday',
        },
      ],
      'Pediatrics': [
        {
          'name': 'Dr. Lisa Anderson',
          'rating': 4.9,
          'experience': '12 years',
          'hospital': 'Children\'s Medical Center',
          'price': '100',
          'image': AppImages.homeDoctorBanner,
          'availability': 'Available Today',
        },
        {
          'name': 'Dr. Kevin Martinez',
          'rating': 4.8,
          'experience': '9 years',
          'hospital': 'Kids Health Clinic',
          'price': '90',
          'image': AppImages.homeDoctorBanner,
          'availability': 'Available Tomorrow',
        },
      ],
      'Dermatology': [
        {
          'name': 'Dr. Jennifer Lee',
          'rating': 4.7,
          'experience': '11 years',
          'hospital': 'Skin Care Institute',
          'price': '110',
          'image': AppImages.homeDoctorBanner,
          'availability': 'Available Today',
        },
        {
          'name': 'Dr. David Brown',
          'rating': 4.6,
          'experience': '13 years',
          'hospital': 'Dermatology Center',
          'price': '125',
          'image': AppImages.homeDoctorBanner,
          'availability': 'Available Thursday',
        },
      ],
    };

    return doctorsBySpecialty[specialist] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final doctors = _getDoctorsForSpecialist(specialist);

    if (doctors.isEmpty) {
      return Container(
        padding: EdgeInsets.all(32.w),
        child: Column(
          children: [
            Icon(Iconsax.user_minus, size: 48.sp, color: Colors.grey.shade400),
            verticalSpacing(16),
            Text(
              'No doctors available for $specialist',
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
                  child: DoctorCard(doctor: doctor),
                ),
              )
              .toList(),
    );
  }
}

// Individual Doctor Card
class DoctorCard extends StatelessWidget {
  final Map<String, dynamic> doctor;

  const DoctorCard({super.key, required this.doctor});

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
                  image: DecorationImage(
                    image: AssetImage(doctor['image']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              horizantialSpacing(16),

              // Doctor Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(doctor['name'], style: TextStyles.font16DarkGreenBold),
                    verticalSpacing(4),
                    Text(
                      doctor['hospital'],
                      style: TextStyles.font14GrayRegular,
                    ),
                    verticalSpacing(8),
                    Row(
                      children: [
                        Icon(Icons.star, size: 16.sp, color: Colors.amber),
                        horizantialSpacing(4),
                        Text(
                          '${doctor['rating']}',
                          style: TextStyles.font14DarkGreenMedium.copyWith(
                            fontWeight: FontWeightHelper.semiBold,
                          ),
                        ),
                        horizantialSpacing(8),
                        Text(
                          '• ${doctor['experience']}',
                          style: TextStyles.font14GrayRegular,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Price
              Column(
                children: [
                  Text(
                    '\$${doctor['price']}',
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.circle, size: 8.sp, color: Colors.green),
                    horizantialSpacing(6),
                    Text(
                      doctor['availability'],
                      style: TextStyles.font12DarkGreenSemiBold,
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Book Button
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12.r),
                  onTap: () {
                    // Handle booking action
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Booking appointment with ${doctor['name']}',
                        ),
                        backgroundColor: ColorsManager.primaryColor,
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: ColorsManager.primaryColor,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      'Book Now',
                      style: TextStyles.font14WhiteRegular.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
