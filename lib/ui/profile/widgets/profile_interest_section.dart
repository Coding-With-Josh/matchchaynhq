import 'package:flutter/material.dart';
import 'package:matchchayn/ui/profile/widgets/section_header.dart';

import '../../app_theme/app_theme.dart';
import '../../profile_onboarding/select_interest_screen.dart';

class ProfileInterestCard extends StatelessWidget {
  const ProfileInterestCard({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryLinearGradient(),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }
}

class ProfileInterestsSection extends StatelessWidget {
  const ProfileInterestsSection({
    super.key,
    this.onEdit,
    required this.interests,
  });

  final void Function()? onEdit;
  final List<Interest> interests;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(sectionTitle: "Interests", onEdit: onEdit),
        SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (var interest in interests)
              if (interest.isSelected)
                ProfileInterestCard(title: interest.title),
          ],
        ),
      ],
    );
  }
}
