import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/app_colors.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({
    super.key,
    this.isUserOnline = false,
    this.isMyMessageLast = false,
    this.isUnreadMessage = false,
    this.isDeliveredMessage = false,
    this.name = "Tiana Brooks",
    this.image = "assets/images/user1.png",
    required this.message,
    this.onTap,
  });

  final String name;
  final String image;
  final bool isUserOnline;
  final bool isMyMessageLast;

  final String message;

  final bool isUnreadMessage;

  final bool isDeliveredMessage;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(backgroundImage: AssetImage(image), radius: 22),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            name,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(width: 8),
                          if (isUserOnline)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: AppColors.userOnlineColor,
                                shape: BoxShape.circle,
                              ),
                              child: SizedBox(),
                            ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        isMyMessageLast ? "You: $message" : message,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "2:30 PM",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 6),
                  if (isUnreadMessage)
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          "1",
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                fontWeight: FontWeight.w400,
                              //  fontSize: 8,
                              ),
                        ),
                      ),
                    ),
                  if (isDeliveredMessage)
                    SvgPicture.asset(
                      "assets/icons/delivered.svg",
                      width: 16,
                      height: 16,
                    ),
                ],
              ),
            ],
          ),
          SizedBox(height: 14),
          Divider(color: AppColors.popUpDividerColor, thickness: 1),
        ],
      ),
    );
  }
}
