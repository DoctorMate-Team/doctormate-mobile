import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabBarDetailsScreen extends StatelessWidget {
  const TabBarDetailsScreen({super.key, required TabController tabController})
    : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          labelStyle: TextStyles.font14GreenSemiBold,
          unselectedLabelColor: Colors.grey.shade600,
          unselectedLabelStyle: TextStyles.font14GrayRegular,
          indicator: BoxDecoration(
            color: ColorsManager.primaryColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          padding: EdgeInsets.all(4.w),
          tabs: [
            Tab(height: 44.h, text: 'About'),
            Tab(height: 44.h, text: 'Location'),
            Tab(height: 44.h, text: 'Reviews'),
          ],
        ),
      ),
    );
  }
}
