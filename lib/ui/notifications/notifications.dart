import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../app_theme/app_theme.dart';
import 'notification_tile.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                context.pop();
              },
              child: SvgPicture.asset(
                "assets/icons/arrow-left.svg",
                width: 32,
                height: 32,
              ),
            ),
            SizedBox(width: 16),
            Text(
              "Notifications",
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontSize: 24),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: AppTheme.surfaceGradientBox(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ListView(
              children: [
                SizedBox(height: 20),
                Text(
                  "Yesterday",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 18),
                NotificationTile(isMatched: false, isLiked: true),
                SizedBox(height: 24),
                NotificationTile(
                  isMatched: false,
                  name: "kiki Tina",
                  image: "assets/images/user3.jpg",
                ),
                SizedBox(height: 24),
                NotificationTile(
                  isMatched: false,
                  name: "Zina Chantel",
                  image: "assets/images/avatar1.jpg",
                ),
                SizedBox(height: 24),
                NotificationTile(isMatched: false),

                SizedBox(height: 30),
                Text(
                  "Last 7 days",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 18),
                NotificationTile(
                  isMatched: true,
                  isLiked: false,
                  name: "kiki Tina",
                  image: "assets/images/user3.jpg",
                ),
                SizedBox(height: 24),
                NotificationTile(isMatched: false,
                  name: "Michah Joe",
                  image: "assets/images/user2.jpg",
                ),
                SizedBox(height: 24),
                NotificationTile(isMatched: false,
                  name: "ceecee Chris",
                  image: "assets/images/avatar2.jpg",
                ),
                SizedBox(height: 24),
                NotificationTile(isMatched: true, isLiked: false,
                  name: "Minna Tim",
                  image: "assets/images/avatar1.jpg",
                ),
                SizedBox(height: 24),
                NotificationTile(isMatched: false, isLiked: false,
                  name: "Jerry File",
                  image: "assets/images/avatar4.jpg",
                ),
                SizedBox(height: 24),
                NotificationTile(isMatched: true),
                SizedBox(height: 24),
                NotificationTile(isMatched: false,
                  name: "Michah Joe",
                  image: "assets/images/user2.jpg",
                ),
                SizedBox(height: 24),
                NotificationTile(isMatched: true, isLiked: false,
                  name: "Minna Tim",
                  image: "assets/images/avatar1.jpg",
                ),
                SizedBox(height: 24),
                NotificationTile(isMatched: false,
                  name: "Jerry File",
                  image: "assets/images/avatar4.jpg",
                ),
                SizedBox(height: 24),
                NotificationTile(isMatched: false),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
