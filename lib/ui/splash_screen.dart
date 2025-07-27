import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matchchayn/app_router/route_destinations.dart';
import 'package:matchchayn/ui/core/logo_and_text.dart';

import 'app_theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //navigate to get started screen after 3 secs

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      // Use context.go() to navigate to the home screen, replacing the splash screen.
      context.go(RouteDestinations.getStarted);
   //   context.pushReplacement(RouteDestinations.getStarted);
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
