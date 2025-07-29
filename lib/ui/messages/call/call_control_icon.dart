import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_colors.dart';

class CallControlIcon extends StatelessWidget {
  const CallControlIcon({
    super.key,
    required this.iconPath,
    this.onTap,
    this.isDestructive = false,
  });

  final String iconPath;
  final void Function()? onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isDestructive
              ? AppColors.criticalActionColor
              : AppColors.callControlBackgroundColor.withValues(alpha: 0.2),
          shape: BoxShape.circle,
          border: isDestructive
              ? null
              : Border.all(color: AppColors.whiteColor, width: 1),
        ),
        child: SvgPicture.asset(iconPath),
      ),
    );
  }
}
