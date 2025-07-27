import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../app_theme/app_theme.dart';
import '../constants/app_colors.dart';

class AppBottomNavBar extends StatefulWidget {
  const AppBottomNavBar({super.key});

  @override
  State<AppBottomNavBar> createState() =>
      _AppBottomNavBarState();
}

class _AppBottomNavBarState
    extends State<AppBottomNavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  // static const List<Widget> _widgetOptions = <Widget>[
  //   Text('Index 0: Home', style: optionStyle),
  //   Text('Index 1: Likes', style: optionStyle),
  //   Text('Index 2: Messages', style: optionStyle),
  //   Text('Index 3: Profile', style: optionStyle),
  // ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(gradient: AppTheme.primaryLinearGradient()),
          child: SizedBox(height: 0.5, width: double.infinity),
        ),
        BottomNavigationBar(
          selectedLabelStyle: Theme.of(context).textTheme.labelSmall,
          unselectedLabelStyle: Theme.of(context).textTheme.labelSmall,
          unselectedItemColor: AppColors.whiteColor,
          selectedItemColor: AppColors.primaryColor,
          showUnselectedLabels: true,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/logo_icon.svg",
                width: 24, // Adjust icon size as needed
                height: 24,
                colorFilter: _selectedIndex == 0
                    ? null
                    : ColorFilter.mode(AppColors.whiteColor, BlendMode.srcIn),
              ),
              label: 'Match',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/likes.svg",
                width: 24, // Adjust icon size as needed
                height: 24,
                colorFilter: _selectedIndex == 1
                    ? ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn)
                    : null,
              ),
              label: 'Likes',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/messages.svg",
                width: 24, // Adjust icon size as needed
                height: 24,
                colorFilter: _selectedIndex == 2
                    ? ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn)
                    : null,
              ),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/profile.svg",
                width: 24, // Adjust icon size as needed
                height: 24,
                colorFilter: _selectedIndex == 3
                    ? ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn)
                    : null,
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ],
    );
  }
}
