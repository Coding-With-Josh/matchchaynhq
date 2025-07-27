import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class TextFieldMenu extends StatelessWidget {
  const TextFieldMenu({
    super.key,
    required this.menuOptions,
    required this.onOptionSelected,
    required this.child,
  });

  final List<String> menuOptions;
  final Function(String) onOptionSelected;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      style: MenuStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        backgroundColor: WidgetStateProperty.all<Color>(AppColors.whiteColor),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
      builder: (BuildContext context, MenuController controller, Widget? child) {
        return GestureDetector(
          onTap: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          child: child,
        );
      }, // ✅ This makes sure your TextField or Container shows up
      menuChildren: [
        for (String option in menuOptions)
          MenuItemButton(
            onPressed: () {
              onOptionSelected(option);
            },
            child: Text(
              option,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: AppColors.blackColor),
            ),
          ),
      ],
      child: child,
    );
  }
}
