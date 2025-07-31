import 'package:flutter/material.dart';
import 'package:matchchayn/ui/constants/app_colors.dart';

import '../app_theme/app_theme.dart';
import '../core/intro_header_and_text.dart';
import '../core/user_intetrests.dart';

class SelectInterestScreen extends StatefulWidget {
  const SelectInterestScreen({super.key});

  @override
  State<SelectInterestScreen> createState() => _SelectInterestScreenState();
}

class _SelectInterestScreenState extends State<SelectInterestScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          IntroHeaderAndSubtext(
            header:  "Select up to 5 Interests",
            subtext: "Your interests shape your vibe. Pick what feels like you.",
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 48),
              InterestListing(
                interests: userInterests,
                onTap: (index) {
                  setState(() {
                    userInterests[index] = userInterests[index].copyWith(
                      isSelected: !userInterests[index].isSelected,
                    );
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class InterestListing extends StatelessWidget {
  const InterestListing({super.key, required this.interests, this.onTap});

  final List<Interest> interests;
  final void Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        for (var interest in interests)
          InterestCard(
            interest: interest,
            onTap: onTap,
            index: interests.indexOf(interest),
          ),
      ],
    );
  }
}

class Interest {
  final String title;
  final bool isSelected;

  Interest({required this.title, this.isSelected = false});

  //copy with

  Interest copyWith({String? title, bool? isSelected}) {
    return Interest(
      title: title ?? this.title,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

class InterestCard extends StatelessWidget {
  const InterestCard({
    required this.interest,
    super.key,
    this.onTap,
    required this.index,
  });

  final int index;
  final Interest interest;
  final void Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call(index);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: interest.isSelected
              ? AppTheme.primaryLinearGradient()
              : null,
          color: interest.isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          interest.title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 18,
            color: interest.isSelected
                ? AppColors.whiteColor
                : AppColors.blackColor,
          ),
        ),
      ),
    );
  }
}
