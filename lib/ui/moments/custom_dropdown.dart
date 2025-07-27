import 'package:flutter/material.dart';
import 'package:matchchayn/ui/constants/app_colors.dart';

import '../app_theme/app_theme.dart';


class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton({
    super.key,
    required this.onTap,
    this.isCreateMoment = false,
  });

  final Function() onTap;
  final bool isCreateMoment;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: AppTheme.surfaceGradient(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: !isCreateMoment
            ? [
          _buildCustomMenuItem(
            text: "Profile",
            textColor: AppColors.whiteColor,
            value: "1",
            context: context,
          ),
          _buildCustomMenuItem(
            text: "Settings",
            textColor: AppColors.whiteColor,
            value: "2",
            context: context,
          ),
          _buildCustomMenuItem(
            text: "Logout",
            textColor: AppColors.criticalActionColor,
            value: "3",
            context: context,
          ),
          _buildCustomMenuItem(
            text: "Report User Profile",
            textColor: AppColors.criticalActionColor,
            value: "4",
            context: context,
            showDivider: false,
          ),
        ]
            : [
          _buildCustomMenuItem(
            text: "Share moment",
            textColor: AppColors.whiteColor,
            value: "1",
            context: context,
          ),
          _buildCustomMenuItem(
            text: "Save",
            textColor: AppColors.whiteColor,
            value: "2",
            context: context,
          ),
          _buildCustomMenuItem(
            text: "Delete moment",
            textColor: AppColors.criticalActionColor,
            value: "3",
            context: context,
          ),
        ],
      ),
    );
  }

  Widget _buildCustomMenuItem({
    required String text,
    required Color textColor,
    required String value,
    required BuildContext context,
    bool showDivider = true,
  }) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 4),
          Text(
            text,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 6,
              color: textColor,
            ),
          ),
          SizedBox(height: 4),
          if (showDivider)
            Container(
              height: 1,
              width: double.infinity,
              color: AppColors.popUpDividerColor,
            ),
        ],
      ),
    );
  }
}
