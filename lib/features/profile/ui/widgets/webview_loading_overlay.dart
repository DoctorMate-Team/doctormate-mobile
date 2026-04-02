import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class WebviewLoadingOverlay extends StatelessWidget {
  final bool isLoading;

  const WebviewLoadingOverlay({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    if (!isLoading) {
      return const Offstage();
    }

    return const Center(
      child: CircularProgressIndicator(color: ColorsManager.primaryColor),
    );
  }
}
