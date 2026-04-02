import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class NavigationItemModel {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final Color color;
  final int badgeCount;

  NavigationItemModel({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.color,
    this.badgeCount = 0,
  });

  static final List<NavigationItemModel> items = [
    NavigationItemModel(
      icon: Iconsax.home_2,
      activeIcon: Iconsax.home,
      label: 'Home',
      color: ColorsManager.primaryColor,
      badgeCount: 0,
    ),
    NavigationItemModel(
      icon: Iconsax.calendar,
      activeIcon: Iconsax.calendar_1,
      label: 'Appointments',
      color: ColorsManager.primaryColor,
      badgeCount: 2, // Example: 2 upcoming appointments
    ),
    NavigationItemModel(
      icon: Iconsax.health,
      activeIcon: Iconsax.clipboard_text,
      label: 'Record',
      color: ColorsManager.primaryColor,
      badgeCount: 0,
    ),
    NavigationItemModel(
      icon: Iconsax.message,
      activeIcon: Iconsax.messages,
      label: 'Messages',
      color: ColorsManager.primaryColor,
      badgeCount: 5, // Example: 5 unread messages
    ),
    NavigationItemModel(
      icon: Iconsax.profile_circle,
      activeIcon: Iconsax.user,
      label: 'Profile',
      color: ColorsManager.primaryColor,
      badgeCount: 0,
    ),
  ];
}
