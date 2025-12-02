import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/theme/font_weight_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AppointmentTypeList extends StatefulWidget {
  const AppointmentTypeList({super.key});

  @override
  State<AppointmentTypeList> createState() => _AppointmentTypeListState();
}

class _AppointmentTypeListState extends State<AppointmentTypeList> {
  int selectedType = 0;

  final List<Map<String, dynamic>> appointmentTypes = [
    {
      'icon': Iconsax.video,
      'title': 'Video Call',
      'description': 'Consult via video call',
      'color': ColorsManager.primaryColor,
      'bgColor': ColorsManager.lighterMainBlue,
    },
    {
      'icon': Iconsax.call,
      'title': 'Voice Call',
      'description': 'Consult via voice call',
      'color': ColorsManager.green,
      'bgColor': ColorsManager.lightGreen,
    },
    {
      'icon': Iconsax.hospital,
      'title': 'In-Person',
      'description': 'Visit clinic in person',
      'color': ColorsManager.gold,
      'bgColor': const Color(0xFFFFF9E6),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Appointment Type',
          style: TextStyles.font15DarkGreenMedium.copyWith(
            fontWeight: FontWeightHelper.semiBold,
          ),
        ),
        verticalSpacing(16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: appointmentTypes.length,
          separatorBuilder: (context, index) => verticalSpacing(12),
          itemBuilder: (context, index) {
            final type = appointmentTypes[index];
            final isSelected = selectedType == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedType = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color:
                      isSelected
                          ? type['bgColor'].withOpacity(0.3)
                          : ColorsManager.moreLighterGray,
                  border: Border.all(
                    color: isSelected ? type['color'] : Colors.transparent,
                    width: 2,
                  ),
                  boxShadow:
                      isSelected
                          ? [
                            BoxShadow(
                              color: type['color'].withOpacity(0.15),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ]
                          : null,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        color: type['bgColor'],
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        type['icon'],
                        color: type['color'],
                        size: 24.sp,
                      ),
                    ),
                    horizantialSpacing(16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            type['title'],
                            style: TextStyles.font14GreenSemiBold.copyWith(
                              color: ColorsManager.darkBlue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          verticalSpacing(4),
                          Text(
                            type['description'],
                            style: TextStyles.font12GrayRegular,
                          ),
                        ],
                      ),
                    ),
                    AnimatedScale(
                      scale: isSelected ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: Container(
                        padding: EdgeInsets.all(4.r),
                        decoration: BoxDecoration(
                          color: type['color'],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
