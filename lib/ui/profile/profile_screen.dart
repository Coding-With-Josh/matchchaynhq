import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matchchayn/ui/constants/app_colors.dart';
import '../app_theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppTheme.surfaceGradientBox(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ListView(
              children: [
                SizedBox(height: 32),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 86,
                          height: 86,
                          child: ClipOval(
                            child: Image.asset(
                              "assets/images/user1.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Tiana Brooks",
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(fontWeight: FontWeight.w700),
                                ),
                                SizedBox(width: 4),
                                SvgPicture.asset(
                                  "assets/icons/check-badge.svg",
                                  width: 14,
                                  height: 14,
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/location_color.svg",
                                  width: 12,
                                  height: 12,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "Abuja, Nigeria",
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    EditFieldIconButton(),
                  ],
                ),
                SizedBox(height: 32),
                BioSection(),
                SizedBox(height: 32),
                PersonalInfoSection(),
                SizedBox(height: 32),
                ProfileInterestsSection(),
                SizedBox(height: 32),
                ProfileGallerySection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EditFieldIconButton extends StatelessWidget {
  const EditFieldIconButton({super.key, this.onTap});

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SvgPicture.asset(
        "assets/icons/edit_field.svg",
        width: 16,
        height: 16,
      ),
    );
  }
}

class BioSection extends StatelessWidget {
  const BioSection({super.key, this.onEdit});

  final void Function()? onEdit;

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
            "I'm a woman of few words but my actions speaks louder than words ever could. I'm not saying I'm a catch but I'm better than the last girl you matched with.",
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}

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
  const ProfileInterestsSection({super.key, this.onEdit});

  final void Function()? onEdit;

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
            ProfileInterestCard(title: 'Surfing'),
            ProfileInterestCard(title: 'Flirting'),
            ProfileInterestCard(title: 'Hiking'),
            ProfileInterestCard(title: 'Crypto'),
            ProfileInterestCard(title: 'Photography'),
            ProfileInterestCard(title: 'Crypto'),
            ProfileInterestCard(title: 'Yoga & medidation'),
          ],
        ),
      ],
    );
  }
}

class ProfileGalleryImage extends StatelessWidget {
  const ProfileGalleryImage({
    super.key,
    required this.imageUrl,
    required this.heroTag,
  });

  final String imageUrl;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullScreenImageScreen(
              imageUrl: imageUrl,
              heroTag: heroTag, // Pass the same unique tag
            ),
          ),
        );
      },
      child: Hero(
        tag: heroTag,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Container(
                  color: AppColors.alertGreyColor,
                  child: Center(
                    child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
            errorWidget: (context, url, error) =>
                Image.asset("assets/images/user1.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class ProfileGallerySection extends StatefulWidget {
  const ProfileGallerySection({super.key, this.onEdit});

  final void Function()? onEdit;

  @override
  State<ProfileGallerySection> createState() => _ProfileGallerySectionState();
}

class _ProfileGallerySectionState extends State<ProfileGallerySection> {
  final List<String> _images = [
    "https://raw.githubusercontent.com/bethel-m/matchayn_images/refs/heads/main/user/user0.jpg",
    "https://raw.githubusercontent.com/bethel-m/matchayn_images/refs/heads/main/user/user1.png",
    "https://raw.githubusercontent.com/bethel-m/matchayn_images/refs/heads/main/user/user2.png",
    "https://raw.githubusercontent.com/bethel-m/matchayn_images/refs/heads/main/user/user3.png",
    "https://raw.githubusercontent.com/bethel-m/matchayn_images/refs/heads/main/user/user4.png",
    "https://raw.githubusercontent.com/bethel-m/matchayn_images/refs/heads/main/user/user5.png",
    "https://raw.githubusercontent.com/bethel-m/matchayn_images/refs/heads/main/user/user6.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(sectionTitle: "Gallery", onEdit: widget.onEdit),
        SizedBox(height: 14),
        // Use GridView.builder for efficient two-column display
        GridView.builder(
          shrinkWrap: true,
          // Important to allow GridView inside a Column
          physics: NeverScrollableScrollPhysics(),
          // Disable scrolling of the GridView
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two images per row
            crossAxisSpacing: 24, // Spacing between columns
            mainAxisSpacing: 24, // Spacing between rows
            childAspectRatio: .7, // Adjust as needed to maintain aspect ratio
          ),
          itemCount: _images.length,
          itemBuilder: (context, index) {
            final String heroTag =
                'imageHero_${_images[index]}'; // Using URL as part of tag
            return ProfileGalleryImage(
              imageUrl: _images[index],
              heroTag: heroTag,
            );
          },
        ),
      ],
    );
  }
}

class FullScreenImageScreen extends StatelessWidget {
  final String imageUrl;
  final String heroTag; // Unique tag for the Hero animation

  const FullScreenImageScreen({
    super.key,
    required this.imageUrl,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context); // Pop the screen when tapped
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("click on the image to go back",
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 24),
              Container(
                decoration: AppTheme.surfaceGradientBox(),
                child: Hero(
                  tag: heroTag, // Match the tag from the source image
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Container(
                            color: AppColors.alertGreyColor,
                            child: Center(
                              child: CircularProgressIndicator(
                                value: downloadProgress.progress,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                      errorWidget: (context, url, error) =>
                          Image.asset("assets/images/user1.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
