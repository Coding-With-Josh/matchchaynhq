import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matchchayn/ui/messages/message_tile.dart';
import '../../app_router/route_destinations.dart';
import '../app_theme/app_theme.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Messages",
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontSize: 24),
        ),
      ),
      body: Container(
        decoration: AppTheme.surfaceGradientBox(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ListView(
            children: [
              MessageTile(
                message: "Thank you very much. I’m glad ...",
                isUserOnline: true,
                onTap: () {
                  context.push(RouteDestinations.chatScreen);
                },
              ),
              MessageTile(
                message: "Sure! let me tell you about w…",
                isMyMessageLast: true,
                name: "Tope James",
                image: "assets/images/user3.jpg",
                onTap: () {
                  context.push(RouteDestinations.chatScreen);
                },
              ),
              MessageTile(
                message: "Thank you very much. I’m glad ...",
                isUnreadMessage: true,
                name: "Chris Tomi",
                image: "assets/images/user2.jpg",
                onTap: () {
                  context.push(RouteDestinations.chatScreen);
                },
              ),
              MessageTile(
                message: "That sounds nice...",
                isDeliveredMessage: true,
                name: "Lana Titi",
                image: "assets/images/user1.png",
                onTap: () {
                  context.push(RouteDestinations.chatScreen);
                },
              ),
              MessageTile(
                message: "Thank you very much. I’m glad ...",
                isUserOnline: true,
                name: "Milly Audu",
                image: "assets/images/avatar2.jpg",
                onTap: () {
                  context.push(RouteDestinations.chatScreen);
                },
              ),
              MessageTile(
                message: "Sure! let me tell you about w…",
                isMyMessageLast: true,
                name: "Cece Obi",
                image: "assets/images/avatar4.jpg",
                onTap: () {
                  context.push(RouteDestinations.chatScreen);
                },
              ),
              MessageTile(
                message: "Thank you very much. I’m glad ...",
                isUnreadMessage: true,
                name: "Kante Clinton",
                image: "assets/images/avatar1.jpg",
                onTap: () {
                  context.push(RouteDestinations.chatScreen);
                },
              ),
              MessageTile(
                message: "That sounds nice...",
                isDeliveredMessage: true,
                name: "Fumi Lawal",
                image: "assets/images/avatar3.jpg",
                onTap: () {
                  context.push(RouteDestinations.chatScreen);
                },
              ),
              MessageTile(
                message: "Thank you very much. I’m glad ...",
                isUserOnline: true,
                name: "Kachi Mama",
                image: "assets/images/user3.jpg",
                onTap: () {
                  context.push(RouteDestinations.chatScreen);
                },
              ),
              MessageTile(
                message: "Sure! let me tell you about w…",
                isMyMessageLast: true,
                name: "Chidi Okonkwo",
                image: "assets/images/user2.jpg",
                onTap: () {
                  context.push(RouteDestinations.chatScreen);
                },
              ),
              MessageTile(
                message: "Thank you very much. I’m glad ...",
                isUnreadMessage: true,
                name: "Gina Tony",
                image: "assets/images/user1.png",
                onTap: () {
                  context.push(RouteDestinations.chatScreen);
                },
              ),
              MessageTile(
                message: "That sounds nice...",
                isDeliveredMessage: true,
                name: "Halima John",
                image: "assets/images/avatar3.jpg",
                onTap: () {
                  context.push(RouteDestinations.chatScreen);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
