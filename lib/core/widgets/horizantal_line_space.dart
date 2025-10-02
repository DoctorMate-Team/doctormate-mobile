import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HorizantalLineSpace extends StatelessWidget {
  const HorizantalLineSpace({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5.h,
      width: double.infinity,
      color: ColorsManager.lightGray,
    );
  }
}