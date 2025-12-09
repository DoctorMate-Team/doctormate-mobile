import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AppointmentAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onSearchPressed;
  final VoidCallback onFilterPressed;

  const AppointmentAppBar({
    super.key,
    required this.onSearchPressed,
    required this.onFilterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('My Appointments', style: TextStyles.font18DarkGreenBold),
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(
            Iconsax.search_normal_copy,
            color: ColorsManager.darkBlue,
            size: 24.sp,
          ),
          onPressed: onSearchPressed,
        ),
        IconButton(
          icon: Icon(
            Iconsax.filter_copy,
            color: ColorsManager.darkBlue,
            size: 24.sp,
          ),
          onPressed: onFilterPressed,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}
