import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'bottom_nav.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: MainBottomNav(navigationShell: navigationShell),
    );
  }
}
