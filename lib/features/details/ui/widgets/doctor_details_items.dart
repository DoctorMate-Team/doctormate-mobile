import 'package:doctor_mate/core/helper/app_images.dart';
import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/theme/font_weight_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class DoctorDetailsItems extends StatelessWidget {
  const DoctorDetailsItems({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          Container(
            height: 74.h,
            width: 74.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                    image: AssetImage(AppImages.homeDoctorBanner),
                    fit: BoxFit.fill)),
          ),
          horizantialSpacing(16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dr. Sarah Johnson',
                style: TextStyles.font15DarkGreenMedium
                    .copyWith(fontWeight: FontWeightHelper.semiBold),
              ),
              verticalSpacing(8),
              Text(
                'Cardiologist',
                style: TextStyles.font11GrayRegular
                    .copyWith(fontWeight: FontWeightHelper.medium),
              ),
              verticalSpacing(10),
              const RaitingDoctor(),
            ],
          )
        ],
      ),
    );
  }
}

class RaitingDoctor extends StatelessWidget {
  const RaitingDoctor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Iconsax.star_1,
          color: ColorsManager.gold,
        ),
        horizantialSpacing(4),
        Text(
          '4.8 (4,279 reviews)',
          style: TextStyles.font11GrayRegular,
        )
      ],
    );
  }
}