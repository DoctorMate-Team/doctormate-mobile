import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CustomActionProfileButton extends StatelessWidget {
  const CustomActionProfileButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: TextStyles.font14GreenSemiBold),
      trailing: const Icon(Iconsax.arrow_right_3_copy, size: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      onTap: onTap,
    );
  }
}