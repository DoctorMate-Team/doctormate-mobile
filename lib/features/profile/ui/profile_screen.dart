import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:doctor_mate/features/auth/ui/widgets/custom_profile_screen_image.dart';
import 'package:doctor_mate/features/profile/logic/cubit/profile_cubit.dart';
import 'package:doctor_mate/features/profile/logic/cubit/profile_state.dart';
import 'package:doctor_mate/features/profile/ui/widgets/custom_action_profile_button.dart';
import 'package:doctor_mate/features/profile/ui/widgets/profile_shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:doctor_mate/core/routing/routes.dart';
import 'package:doctor_mate/core/helper/cache_helper.dart';
import 'package:doctor_mate/core/helper/constants.dart';
import 'package:doctor_mate/core/di/dependency_injection.dart';
import 'package:doctor_mate/core/networking/device_token_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProfileCubit, ProfileState>(
          buildWhen:
              (previous, current) =>
                  current is GetProfileLoading ||
                  current is GetProfileSuccess ||
                  current is GetProfileError,
          builder: (context, state) {
            return state.maybeWhen(
              getProfileLoading: () => const ProfileShimmerLoading(),
              getProfileSuccess:
                  (profile) => Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0.w,
                      vertical: 20.0.h,
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                CustomProfileScreenImage(
                                  imageUrl: profile.imageUrl,
                                  onTap: () {
                                    // Handle profile image tap (e.g., open image picker)
                                  },
                                  isEdit: false,
                                ),
                                verticalSpacing(12),
                                Text(
                                  profile.fullName,
                                  style: TextStyles.font16DarkGreenBold,
                                ),
                                verticalSpacing(4),
                                Text(
                                  profile.email,
                                  style: TextStyles.font14GrayRegular,
                                ),
                              ],
                            ),
                          ),
                          verticalSpacing(20),
                          //Account Settings Section
                          Text(
                            'Account Settings',
                            style: TextStyles.font16DarkGreenBold,
                          ),
                          verticalSpacing(12),
                          CustomActionProfileButton(
                            title: 'Edit Profile',
                            icon: Iconsax.personalcard_copy,
                            onTap: () async {
                              final result = await context.pushNamed(
                                Routes.editProfileScreen,
                                extra: profile,
                              );
                              if (!context.mounted) return;
                              if (result == true) {
                                // Refresh profile data only if update was successful
                                context.read<ProfileCubit>().getProfile();
                              }
                            },
                          ),
                          verticalSpacing(12),
                          CustomActionProfileButton(
                            title: 'Security',
                            icon: Iconsax.security_safe_copy,
                            onTap: () {
                              context.pushNamed(Routes.securityScreen);
                            },
                          ),
                          verticalSpacing(12),
                          CustomActionProfileButton(
                            title: 'Payment History',
                            icon: Iconsax.wallet_copy,
                            onTap: () {
                              context.pushNamed(Routes.paymentHistoryScreen);
                            },
                          ),
                          verticalSpacing(12),
                          CustomActionProfileButton(
                            title: 'Notifications',
                            icon: Iconsax.notification_copy,
                            onTap: () {
                              context.pushNamed(
                                Routes.notificationsSettingsScreen,
                              );
                            },
                          ),

                          //Help & Support Section
                          verticalSpacing(20),
                          Text(
                            'Help & Support',
                            style: TextStyles.font16DarkGreenBold,
                          ),
                          verticalSpacing(12),
                          CustomActionProfileButton(
                            title: 'Help Center',
                            icon: Iconsax.info_circle_copy,
                            onTap: () {
                              context.pushNamed(Routes.helpCenterScreen);
                            },
                          ),
                          verticalSpacing(12),
                          CustomActionProfileButton(
                            title: 'Contact Us',
                            icon: Iconsax.call_copy,
                            onTap: () {
                              context.pushNamed(Routes.contactUsScreen);
                            },
                          ),
                          verticalSpacing(12),
                          CustomActionProfileButton(
                            title: 'Terms & Conditions',
                            icon: Iconsax.document_copy,
                            onTap: () {
                              context.pushNamed(Routes.termsConditionsScreen);
                            },
                          ),
                          verticalSpacing(12),
                          CustomActionProfileButton(
                            title: 'Privacy Policy',
                            icon: Iconsax.shield,
                            onTap: () {
                              context.pushNamed(Routes.privacyPolicyScreen);
                            },
                          ),
                          verticalSpacing(12),
                          CustomActionProfileButton(
                            title: 'Logout',
                            icon: Iconsax.logout_1,
                            onTap: () async {
                              bool? confirmLogout = await showDialog<bool>(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Logout',
                                      style: TextStyles.font18DarkGreenBold,
                                    ),
                                    content: Text(
                                      'Are you sure you want to log out?',
                                      style: TextStyles.font14GrayRegular,
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed:
                                            () => Navigator.pop(context, false),
                                        child: Text(
                                          'Cancel',
                                          style: TextStyles.font14GrayRegular,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed:
                                            () => Navigator.pop(context, true),
                                        child: const Text(
                                          'Logout',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );

                              if (confirmLogout == true) {
                                // Unregister device token to stop receiving notifications
                                try {
                                  final token =
                                      await FirebaseMessaging.instance
                                          .getToken();
                                  if (token != null) {
                                    await getIt<DeviceTokenRepository>()
                                        .unregisterDeviceToken(token: token);
                                  }
                                } catch (e) {
                                  debugPrint(
                                    'Failed to unregister notification token: $e',
                                  );
                                }

                                await CacheHelper.clearAllSecuredData();
                                await CacheHelper.removeData(
                                  key: AppConstants.tokenKey,
                                );
                                await CacheHelper.removeData(
                                  key: 'user_id',
                                ); // From auth cubit
                                if (!context.mounted) return;
                                context.goNamed(Routes.auth);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
              getProfileError:
                  (message) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Iconsax.close_circle,
                          size: 64.sp,
                          color: Colors.red,
                        ),
                        verticalSpacing(16),
                        Text(
                          message,
                          style: TextStyles.font14GrayRegular,
                          textAlign: TextAlign.center,
                        ),
                        verticalSpacing(16),
                        CustomMaterialButton(
                          textButton: 'Retry',
                          onPressed: () {
                            context.read<ProfileCubit>().getProfile();
                          },
                        ),
                      ],
                    ),
                  ),
              orElse: () => const Offstage(),
            );
          },
        ),
      ),
    );
  }
}
