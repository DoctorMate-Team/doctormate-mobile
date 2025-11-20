import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/main_navigation/ui/data/models/navigation_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

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

  void _handleTap(int index) {
    if (widget.currentIndex != index) {
      widget.onTap(index);
      _animationController.forward().then((_) {
        _animationController.reverse();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final navigationItems = NavigationItemModel.items;

    return Container(
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
          currentIndex: widget.currentIndex,
          onTap: _handleTap,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: navigationItems[widget.currentIndex].color,
          unselectedItemColor: Colors.grey.shade400,
          selectedLabelStyle: TextStyles.font11GrayRegular.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 11.sp,
          ),
          unselectedLabelStyle: TextStyles.font11GrayRegular.copyWith(
            fontSize: 10.sp,
          ),
          items:
              navigationItems.asMap().entries.map((entry) {
                int index = entry.key;
                NavigationItemModel item = entry.value;
                bool isSelected = widget.currentIndex == index;

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
                                  isSelected && _animationController.isAnimating
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
    );
  }
}
