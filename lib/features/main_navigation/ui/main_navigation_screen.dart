import 'package:doctor_mate/features/main_navigation/logic/cubit/main_cubit.dart';
import 'package:doctor_mate/features/main_navigation/logic/cubit/main_state.dart';
import 'package:doctor_mate/features/main_navigation/ui/widgets/custom_bottom_navigation_bar.dart';
import 'package:doctor_mate/features/main_navigation/ui/widgets/navigation_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key, this.initialIndex});
  final int? initialIndex;

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late final List<Widget?> _tabCache;

  @override
  void initState() {
    super.initState();
    _tabCache = List<Widget?>.filled(5, null);
    _tabCache[0] = NavigationScreens.buildScreen(0);

    final initial = widget.initialIndex;
    if (initial != null && initial > 0 && initial < 5) {
      _tabCache[initial] = NavigationScreens.buildScreen(initial);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context.read<MainCubit>().changeTab(initial);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        _tabCache[state.currentIndex] ??= NavigationScreens.buildScreen(
          state.currentIndex,
        );

        return Scaffold(
          body: IndexedStack(
            index: state.currentIndex,
            children: _tabCache.map((tab) => tab ?? const Offstage()).toList(),
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
