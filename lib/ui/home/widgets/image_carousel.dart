import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_colors.dart';
import '../../core/round_icon.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final PageController _pageController = PageController();
  final List<String> _images = [
    'https://github.com/bethel-m/matchayn_images/blob/main/profile1.jpg?raw=true',
    'https://github.com/bethel-m/matchayn_images/blob/main/profile2.jpg?raw=true',
    'https://github.com/bethel-m/matchayn_images/blob/main/profile3.jpg?raw=true',
    'https://github.com/bethel-m/matchayn_images/blob/main/profile4.jpg?raw=true',
    'https://github.com/bethel-m/matchayn_images/blob/main/profile5.jpg?raw=true',
    'https://github.com/bethel-m/matchayn_images/blob/main/profile6.jpg?raw=true',
    'https://github.com/bethel-m/matchayn_images/blob/main/profile7.jpg?raw=true',
  ];

  int _currentIndex = 0;

  void _goToPage(int index) {
    if (index >= 0 && index < _images.length) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          itemCount: _images.length,
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(), // disables swipe
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: CachedNetworkImage(
                imageUrl: _images[index],
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Container(
                      width: double.infinity,
                      height: double.infinity,
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
                width: double.infinity,
                height: double.infinity,
              ),
            );
          },
        ),

        Positioned(
          top: 24,
          right: 24,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              //create a white border white in color with 20% opacity
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.5),
                width: 0.28,
              ),
              borderRadius: BorderRadius.circular(56.0),
              color: AppColors.blackColor.withValues(alpha: 0.5)
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset("assets/icons/location.svg"),
                Text(
                  "Abuja, 4.5 km",
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 6,
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: RoundedIcon(
              isSmallIcon: true,
              svgAssetPath: "assets/icons/right_arrow.svg",
              onTap: () {
                _goToPage(_currentIndex + 1);
              },
            ),
          ),
        ),

        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: RoundedIcon(
              isSmallIcon: true,
              svgAssetPath: "assets/icons/left_arrow.svg",
              onTap: () {
                _goToPage(_currentIndex - 1);
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10, right: 12, left: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundedIcon(
                      svgAssetPath: "assets/icons/close.svg",
                      onTap: () {
                        _goToPage(_currentIndex - 1);
                      },
                    ),
                    SizedBox(width: 24),
                    RoundedIcon(
                      svgAssetPath: "assets/icons/lovely.svg",
                      onTap: () {
                        _goToPage(_currentIndex - 1);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Tiana, 27",
                                style: Theme.of(context).textTheme.labelSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 8,
                                      color: AppColors.alertBlackColor,
                                    ),
                              ),
                              SizedBox(width: 4),
                              SvgPicture.asset(
                                "assets/icons/check-badge.svg",
                                width: 16,
                                height: 17,
                              ),
                            ],
                          ),
                          Text(
                            "Confident, open-minded and here for real vibes only.",
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  fontSize: 6,
                                  color: AppColors.alertBlackColor,
                                ),
                          ),
                        ],
                      ),

                      Expanded(
                        child: Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          alignment: WrapAlignment.end,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.alertBlackColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "Cooking",
                                style: Theme.of(
                                  context,
                                ).textTheme.labelSmall?.copyWith(fontSize: 6),
                              ),
                            ),
                            SizedBox(width: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.alertBlackColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "Painting",
                                style: Theme.of(
                                  context,
                                ).textTheme.labelSmall?.copyWith(fontSize: 6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
