import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomMaterialButton extends StatelessWidget {
  const CustomMaterialButton({
    super.key,
    required this.textButton,
    required this.onPressed,
    this.backgroundColor,
    this.raduisBorder,
    this.height,
    this.padding,
    this.textColor,
    this.minWidth,
    this.borderColor,
  });
  final String textButton;
  final Function() onPressed;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? raduisBorder;
  final double? height;
  final double? minWidth;
  final EdgeInsets? padding;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: backgroundColor ?? ColorsManager.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(raduisBorder ?? 8),
        side: BorderSide(color: borderColor ?? ColorsManager.primaryColor),
      ),
      minWidth: minWidth ?? double.infinity,
      padding: padding,
      height: height ?? 43.h,
      child: Text(
        textButton,
        style: TextStyles.font16WhiteMedium.copyWith(color: textColor),
      ),
    );
  }
}
