import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:matchchayn/data/dummy_data/home_dummy.dart' show defaultImage;
import 'package:matchchayn/ui/profile/widgets/section_header.dart';

import '../../app_theme/app_theme.dart';
import '../../constants/app_colors.dart';

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
            errorWidget: (context, url, error) => Image.asset(
              defaultImage,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
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
              Text(
                "click on the image to go back",
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
                      errorWidget: (context, url, error) => Image.asset(
                        defaultImage,
                        fit: BoxFit.cover,
                      ),
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
