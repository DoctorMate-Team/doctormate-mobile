import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/features/home/data/models/doctor_model.dart';
import 'package:doctor_mate/features/home/ui/widgets/doctors_list_for_specialist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorsListWidget extends StatelessWidget {
  final List<DoctorModel> doctors;
  final ScrollController scrollController;
  final bool isLoadingMore;

  const DoctorsListWidget({
    super.key,
    required this.doctors,
    required this.scrollController,
    required this.isLoadingMore,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: doctors.length + (isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == doctors.length) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: ColorsManager.primaryColor,
              ),
            ),
          );
        }
        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: DoctorCard(doctor: doctors[index]),
        );
      },
    );
  }
}
