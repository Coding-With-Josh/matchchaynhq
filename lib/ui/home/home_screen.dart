import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:matchchayn/app_router/route_destinations.dart';
import 'package:matchchayn/ui/constants/app_colors.dart';
import 'package:matchchayn/ui/home/widgets/events_carousel.dart';
import 'package:matchchayn/ui/home/widgets/image_carousel.dart';
import 'package:matchchayn/ui/home/widgets/profile_status_listing.dart';

import '../app_theme/app_theme.dart';
import '../core/primary_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset("assets/images/logo.png", width: 45, height: 45),
            SizedBox(width: 10),
            Text(
              "MATCHCHAYN",
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontSize: 16),
            ),
          ],
        ),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
            decoration: BoxDecoration(
              color: AppColors.buttonGreyGrey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/coins.svg",
                  width: 24, // Adjust icon size as needed
                  height: 24,
                ),
                SizedBox(width: 6),
                Text("50", style: Theme.of(context).textTheme.labelMedium),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              context.push(RouteDestinations.notifications);
            },
            icon: SvgPicture.asset(
              "assets/icons/notification.svg",
              width: 24, // Adjust icon size as needed
              height: 24,
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Container(
        decoration: AppTheme.surfaceGradientBox(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 14),
                  ProfileStatusListing(
                    onCreateMoment: () {
                      //pass true if its create moment
                      context.push(RouteDestinations.moments, extra: true);
                    },
                    onViewMoment: () {
                      //pass false if its view moment
                      context.push(RouteDestinations.moments, extra: false);
                    },
                  ),
                  SizedBox(height: 31),
                  LiveEventsCarousel(),
                  SizedBox(height: 30),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: PrimaryGradientBackgroundContainer(
                                isCircular: false,
                                paddingSize: 16,
                                radius: 16,
                                child: SizedBox(height: 400),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 424, child: ImageCarousel()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EventCarousel extends StatelessWidget {
  const EventCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, top: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            AppColors.primaryColor.withValues(alpha: 0.2),
            AppColors.secondaryColor.withValues(alpha: 0.1),
          ],
        ),
      ),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        // Ensures overflowing parts are cut
        children: [
          // Main content
          Padding(
            padding: const EdgeInsets.only(right: 16, bottom: 16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Unlock the feature of Finance",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Join top minds in crypto, blockchain, and Web3 for a day of insight, innovation, and real-world connections.",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 12),
                      PrimaryButton(
                        padding: EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 16,
                        ),
                        hugContents: true,
                        text: "Register for event",
                        textStyle: Theme.of(context).textTheme.labelSmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 100),
              ],
            ),
          ),
          // Positioned image at bottom right
          Positioned(
            right: 0, // Adjust to cut part of the image
            bottom: -24, // Adjust to cut part of the image
            child: Transform.rotate(
              angle: -16 * math.pi / 180,
              child: Image.asset(
                "assets/images/gift_box.png",
                width: 120,
                height: 120,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PrimaryGradientBackgroundContainer extends StatelessWidget {
  const PrimaryGradientBackgroundContainer({
    super.key,
    required this.child,
    required this.isCircular,
    required this.paddingSize,
    required this.radius,
  });

  final bool isCircular;
  final Widget child;
  final double paddingSize;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(paddingSize),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryLinearGradient(),
        shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircular ? null : BorderRadius.circular(radius),
      ),
      child: child,
    );
  }
}
