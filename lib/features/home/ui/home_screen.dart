import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/routing/routes.dart';
import 'package:doctor_mate/features/home/logic/cubit/home_cubit.dart';
import 'package:doctor_mate/features/home/ui/widgets/doctors_bloc_builder.dart';
import 'package:doctor_mate/features/home/ui/widgets/health_status_card.dart';
import 'package:doctor_mate/features/home/ui/widgets/health_tips_card.dart';
import 'package:doctor_mate/features/home/ui/widgets/modern_app_bar.dart';
import 'package:doctor_mate/features/home/ui/widgets/modern_quick_actions.dart';
import 'package:doctor_mate/features/home/ui/widgets/section_header.dart';
import 'package:doctor_mate/features/home/ui/widgets/specialists_bloc_builder.dart';
import 'package:doctor_mate/features/home/ui/widgets/upcoming_appointments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  String? selectedSpecialtyId;
  bool showDoctors = true;

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
                        SectionHeader(
                          title: 'Upcoming Appointments',
                          actionText: 'View All',
                          onActionTap: () {
                            // Navigate to main layout and switch to appointments tab (index 1)
                            context.pushNamed(Routes.mainLayout, extra: 1);
                          },
                        ),
                        verticalSpacing(12),
                        const UpcomingAppointments(),
                        verticalSpacing(20),

                        // Quick Actions Section - more compact
                        const SectionHeader(
                          title: 'Quick Actions',
                          actionText: '',
                        ),
                        const ModernQuickActions(),
                        verticalSpacing(20),

                        // Specialists Section - moved to top for better UX
                        const SectionHeader(
                          title: 'Specialists',
                          actionText: '',
                        ),
                        verticalSpacing(12),
                        SpecialtiesBlocBuilder(
                          selectedSpecialtyId: selectedSpecialtyId,
                          onSpecialistTap: (specialtyId) {
                            setState(() {
                              selectedSpecialtyId = specialtyId;
                              showDoctors = true;
                            });
                            context.read<HomeCubit>().getDoctorsBySpecialty(
                              specialtyId: specialtyId,
                            );
                          },
                          onFirstSpecialtyLoaded: (specialtyId) {
                            setState(() {
                              selectedSpecialtyId = specialtyId;
                            });
                          },
                        ),
                        verticalSpacing(16),

                        // Doctors List - Show when specialist is selected
                        if (showDoctors) const DoctorsBlocBuilder(),

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
}
