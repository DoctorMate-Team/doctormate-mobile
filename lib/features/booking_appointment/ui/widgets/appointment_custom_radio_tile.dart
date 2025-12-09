import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/widgets/custom_icon_container.dart';
import 'package:flutter/material.dart';

class AppointmentCustomRadioTile extends StatelessWidget {
  const AppointmentCustomRadioTile({
    super.key,
    required this.icon,
    required this.text,
    required this.colorIcon,
    required this.backgroundColor,
    required this.value,
    required this.groupValue,
    this.onChanged,
  });
  final IconData icon;
  final String text;
  final Color colorIcon;
  final Color backgroundColor;
  final int value;
  final int groupValue;
  final Function(int?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return RadioListTile(
        activeColor: ColorsManager.primaryColor,
        title: Text(text),
        secondary: CustomIconContainer(
            backgroundColor: backgroundColor, icon: icon, colorIcon: colorIcon),
        controlAffinity: ListTileControlAffinity.trailing,
        value: value,
        groupValue: groupValue,
        onChanged: onChanged);
  }
}
