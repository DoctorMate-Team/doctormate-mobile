import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:doctor_mate/features/details/logic/cubit/details_cubit.dart';
import 'package:doctor_mate/features/details/logic/cubit/details_state.dart';
import 'package:doctor_mate/features/details/ui/widgets/details_shimmer_loading.dart';
import 'package:doctor_mate/features/details/ui/widgets/doctor_details_header.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_mate/features/details/ui/widgets/quick_stats_card.dart';
import 'package:doctor_mate/features/details/ui/widgets/tab_bar_widgets/about_tab_bar_view_body.dart';
import 'package:doctor_mate/features/details/ui/widgets/tab_bar_widgets/location_tab_bar_view_body.dart';
import 'package:doctor_mate/features/details/ui/widgets/tab_bar_widgets/reviews_tab_bar_view_body.dart';
import 'package:doctor_mate/features/details/ui/widgets/tab_bar_widgets/tab_bar_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      extendBodyBehindAppBar: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
          leading: Padding(
            padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
            child: Center(
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 44.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(color: Colors.grey.shade200, width: 1),
                  ),
                  child: Icon(
                    Iconsax.arrow_left_2,
                    color: Colors.grey.shade800,
                    size: 20.sp,
                  ),
                ),
              ),
            ),
          ),
          centerTitle: true,
          title: Text(
            'Doctor Details',
            style: TextStyle(
              color: Colors.grey.shade800,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 16.w, top: 8.h, bottom: 8.h),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    setState(() => isFavorite = !isFavorite);
                  },
                  child: Container(
                    width: 44.w,
                    height: 44.h,
                    decoration: BoxDecoration(
                      color:
                          isFavorite ? Colors.red.shade50 : Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(
                        color:
                            isFavorite
                                ? Colors.red.shade200
                                : Colors.grey.shade200,
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite : Iconsax.heart,
                      color: isFavorite ? Colors.red : Colors.grey.shade600,
                      size: 20.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<DetailsCubit, DetailsState>(
        builder: (context, state) {
          return state.when(
            initial: () => const DetailsShimmerLoading(),
            getDoctorDetailsLoading: () => const DetailsShimmerLoading(),
            getDoctorDetailsError:
                (message) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 64.sp, color: Colors.red),
                      verticalSpacing(16),
                      Text(
                        message,
                        style: TextStyles.font16DarkGreenBold.copyWith(
                          color: Colors.red,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
            getDoctorDetailsSuccess:
                (doctorDetails) => FadeTransition(
                  opacity: _fadeAnimation,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        verticalSpacing(16),

                        // Doctor Header Card
                        DoctorDetailsHeader(doctor: doctorDetails),

                        verticalSpacing(16),

                        // Quick Stats
                        const QuickStatsCard(),

                        verticalSpacing(24),

                        // Tab Bar Section
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 20,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              TabBarDetailsScreen(
                                tabController: _tabController,
                              ),
                              SizedBox(
                                height: 450.h,
                                child: TabBarView(
                                  controller: _tabController,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    AboutTabBarViewBody(doctor: doctorDetails),
                                    LocationTabBarViewBody(
                                      doctor: doctorDetails,
                                    ),
                                    const ReviewsTabBarViewBody(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        verticalSpacing(100),
                      ],
                    ),
                  ),
                ),
          );
        },
      ),

      // Floating Bottom Bar
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              // Message Button
              Container(
                height: 56.h,
                width: 56.w,
                decoration: BoxDecoration(
                  color: ColorsManager.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Iconsax.message,
                    color: ColorsManager.primaryColor,
                  ),
                ),
              ),

              horizantialSpacing(12),

              // Book Appointment Button
              Expanded(
                child: CustomMaterialButton(
                  textButton: 'Book Appointment',
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
