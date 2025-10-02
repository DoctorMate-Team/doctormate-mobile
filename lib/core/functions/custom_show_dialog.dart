import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<dynamic> showCustomDialog(BuildContext context,
    {required String subtitle,
    required String title,
    required List<Widget> actions}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          style: TextStyles.font24GreenBold,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                subtitle,
                style: TextStyles.font14GrayRegular,
              ),
            ],
          ),
        ),
        actions: actions,
      );
    },
  );
}
