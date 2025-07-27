import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../core/primary_button.dart';

class LiveEventsCarousel extends StatefulWidget {
  const LiveEventsCarousel({super.key});

  @override
  State<LiveEventsCarousel> createState() => _LiveEventsCarouselState();
}

class _LiveEventsCarouselState extends State<LiveEventsCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<EventData> events = [
    EventData(
      title: "Unlock the future of Finance",
      description:
          "Join top minds in crypto, blockchain, and Web3 for insight, innovation, and real-world connections.",
      buttonText: "Register for event",
      imageAsset: "assets/images/gift_box.png",
    ),
    EventData(
      title: "Health & Wellness Conference",
      description:
          "Discover tools for holistic well-being and mental clarity in a modern world.",
      buttonText: "Join Now",
      imageAsset: "assets/images/gift_box.png",
    ),
    EventData(
      title: "Tech Innovators Meetup",
      description:
          "Engage with developers, designers, and founders pushing tech boundaries.",
      buttonText: "Get Ticket",
      imageAsset: "assets/images/gift_box.png",
    ),
  ];

  void _onDotTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 140, // Adjust to fit
          child: PageView.builder(
            controller: _pageController,
            itemCount: events.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (_, index) => EventSlide(event: events[index]),
          ),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(events.length, (index) {
            final isSelected = _currentPage == index;
            return GestureDetector(
              onTap: () => _onDotTapped(index),
              child: isSelected
                  ? Container(
                      width: 24,
                      height: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primaryColor,
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? AppColors.primaryColor
                            : AppColors.whiteColor.withAlpha(76),
                      ),
                      width: 10,
                      height: 10,
                    ),
            );
          }),
        ),
      ],
    );
  }
}

class EventSlide extends StatelessWidget {
  final EventData event;

  const EventSlide({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, top: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            AppColors.primaryColor.withAlpha(50),
            AppColors.secondaryColor.withAlpha(25),
          ],
        ),
      ),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16, bottom: 16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.title,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 6),
                      Expanded(
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                          event.description,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      PrimaryButton(
                        padding: EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 16,
                        ),
                        hugContents: true,
                        text: event.buttonText,
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
          Positioned(
            right: 0,
            bottom: -24,
            child: Transform.rotate(
              angle: -16 * math.pi / 180,
              child: Image.asset(event.imageAsset, width: 120, height: 120),
            ),
          ),
        ],
      ),
    );
  }
}

class EventData {
  final String title;
  final String description;
  final String buttonText;
  final String imageAsset;

  EventData({
    required this.title,
    required this.description,
    required this.buttonText,
    required this.imageAsset,
  });
}
