import 'package:flutter/material.dart';

import '../core/primary_button.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    this.isLiked = false,
    this.isMatched = false,
  });

  final bool isLiked;
  final bool isMatched;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("assets/images/user1.png"),
              radius: 22,
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tiana Brooks",
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    isMatched
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Likes you too, ",
                                style: Theme.of(context).textTheme.labelSmall
                                    ?.copyWith(fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "You’ve got a Match",
                                style: Theme.of(context).textTheme.labelSmall
                                    ?.copyWith(fontWeight: FontWeight.w400),
                              ),
                            ],
                          )
                        : Text(
                            "Liked your moment",
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(fontWeight: FontWeight.w400),
                          ),
                    SizedBox(width: 20),
                    Text(
                      "2:28 PM",
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 8,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        isLiked
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  "assets/images/user2.jpg",
                  width: 36,
                  height: 36,
                  fit: BoxFit.cover,
                ),
              )
            : PrimaryButton(
                hugContents: true,
                textStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 8,
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                text: "View Profile",
                onPressed: () {},
              ),
      ],
    );
  }
}
