import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/profile/ui/widgets/notification_info_card.dart';
import 'package:doctor_mate/features/profile/ui/widgets/notification_setting_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationsSettingsScreen extends StatefulWidget {
  const NotificationsSettingsScreen({super.key});

  @override
  State<NotificationsSettingsScreen> createState() =>
      _NotificationsSettingsScreenState();
}

class _NotificationsSettingsScreenState
    extends State<NotificationsSettingsScreen> {
  bool _appointmentReminders = true;
  bool _promotionalMessages = false;
  bool _healthTips = true;
  bool _systemUpdates = true;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _appointmentReminders =
          prefs.getBool('notification_appointment_reminders') ?? true;
      _promotionalMessages =
          prefs.getBool('notification_promotional_messages') ?? false;
      _healthTips = prefs.getBool('notification_health_tips') ?? true;
      _systemUpdates = prefs.getBool('notification_system_updates') ?? true;
      _isLoading = false;
    });
  }

  Future<void> _savePreference(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);

    // Map keys to FCM topics
    String topicName = '';
    switch (key) {
      case 'notification_appointment_reminders':
        topicName = 'appointment_reminders';
        break;
      case 'notification_promotional_messages':
        topicName = 'promotional_messages';
        break;
      case 'notification_health_tips':
        topicName = 'health_tips';
        break;
      case 'notification_system_updates':
        topicName = 'system_updates';
        break;
    }

    if (topicName.isNotEmpty) {
      try {
        if (value) {
          await FirebaseMessaging.instance.subscribeToTopic(topicName);
        } else {
          await FirebaseMessaging.instance.unsubscribeFromTopic(topicName);
        }
      } catch (e) {
        debugPrint('Failed to update topic subscription: $e');
      }
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Notification preference saved'),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_left_2,
            color: ColorsManager.primaryColor,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Notifications Settings',
          style: TextStyles.font18DarkGreenBold,
        ),
      ),
      body:
          _isLoading
              ? const Center(
                child: CircularProgressIndicator(
                  color: ColorsManager.primaryColor,
                ),
              )
              : SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 20.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Manage your notification preferences',
                        style: TextStyles.font14GrayRegular,
                      ),
                      verticalSpacing(24),

                      // Appointment Reminders
                      NotificationSettingTile(
                        title: 'Appointment Reminders',
                        subtitle:
                            'Get notified about upcoming appointments and changes',
                        icon: Iconsax.calendar,
                        value: _appointmentReminders,
                        onChanged: (value) {
                          setState(() {
                            _appointmentReminders = value;
                          });
                          _savePreference(
                            'notification_appointment_reminders',
                            value,
                          );
                        },
                      ),
                      verticalSpacing(12),

                      // Promotional Messages
                      NotificationSettingTile(
                        title: 'Promotional Messages',
                        subtitle: 'Receive special offers and promotions',
                        icon: Iconsax.tag,
                        value: _promotionalMessages,
                        onChanged: (value) {
                          setState(() {
                            _promotionalMessages = value;
                          });
                          _savePreference(
                            'notification_promotional_messages',
                            value,
                          );
                        },
                      ),
                      verticalSpacing(12),

                      // Health Tips
                      NotificationSettingTile(
                        title: 'Health Tips',
                        subtitle: 'Get personalized health tips and advice',
                        icon: Iconsax.health,
                        value: _healthTips,
                        onChanged: (value) {
                          setState(() {
                            _healthTips = value;
                          });
                          _savePreference('notification_health_tips', value);
                        },
                      ),
                      verticalSpacing(12),

                      // System Updates
                      NotificationSettingTile(
                        title: 'System Updates',
                        subtitle: 'Important app updates and announcements',
                        icon: Iconsax.notification_bing,
                        value: _systemUpdates,
                        onChanged: (value) {
                          setState(() {
                            _systemUpdates = value;
                          });
                          _savePreference('notification_system_updates', value);
                        },
                      ),
                      verticalSpacing(32),

                      const NotificationInfoCard(
                        message:
                            'You can change these settings anytime. Some critical notifications cannot be turned off.',
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}
