import 'package:flutter/material.dart';

class CustomIconContainer extends StatelessWidget {
  const CustomIconContainer({
    super.key,
    required this.backgroundColor,
    required this.icon,
    required this.colorIcon,
  });

  final Color backgroundColor;
  final IconData icon;
  final Color colorIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: colorIcon),
    );
  }
}