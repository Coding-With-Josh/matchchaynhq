import 'package:flutter/material.dart';
import 'package:matchchayn/ui/app_theme/app_theme.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final bool hugContents;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.hugContents = false,
    this.textStyle,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding:
            padding ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: AppTheme.primaryGradientBox().copyWith(
          borderRadius: BorderRadius.circular(100),
        ),
        child: hugContents
            ? Text(
                text,
                style: textStyle ?? Theme.of(context).textTheme.labelLarge,
              )
        //using center here forces the container to fill the whole space available
            : Center(
                child: Text(
                  text,
                  style: textStyle ?? Theme.of(context).textTheme.labelLarge,
                ),
              ),
      ),
    );
  }
}
