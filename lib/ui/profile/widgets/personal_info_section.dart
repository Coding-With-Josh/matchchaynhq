import 'package:flutter/material.dart';
import 'package:matchchayn/ui/profile/widgets/section_header.dart';

class PersonalInfoTile extends StatelessWidget {
  const PersonalInfoTile({super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
        ),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class PersonalInfoSection extends StatelessWidget {
  const PersonalInfoSection({super.key, this.onEdit});

  final void Function()? onEdit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(sectionTitle: "Personal Information", onEdit: onEdit),
        SizedBox(height: 14),
        PersonalInfoTile(title: "Age", value: "25 years"),
        SizedBox(height: 14),
        PersonalInfoTile(title: "Height", value: "150 cm"),
        SizedBox(height: 14),
        PersonalInfoTile(title: "Gender", value: "Female"),
        SizedBox(height: 14),
        PersonalInfoTile(title: "Relationship Status", value: "Single"),
      ],
    );
  }
}
