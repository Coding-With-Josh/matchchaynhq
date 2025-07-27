import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app_theme/app_theme.dart';

class ProfileStatusListing extends StatelessWidget {
  const ProfileStatusListing({
    super.key,
    required this.onCreateMoment,
    required this.onViewMoment,
  });

  final void Function() onCreateMoment;
  final void Function() onViewMoment;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          CreateMomentIcon(onTap: onCreateMoment),
          SizedBox(width: 15),
          AvatarProfile(
            image: "assets/images/avatar4.jpg",
            onTap: onViewMoment,
          ),
          SizedBox(width: 15),
          AvatarProfile(
            image: "assets/images/avatar3.jpg",
            onTap: onViewMoment,
          ),
          SizedBox(width: 15),
          AvatarProfile(
            image: "assets/images/avatar2.jpg",
            onTap: onViewMoment,
          ),
          SizedBox(width: 15),
          AvatarProfile(
            image: "assets/images/avatar1.jpg",
            onTap: onViewMoment,
          ),
          SizedBox(width: 15),
          AvatarProfile(
            image: "assets/images/avatar4.jpg",
            onTap: onViewMoment,
          ),
          SizedBox(width: 15),
        ],
      ),
    );
  }
}

class CreateMomentIcon extends StatelessWidget {
  const CreateMomentIcon({super.key, this.onTap});

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(
        "assets/icons/add.svg",
        width: 50, // Adjust icon size as needed
        height: 50,
      ),
    );
  }
}

class AvatarProfile extends StatelessWidget {
  const AvatarProfile({super.key, required this.image, this.onTap});

  final void Function()? onTap;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          gradient: AppTheme.primaryLinearGradient(),
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(backgroundImage: AssetImage(image), radius: 22),
      ),
    );
  }
}
