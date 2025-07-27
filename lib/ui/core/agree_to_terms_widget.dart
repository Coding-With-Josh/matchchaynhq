import 'package:flutter/material.dart';

class AgreeToTermsWidget extends StatelessWidget {
  const AgreeToTermsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "By continuing, you agree to matchchayn",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {},
              child: Text(
                "Terms of service ",
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            Text("and ", style: Theme.of(context).textTheme.labelMedium),
            GestureDetector(
              onTap: () {},
              child: Text(
                "Privacy Policy ",
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
      ],
    );
  }
}
