import 'package:flutter/material.dart';
import 'package:matchchayn/ui/app_theme/app_theme.dart';

import '../constants/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final bool hugContents;
  final bool isInactive;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.hugContents = false,
    this.textStyle,
    this.padding,
    this.isInactive = false,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = isInactive
        ? AppColors.whiteColor.withValues(alpha: 0.5)
        : AppColors.whiteColor;

    return GestureDetector(
      onTap: isInactive ? null : onPressed,
      child: Container(
        padding:
            padding ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: isInactive
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: AppColors.whiteColor.withValues(alpha: 0.2),
              )
            : AppTheme.primaryGradientBox().copyWith(
                borderRadius: BorderRadius.circular(100),
              ),
        child: hugContents
            ? Text(
                text,
                style:
                    textStyle ??
                    Theme.of(
                      context,
                    ).textTheme.labelLarge?.copyWith(color: textColor),
              )
            //using center here forces the container to fill the whole space available
            : Center(
                child: Text(
                  text,
                  style:
                      textStyle ??
                      Theme.of(
                        context,
                      ).textTheme.labelLarge?.copyWith(color: textColor),
                ),
              ),
      ),
    );
  }
}
