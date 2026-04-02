import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class NotificationsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final VoidCallback? onMarkAllRead;

  const NotificationsAppBar({super.key, this.onMarkAllRead});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Notifications', style: TextStyles.font18DarkGreenBold),
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: ColorsManager.darkBlue),
        onPressed: () => context.pop(),
      ),
      actions: [
        IconButton(
          onPressed: onMarkAllRead,
          icon: Icon(
            Iconsax.tick_circle,
            color: ColorsManager.primaryColor,
            size: 24.sp,
          ),
          tooltip: 'Mark all as read',
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}
