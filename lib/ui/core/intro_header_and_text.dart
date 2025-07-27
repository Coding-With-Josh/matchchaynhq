import 'package:flutter/material.dart';

class IntroHeaderAndSubtext extends StatelessWidget {
  const IntroHeaderAndSubtext({
    super.key,
    required this.header,
    required this.subtext,
    this.useSmallPadding = false,
  });

  final String header;
  final String subtext;
  final bool useSmallPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: useSmallPadding ? 12 : 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            header,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            subtext,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
