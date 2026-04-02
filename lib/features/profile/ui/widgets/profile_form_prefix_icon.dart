import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileFormPrefixIcon extends StatelessWidget {
  final IconData icon;

  const ProfileFormPrefixIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: Icon(icon, color: ColorsManager.primaryColor),
    );
  }
}
