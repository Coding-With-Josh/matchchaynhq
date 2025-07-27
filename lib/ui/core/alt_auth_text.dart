import 'package:flutter/material.dart';

import 'custom_text_button.dart';

class AltAuthText extends StatelessWidget {
  const AltAuthText({
    super.key,
    required this.textPrompt,
    required this.actionText,
    required this.onTap,
    this.isSmallTexts = false,
  });

  final String textPrompt;
  final String actionText;
  final Function() onTap;
  final bool isSmallTexts;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      //mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.center,
      children: [
        Text(
          textPrompt,
          style: isSmallTexts
              ? Theme.of(
                  context,
                ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w400)
              : Theme.of(context).textTheme.bodyMedium,
        ),
        CustomTextButton(
          text: actionText,
          onTap: onTap,
          isSmallTexts: isSmallTexts,
        ),
      ],
    );
  }
}
