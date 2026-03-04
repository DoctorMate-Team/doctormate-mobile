import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MedicalRecordAppBar extends StatelessWidget
    implements PreferredSizeWidget {

  const MedicalRecordAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Medical Records', style: TextStyles.font18DarkGreenBold),
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}
