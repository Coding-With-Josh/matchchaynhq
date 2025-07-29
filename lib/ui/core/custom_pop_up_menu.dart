import 'package:flutter/material.dart';
import 'package:matchchayn/ui/constants/app_colors.dart';

// New custom widget to encapsulate the iOS-style popup menu button
class CustomIosStyledPopUpMenu extends StatefulWidget {
  const CustomIosStyledPopUpMenu({
    super.key,
    required this.child,
    required this.menuItems,
  });

  final Widget child;
  final List<PopupMenuEntry<String>> menuItems;

  @override
  State<CustomIosStyledPopUpMenu> createState() =>
      _CustomIosStyledPopUpMenuState();
}

class _CustomIosStyledPopUpMenuState extends State<CustomIosStyledPopUpMenu> {
  final GlobalKey _buttonKey = GlobalKey();

  void _showIosStyledAndroidPopupMenu(BuildContext context) {
    final RenderBox renderBox =
        _buttonKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromLTWH(offset.dx, offset.dy + size.height, size.width, 0),
      Offset.zero & MediaQuery.of(context).size,
    );

    showMenu<String>(
      menuPadding: EdgeInsets.zero,
      context: context,
      position: position,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: AppColors.whiteColor,
      items: widget.menuItems,
      // Use the provided menu items
      elevation: 8.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _buttonKey,
      onTap: () => _showIosStyledAndroidPopupMenu(context),
      child: widget.child,
    );
  }
}

// Custom PopupMenuItem to mimic iOS action sheet row styling
class CustomPopUpMenuItem extends PopupMenuEntry<String> {
  const CustomPopUpMenuItem({
    super.key,
    required this.text,
    this.isDestructive = false,
    this.onTap,
  });

  final String text;
  final bool isDestructive;
  final VoidCallback? onTap;

  @override
  double get height => 50.0; // Standard height for iOS action sheet rows

  @override
  bool represents(String? value) => value == text;

  @override
  State<CustomPopUpMenuItem> createState() => _IosStylePopupMenuItemState();
}

class _IosStylePopupMenuItemState extends State<CustomPopUpMenuItem> {
  @override
  Widget build(BuildContext context) {
    // Get the default text style from the current theme
    final TextStyle? textStyle = Theme.of(context).textTheme.labelSmall
        ?.copyWith(
          //fontSize: 20.0, // iOS action sheet font size
          color: widget.isDestructive
              ? AppColors.criticalActionColor
              : AppColors.alertBlackColor
        );

    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        } else {
          Navigator.pop(context, widget.text);
        }
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: Text(widget.text, style: textStyle),
      ),
    );
  }
}
