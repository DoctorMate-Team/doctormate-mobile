import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:flutter/material.dart';

class AppointmentTabBar extends StatelessWidget {
  final TabController tabController;

  const AppointmentTabBar({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: tabController,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        indicatorColor: ColorsManager.primaryColor,
        indicatorWeight: 3,
        labelColor: ColorsManager.primaryColor,
        unselectedLabelColor: ColorsManager.gray,
        labelStyle: TextStyles.font14GreenSemiBold,
        unselectedLabelStyle: TextStyles.font14GrayRegular,
        tabs: const [
          Tab(text: 'Scheduled'),
          Tab(text: 'In Progress'),
          Tab(text: 'Completed'),
          Tab(text: 'Cancelled'),
        ],
      ),
    );
  }
}
