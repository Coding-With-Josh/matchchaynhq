import 'package:flutter/material.dart';

import '../app_theme/app_theme.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    this.onTap,
    required this.text,
    this.isSmallTexts = false,
  });

  final void Function()? onTap;
  final String text;
  final bool isSmallTexts;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (Rect bounds) {
          return AppTheme.primaryLinearGradient().createShader(bounds);
        },
        child: Text(
          text,
          style: isSmallTexts
              ? Theme.of(
                  context,
                ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700)
              : Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
