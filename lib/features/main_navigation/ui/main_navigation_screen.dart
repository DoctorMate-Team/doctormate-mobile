import 'package:doctor_mate/features/main_navigation/logic/cubit/main_cubit.dart';
import 'package:doctor_mate/features/main_navigation/logic/cubit/main_state.dart';
import 'package:doctor_mate/features/main_navigation/ui/widgets/custom_bottom_navigation_bar.dart';
import 'package:doctor_mate/features/main_navigation/ui/widgets/navigation_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.currentIndex,
            children: NavigationScreens.screens,
          ),
          bottomNavigationBar: CustomBottomNavigationBar(
            currentIndex: state.currentIndex,
            onTap: (index) => context.read<MainCubit>().changeTab(index),
          ),
        );
      },
    );
  }
}
