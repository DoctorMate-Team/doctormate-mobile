import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/auth/ui/widgets/custom_profile_screen_image.dart';
import 'package:doctor_mate/features/profile/logic/cubit/profile_cubit.dart';
import 'package:doctor_mate/features/profile/logic/cubit/profile_state.dart';
import 'package:doctor_mate/features/profile/ui/widgets/custom_action_profile_button.dart';
import 'package:doctor_mate/features/profile/ui/widgets/profile_shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

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
                                    // Handle image tap
                                  },
                                  isEdit: true,
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
                            onTap: () {
                              // Handle Edit Profile tap
                            },
                          ),
                          verticalSpacing(12),
                          CustomActionProfileButton(
                            title: 'Security',
                            icon: Iconsax.security_safe_copy,
                            onTap: () {
                              // Handle Security tap
                            },
                          ),
                          verticalSpacing(12),
                          CustomActionProfileButton(
                            title: 'Payment Methods',
                            icon: Iconsax.wallet_copy,
                            onTap: () {
                              // Handle Payment Methods tap
                            },
                          ),
                          verticalSpacing(12),
                          CustomActionProfileButton(
                            title: 'Notifications',
                            icon: Iconsax.notification_copy,
                            onTap: () {
                              // Handle Notifications tap
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
                              // Handle Help Center tap
                            },
                          ),
                          verticalSpacing(12),
                          CustomActionProfileButton(
                            title: 'Contact Us',
                            icon: Iconsax.call_copy,
                            onTap: () {
                              // Handle Contact Us tap
                            },
                          ),
                          verticalSpacing(12),
                          CustomActionProfileButton(
                            title: 'Terms & Conditions',
                            icon: Iconsax.document_copy,
                            onTap: () {
                              // Handle Terms & Conditions tap
                            },
                          ),
                          verticalSpacing(12),
                          CustomActionProfileButton(
                            title: 'Privacy Policy',
                            icon: Iconsax.shield,
                            onTap: () {
                              // Handle Privacy Policy tap
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
                        ElevatedButton(
                          onPressed: () {
                            context.read<ProfileCubit>().getProfile();
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
              orElse: () => const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }
}
