import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:matchchayn/ui/app_theme/app_theme.dart';

import '../constants/app_colors.dart';

class GradientBorderTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final bool isNumberKeyboard;
  final bool hideText;
  final void Function()? onSuffixIconPressed;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String fieldLabel;
  final bool isReadOnly;
  final void Function(String)? onTextChanged;

  const GradientBorderTextField({
    super.key,
    required this.controller,
    required this.fieldLabel,
    this.hintText,
    this.isNumberKeyboard = false,
    this.onSuffixIconPressed,
    this.suffixIcon,
    this.hideText = false,
    this.isReadOnly = false,
    this.prefixIcon,
    this.onTextChanged,
  });

  @override
  State<GradientBorderTextField> createState() =>
      _GradientBorderTextFieldState();
}

class _GradientBorderTextFieldState extends State<GradientBorderTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.fieldLabel != "")
          Column(
            children: [
              Text(
                widget.fieldLabel,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              SizedBox(height: 8),
            ],
          ),
        Container(
          padding: const EdgeInsets.all(1), // thickness of the border
          decoration: BoxDecoration(
            gradient: _isFocused ? AppTheme.primaryLinearGradient() : null,
            color: _isFocused ? null : AppColors.whiteColor,
            // White border when not focused
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              if (_isFocused)
                BoxShadow(
                  color: AppColors.textFieldBlurRed, // You can adjust opacity
                  offset: const Offset(0, 0.4), // x=0, y=0.4
                  blurRadius: 2.43,
                  spreadRadius: 0,
                ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.backgroundDarkColor, // or your background color
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              onChanged: widget.onTextChanged,
              readOnly: widget.isReadOnly,
              focusNode: _focusNode,
              controller: widget.controller,
              obscureText: widget.hideText,
              obscuringCharacter: ".",
              keyboardType: widget.isNumberKeyboard
                  ? TextInputType.number
                  : null,
              style: Theme.of(context).textTheme.labelMedium,
              decoration: InputDecoration(
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.suffixIcon != null
                    ? IconButton(
                        onPressed: widget.onSuffixIconPressed,
                        icon: widget.suffixIcon!,
                      )
                    : null,
                border: InputBorder.none,
                hintText: widget.hintText,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
