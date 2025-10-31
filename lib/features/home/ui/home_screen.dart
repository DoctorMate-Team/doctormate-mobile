import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/theme/font_weight_helper.dart';
import 'package:doctor_mate/features/home/ui/widgets/doctors_list_for_specialist.dart';
import 'package:doctor_mate/features/home/ui/widgets/health_status_card.dart';
import 'package:doctor_mate/features/home/ui/widgets/health_tips_card.dart';
import 'package:doctor_mate/features/home/ui/widgets/modern_app_bar.dart';
import 'package:doctor_mate/features/home/ui/widgets/modern_quick_actions.dart';
import 'package:doctor_mate/features/home/ui/widgets/modern_specialists_list.dart';
import 'package:doctor_mate/features/home/ui/widgets/upcoming_appointments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Add state for selected specialist
  String selectedSpecialist = 'Cardiology'; // Default selected
  bool showDoctors = true; // Show doctors by default

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 1.0, curve: Curves.elasticOut),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Custom App Bar with Soft Gradient
        SliverAppBar(
          expandedHeight: 100.h,
          floating: false,
          pinned: true,
          elevation: 0,
          backgroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.grey.shade50],
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  child: const ModernAppBar(),
                ),
              ),
            ),
          ),
        ),

        // Main Content
        SliverToBoxAdapter(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Health Status Card
                        const HealthStatusCard(),
                        verticalSpacing(18),

                        // Upcoming Appointments
                        _buildSectionHeader(
                          'Upcoming Appointments',
                          'View All',
                        ),
                        verticalSpacing(12),
                        const UpcomingAppointments(),
                        verticalSpacing(20),

                        // Quick Actions Section - more compact
                        _buildSectionHeader('Quick Actions', 'View All'),
                        const ModernQuickActions(),
                        verticalSpacing(20),

                        // Specialists Section - moved to top for better UX
                        _buildSectionHeader('Specialists', 'View All'),
                        verticalSpacing(12),
                        ModernSpecialistsList(
                          selectedSpecialist: selectedSpecialist,
                          onSpecialistTap: (specialist) {
                            setState(() {
                              selectedSpecialist = specialist;
                              showDoctors = true;
                            });
                          },
                        ),
                        verticalSpacing(16),

                        // Doctors List - Show when specialist is selected
                        if (showDoctors) ...[
                          _buildSectionHeader('Best Doctors', 'View All'),
                          verticalSpacing(12),
                          DoctorsListForSpecialist(
                            specialist: selectedSpecialist,
                          ),
                          verticalSpacing(20),
                        ],

                        // Health Tips Card
                        const HealthTipsCard(),
                        verticalSpacing(18),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, String actionText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyles.font16DarkGreenBold.copyWith(
            fontWeight: FontWeightHelper.semiBold,
            color: Colors.grey.shade800,
          ),
        ),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            actionText,
            style: TextStyles.font14DarkGreenMedium.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
              color: Colors.grey.shade600,
            ),
          ),
        ),
      ],
    );
  }
}
