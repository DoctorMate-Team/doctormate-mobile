import 'package:doctor_mate/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
class AppRouter {
  static GoRouter mainRouting() {
    return GoRouter(
      initialLocation: Routes.splash,
      routes: [
       
      ],
      errorBuilder: (context, state) => const Scaffold(
        body: Center(
          child: Text('Page not found'),
        ),
      ),
    );
  }
}
