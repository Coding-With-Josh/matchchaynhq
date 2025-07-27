import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RoundedIcon extends StatelessWidget {
  final String svgAssetPath;
  final VoidCallback onTap; // Callback for when the icon is tapped
  final bool isSmallIcon;

  const RoundedIcon({
    super.key,
    required this.svgAssetPath,
    required this.onTap,
    this.isSmallIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      // Required for InkWell's ripple effect
      color: Colors.transparent, // Make Material transparent
      child: InkWell(
        onTap: onTap,
        // Your tap handler
        borderRadius: BorderRadius.circular(24),
        // Half of width/height for perfect circle
        child: Container(
          width: isSmallIcon ? 24 : 48,
          height: isSmallIcon ? 24 : 48,
          decoration: BoxDecoration(
            color: Colors.white, // White background
            shape: BoxShape.circle, // Circular shape
          ),
          child: Center(
            child: SvgPicture.asset(
              svgAssetPath,
              width: isSmallIcon ? 12 : 24, // Adjust icon size as needed
              height: isSmallIcon ? 12 : 24,
            ),
          ),
        ),
      ),
    );
  }
}
