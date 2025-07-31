import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matchchayn/app_router/route_destinations.dart';
import 'package:matchchayn/ui/core/logo_and_text.dart';

import 'app_theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.isUnauthenticated});

  final bool isUnauthenticated;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //navigate to get started screen after 3 secs

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (widget.isUnauthenticated) {
        context.go(RouteDestinations.home);
      } else {
        context.go(RouteDestinations.getStarted);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppTheme.surfaceGradientBox(),
        child: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: LogoAndText(),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
