import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/home/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  final List<Widget> _screens = [
    Scaffold(backgroundColor: Colors.grey.shade50, body: const HomeScreen()),
    const AppointmentsScreen(),
    const ExploreScreen(),
    const MessagesScreen(),
    const ProfileScreen(),
  ];

  final List<NavigationItem> _navigationItems = [
    NavigationItem(
      icon: Iconsax.home_2,
      activeIcon: Iconsax.home,
      label: 'Home',
      color: ColorsManager.primaryColor,
      badgeCount: 0,
    ),
    NavigationItem(
      icon: Iconsax.calendar,
      activeIcon: Iconsax.calendar_1,
      label: 'Appointments',
      color: ColorsManager.primaryColor,
      badgeCount: 2, // Example: 2 upcoming appointments
    ),
    NavigationItem(
      icon: Iconsax.search_normal,
      activeIcon: Iconsax.search_normal_1,
      label: 'Explore',
      color: ColorsManager.primaryColor,
      badgeCount: 0,
    ),
    NavigationItem(
      icon: Iconsax.message,
      activeIcon: Iconsax.messages,
      label: 'Messages',
      color: ColorsManager.primaryColor,
      badgeCount: 5, // Example: 5 unread messages
    ),
    NavigationItem(
      icon: Iconsax.profile_circle,
      activeIcon: Iconsax.user,
      label: 'Profile',
      color: ColorsManager.primaryColor,
      badgeCount: 0,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
      _animationController.forward().then((_) {
        _animationController.reverse();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.grey.shade50],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28.r),
            topRight: Radius.circular(28.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 25,
              offset: const Offset(0, -8),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, -2),
              spreadRadius: 0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28.r),
            topRight: Radius.circular(28.r),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: _navigationItems[_currentIndex].color,
            unselectedItemColor: Colors.grey.shade400,
            selectedLabelStyle: TextStyles.font11GrayRegular.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 11.sp,
            ),
            unselectedLabelStyle: TextStyles.font11GrayRegular.copyWith(
              fontSize: 10.sp,
            ),
            items:
                _navigationItems.asMap().entries.map((entry) {
                  int index = entry.key;
                  NavigationItem item = entry.value;
                  bool isSelected = _currentIndex == index;

                  return BottomNavigationBarItem(
                    icon: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 6.h,
                        horizontal: 16.w,
                      ),
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? item.color.withOpacity(0.1)
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          AnimatedBuilder(
                            animation: _scaleAnimation,
                            builder: (context, child) {
                              return Transform.scale(
                                scale:
                                    isSelected &&
                                            _animationController.isAnimating
                                        ? _scaleAnimation.value
                                        : 1.0,
                                child: Icon(
                                  isSelected ? item.activeIcon : item.icon,
                                  size: isSelected ? 26.sp : 24.sp,
                                  color:
                                      isSelected
                                          ? item.color
                                          : Colors.grey.shade400,
                                ),
                              );
                            },
                          ),
                          // Badge for notifications
                          if (item.badgeCount > 0)
                            Positioned(
                              right: -6.w,
                              top: -6.h,
                              child: Container(
                                padding: EdgeInsets.all(4.w),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2.w,
                                  ),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 18.w,
                                  minHeight: 18.h,
                                ),
                                child: Text(
                                  item.badgeCount > 99
                                      ? '99+'
                                      : item.badgeCount.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    label: item.label,
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }
}

class NavigationItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final Color color;
  final int badgeCount;

  NavigationItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.color,
    this.badgeCount = 0,
  });
}

// Placeholder screens - you can replace these with your actual screens
class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text('المواعيد', style: TextStyles.font18DarkGreenBold),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Iconsax.calendar, size: 80.sp, color: const Color(0xFF34A853)),
            SizedBox(height: 16.h),
            Text('شاشة المواعيد', style: TextStyles.font18DarkGreenBold),
            SizedBox(height: 8.h),
            Text(
              'هنا ستجد جميع مواعيدك الطبية',
              style: TextStyles.font14GrayRegular,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text('استكشاف', style: TextStyles.font18DarkGreenBold),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.search_normal,
              size: 80.sp,
              color: const Color(0xFFEA4335),
            ),
            SizedBox(height: 16.h),
            Text('شاشة الاستكشاف', style: TextStyles.font18DarkGreenBold),
            SizedBox(height: 8.h),
            Text(
              'اكتشف الأطباء والخدمات الطبية',
              style: TextStyles.font14GrayRegular,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text('المحادثات', style: TextStyles.font18DarkGreenBold),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Iconsax.message, size: 80.sp, color: const Color(0xFFFBBC05)),
            SizedBox(height: 16.h),
            Text('المحادثات', style: TextStyles.font18DarkGreenBold),
            SizedBox(height: 8.h),
            Text(
              'محادثاتك مع الأطباء والدعم الفني',
              style: TextStyles.font14GrayRegular,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text('الملف الشخصي', style: TextStyles.font18DarkGreenBold),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.profile_circle,
              size: 80.sp,
              color: const Color(0xFF9C27B0),
            ),
            SizedBox(height: 16.h),
            Text('الملف الشخصي', style: TextStyles.font18DarkGreenBold),
            SizedBox(height: 8.h),
            Text(
              'إدارة حسابك ومعلوماتك الشخصية',
              style: TextStyles.font14GrayRegular,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
