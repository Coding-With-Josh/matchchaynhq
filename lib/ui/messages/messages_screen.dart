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
              ),
              MessageTile(
                message: "Thank you very much. I’m glad ...",
                isUnreadMessage: true,
              ),
              MessageTile(
                message: "That sounds nice...",
                isDeliveredMessage: true,
              ),
              MessageTile(
                message: "Thank you very much. I’m glad ...",
                isUserOnline: true,
              ),
              MessageTile(
                message: "Sure! let me tell you about w…",
                isMyMessageLast: true,
              ),
              MessageTile(
                message: "Thank you very much. I’m glad ...",
                isUnreadMessage: true,
              ),
              MessageTile(
                message: "That sounds nice...",
                isDeliveredMessage: true,
              ),
              MessageTile(
                message: "Thank you very much. I’m glad ...",
                isUserOnline: true,
              ),
              MessageTile(
                message: "Sure! let me tell you about w…",
                isMyMessageLast: true,
              ),
              MessageTile(
                message: "Thank you very much. I’m glad ...",
                isUnreadMessage: true,
              ),
              MessageTile(
                message: "That sounds nice...",
                isDeliveredMessage: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
