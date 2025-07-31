import 'package:flutter/material.dart';

import 'edit_field_icon.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, this.onEdit, required this.sectionTitle});

  final void Function()? onEdit;
  final String sectionTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          sectionTitle,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
        EditFieldIconButton(onTap: onEdit),
      ],
    );
  }
}
