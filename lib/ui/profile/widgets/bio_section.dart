import 'package:flutter/material.dart';
import 'package:matchchayn/ui/profile/widgets/section_header.dart';

import '../../constants/app_colors.dart';

class BioSection extends StatelessWidget {
  const BioSection({super.key, this.onEdit, required this.bioText});

  final void Function()? onEdit;
  final String bioText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SectionHeader(onEdit: onEdit, sectionTitle: "Bio"),
        SizedBox(height: 14),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.whiteColor),
          ),
          child: Text(
            bioText,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}