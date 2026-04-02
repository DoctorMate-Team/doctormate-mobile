import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CallTokenDialog extends StatelessWidget {
  final String token;
  final String channel;
  final int expiry;
  final String callType;
  final VoidCallback onClose;

  const CallTokenDialog({
    super.key,
    required this.token,
    required this.channel,
    required this.expiry,
    required this.callType,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('${callType == 'voice' ? 'Voice' : 'Video'} Call'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Token: ${token.substring(0, 20)}...'),
          verticalSpacing(8),
          Text('Channel: $channel'),
          verticalSpacing(8),
          Text('Expiry: $expiry seconds'),
          verticalSpacing(16),
          const Text(
            'Integrate with your call SDK to start the call.',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ],
      ),
      actions: [
        CustomMaterialButton(
          textButton: 'Close',
          onPressed: () {
            context.pop();
            onClose();
          },
          backgroundColor: ColorsManager.primaryColor,
          height: 40.h,
          minWidth: 100.w,
          raduisBorder: 8,
        ),
      ],
    );
  }
}
