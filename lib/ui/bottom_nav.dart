import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'app_theme/app_theme.dart';
import 'constants/app_colors.dart';

class MainBottomNav extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainBottomNav({super.key, required this.navigationShell});

  void _onItemTapped(int index) {
    navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = navigationShell.currentIndex;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(gradient: AppTheme.primaryLinearGradient()),
          child: const SizedBox(height: 0.5, width: double.infinity),
        ),
        BottomNavigationBar(
          selectedLabelStyle: Theme.of(context).textTheme.labelSmall,
          unselectedLabelStyle: Theme.of(context).textTheme.labelSmall,
          unselectedItemColor: AppColors.whiteColor,
          selectedItemColor: AppColors.primaryColor,
          showUnselectedLabels: true,
          currentIndex: selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/logo_icon.svg",
                width: 24,
                height: 24,
                colorFilter: selectedIndex == 0
                    ? null
                    : ColorFilter.mode(AppColors.whiteColor, BlendMode.srcIn),
              ),
              label: 'Match',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/likes.svg",
                width: 24,
                height: 24,
                colorFilter: selectedIndex == 1
                    ? ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn)
                    : null,
              ),
              label: 'Likes',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/messages.svg",
                width: 24,
                height: 24,
                colorFilter: selectedIndex == 2
                    ? ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn)
                    : null,
              ),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/profile.svg",
                width: 24,
                height: 24,
                colorFilter: selectedIndex == 3
                    ? ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn)
                    : null,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ],
    );
  }
}
