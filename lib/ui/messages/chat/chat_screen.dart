import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:matchchayn/ui/constants/app_colors.dart';
import '../../../app_router/route_destinations.dart';
import '../../app_theme/app_theme.dart';
import '../../core/custom_pop_up_menu.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late TextEditingController messageController;

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
  }

  List<Widget> messages = [];

  List<PopupMenuEntry<String>> getChatScreenPopUpMenuItems(
    BuildContext context,
  ) {
    return <PopupMenuEntry<String>>[
      CustomPopUpMenuItem(
        text: 'View User Profile',
        onTap: () {
          context.pop();
        },
      ),
      const PopupMenuDivider(
        height: 1.0,
        color: AppColors.customPopUpDividerColor,
      ),
      CustomPopUpMenuItem(
        text: 'Unmatch',
        onTap: () {
          context.pop();
        },
      ),
      const PopupMenuDivider(
        height: 1.0,
        color: AppColors.customPopUpDividerColor,
      ),
      CustomPopUpMenuItem(
        text: 'Block',
        isDestructive: true,
        onTap: () {
          context.pop();
        },
      ),
      const PopupMenuDivider(
        height: 1.0,
        color: AppColors.customPopUpDividerColor,
      ),
      CustomPopUpMenuItem(
        text: 'Report User Profile',
        isDestructive: true,
        onTap: () {
          context.pop();
        },
      ),
    ];
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.chatScreenAppBar,
        //increase appbar height
        toolbarHeight: 72,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                context.pop();
              },
              child: SvgPicture.asset(
                "assets/icons/arrow-left.svg",
                width: 36,
                height: 36,
              ),
            ),
            SizedBox(width: 8),
            UserOnlineImage(),
            SizedBox(width: 8),
            Text("Tiana Brooks", style: Theme.of(context).textTheme.labelSmall),
            SizedBox(width: 8),
            SvgPicture.asset(
              "assets/icons/check-badge.svg",
              width: 14,
              height: 14,
            ),
          ],
        ),
        actions: [
          ChatMessageIcons(
            iconPath: "assets/icons/video.svg",
            onTap: () {
              context.push(RouteDestinations.calls);
            },
          ),
          SizedBox(width: 6),
          ChatMessageIcons(
            iconPath: "assets/icons/call.svg",
            onTap: () {
              context.push(RouteDestinations.calls);
            },
          ),
          SizedBox(width: 6),
          CustomIosStyledPopUpMenu(
            menuItems: getChatScreenPopUpMenuItems(context),
            child: ChatMessageIcons(iconPath: "assets/icons/more_options.svg"),
          ),
          SizedBox(width: 24),
        ],
      ),
      body: Container(
        decoration: AppTheme.surfaceGradientBox(),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ListView(
                    children: <Widget>[
                      SizedBox(height: 6),
                      DayCard(),
                      SizedBox(height: 20),
                      Column(
                        children: [
                          MessageCard(
                            isSender: true,
                            message:
                                "Hey there! 😊 I'm Heritage Isaac from Florida. Nice to finally connect!",
                          ),
                          SizedBox(height: 20),
                          MessageCard(
                            isSender: false,
                            message:
                                "Hi Heritage! 🌟 Likewise! It's cool to start chatting after seeing your profile.",
                          ),
                          SizedBox(height: 20),
                          MessageCard(
                            isSender: true,
                            message:
                                "Thanks! Your profile caught my eye too. So, what made you try out this app?",
                          ),
                          SizedBox(height: 20),
                          MessageCard(
                            isSender: false,
                            message:
                                "Well, I've heard good things about it, and I figured it's time to meet new people. How about you?",
                          ),
                          SizedBox(height: 20),
                          MessageCard(
                            isSender: true,
                            message:
                                "Same here! New year, new connections, right? 😄 What do you enjoy doing in your free time?",
                          ),
                          ...messages,
                        ],
                      ),

                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              ChatInputField(
                messageController: messageController,
                onSend: () {
                  setState(() {
                    messages.add(
                      Column(
                        children: [
                          SizedBox(height: 20),
                          MessageCard(
                            isSender: true,
                            message: messageController.text,
                          ),
                        ],
                      ),
                    );
                    messageController.clear();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatInputField extends StatelessWidget {
  const ChatInputField({
    super.key,
    required this.messageController,
    required this.onSend,
  });

  final TextEditingController messageController;
  final void Function() onSend;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Column(
        children: [
          Divider(color: AppColors.whiteColor, thickness: 1.5, height: 0),
          Expanded(
            child: TextField(
              style: Theme.of(context).textTheme.labelSmall,
              controller: messageController,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 0,
                ),
                hintText: "Type your message here...",
                hintStyle: Theme.of(context).textTheme.labelSmall,
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/mention.svg",
                      width: 24,
                      height: 24,
                    ),
                    SizedBox(width: 12),
                    GestureDetector(
                      onTap: onSend,
                      child: SvgPicture.asset(
                        "assets/icons/send.svg",
                        width: 24,
                        height: 24,
                      ),
                    ),

                    SizedBox(width: 16),
                  ],
                ),
                filled: true,
                fillColor: AppColors.whiteColor.withValues(alpha: 0.14),
                border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(20),
                  //use visible 1 pixel border
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Divider(color: AppColors.whiteColor, thickness: 1.5, height: 0),
        ],
      ),
    );
  }
}

class MessageCard extends StatelessWidget {
  const MessageCard({super.key, required this.isSender, required this.message});

  final bool isSender;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isSender
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 220,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: isSender
                    ? AppColors.messageSenderCardColor
                    : AppColors.messageReceiverCardColor,
                borderRadius: BorderRadius.only(
                  topLeft: isSender ? Radius.circular(4) : Radius.zero,
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                  topRight: isSender ? Radius.zero : Radius.circular(4),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: isSender
                          ? AppColors.messageSenderTextColor
                          : AppColors.messageReceiverTextColor,
                    ),
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: isSender
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      Text(
                        "11:52 AM",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontSize: 8,
                          color: AppColors.messageSenderTextColor,
                        ),
                      ),
                      if (isSender)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: 8),
                            SvgPicture.asset(
                              "assets/icons/delivered.svg",
                              width: 8,
                              height: 8,
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DayCard extends StatelessWidget {
  const DayCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(1),
        ),
        child: Text(
          "Today",
          style: Theme.of(
            context,
          ).textTheme.labelSmall?.copyWith(color: AppColors.blackColor),
        ),
      ),
    );
  }
}

class ChatMessageIcons extends StatelessWidget {
  const ChatMessageIcons({super.key, required this.iconPath, this.onTap});

  final String iconPath;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.whiteColor, width: 1),
        ),
        child: SvgPicture.asset(iconPath),
      ),
    );
  }
}

class UserOnlineImage extends StatelessWidget {
  const UserOnlineImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage("assets/images/user1.png"),
          radius: 22,
        ),
        Positioned(
          bottom: 2,
          right: 2,
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: AppColors.userOnlineColor,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.whiteColor, width: 1),
              //   borderRadius: BorderRadius.circular(2),
            ),
            child: SizedBox(),
          ),
        ),
      ],
    );
  }
}
