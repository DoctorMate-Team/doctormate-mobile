import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/routing/routes.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ModernQuickActions extends StatelessWidget {
  const ModernQuickActions({super.key});

  void _handleActionTap(BuildContext context, String label) {
    switch (label) {
      case 'Smart Checkup':
        context.push(Routes.smartCheckupScreen);
        break;
      case 'Scan QR':
        context.push(Routes.qrScannerScreen);
        break;
    }
  }

  final List<Map<String, dynamic>> _actions = const [
    {
      'icon': Iconsax.scan_barcode,
      'label': 'Scan QR',
      'subtitle': 'Quick scan for appointments',
      'color': Color(0xFF9C27B0),
      'gradient': [Color(0xFF9C27B0), Color(0xFF7B1FA2)],
    },
    {
      'icon': Iconsax.heart_add,
      'label': 'Smart Checkup',
      'subtitle': 'AI-powered health checkup',
      'color': Color(0xFFEA4335),
      'gradient': [Color(0xFFEA4335), Color(0xFFD32F2F)],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 1.2,
      ),
      itemCount: _actions.length,
      itemBuilder: (context, index) {
        final action = _actions[index];
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: action['gradient'] as List<Color>,
            ),
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: (action['color'] as Color).withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
                spreadRadius: 0,
              ),
              BoxShadow(
                color: Colors.white.withOpacity(0.1),
                blurRadius: 1,
                offset: const Offset(0, 1),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20.r),
              onTap: () {
                _handleActionTap(context, action['label'] as String);
              },
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44.w,
                      height: 44.h,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1.5,
                        ),
                      ),
                      child: Icon(
                        action['icon'],
                        color: Colors.white,
                        size: 22.sp,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      action['label'],
                      style: TextStyles.font14GreenSemiBold.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    verticalSpacing(2),
                    Text(
                      action['subtitle'],
                      style: TextStyles.font10DarkGreenRegular.copyWith(
                        color: Colors.white.withOpacity(0.8),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
