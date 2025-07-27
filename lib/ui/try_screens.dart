import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matchchayn/ui/core/round_icon.dart';
import 'dart:ui' as ui;

import 'constants/app_colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Dotted Gradient Border')),
        body: Center(
          child: DottedGradientBorderContainer(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              child: const Text(
                'Hello, Dotted Gradient Border!',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DottedGradientBorderContainer extends StatelessWidget {
  final Widget child;
  final double strokeWidth;
  final double dashLength;
  final double gapLength;
  final BorderRadius borderRadius;

  const DottedGradientBorderContainer({
    super.key,
    required this.child,
    this.strokeWidth = 2.0,
    this.dashLength = 5.0,
    this.gapLength = 3.0,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(8.0),
    ), // Default border radius
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DottedGradientBorderPainter(
        strokeWidth: strokeWidth,
        dashLength: dashLength,
        gapLength: gapLength,
        borderRadius: borderRadius,
        gradient: const LinearGradient(
          colors: [
            Color(0xFF9700FF), // Start color
            Color(0xffB95AFB), // End color
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius,
        ),
        child: child,
      ),
    );
  }
}

class DottedGradientBorderPainter extends CustomPainter {
  final double strokeWidth;
  final double dashLength;
  final double gapLength;
  final BorderRadius borderRadius;
  final Gradient gradient;

  DottedGradientBorderPainter({
    required this.strokeWidth,
    required this.dashLength,
    required this.gapLength,
    required this.borderRadius,
    required this.gradient,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final RRect outerRRect = borderRadius.toRRect(Offset.zero & size);
    final Rect bounds = Offset.zero & size;

    // Create a path for the rounded rectangle
    final Path path = Path()..addRRect(outerRRect);

    // Create a Paint object for the stroke
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // Apply the gradient as a shader
    paint.shader = gradient.createShader(bounds);

    // Draw the dotted line along the path
    _drawDottedPath(canvas, path, paint, dashLength, gapLength);
  }

  void _drawDottedPath(
    Canvas canvas,
    Path path,
    Paint paint,
    double dashLength,
    double gapLength,
  ) {
    for (ui.PathMetric metric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        final double end = distance + dashLength;
        if (end > metric.length) {
          // If the dash goes beyond the path length, draw the remaining part
          canvas.drawPath(metric.extractPath(distance, metric.length), paint);
          break;
        }
        canvas.drawPath(metric.extractPath(distance, end), paint);
        distance += dashLength + gapLength;
      }
    }
  }

  @override
  bool shouldRepaint(covariant DottedGradientBorderPainter oldDelegate) {
    return oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashLength != dashLength ||
        oldDelegate.gapLength != gapLength ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.gradient != gradient;
  }
}

class GenderSelectionScreen extends StatefulWidget {
  const GenderSelectionScreen({super.key});

  @override
  State<GenderSelectionScreen> createState() => _GenderSelectionScreenState();
}

class _GenderSelectionScreenState extends State<GenderSelectionScreen> {
  String? _selectedGender; // To store the selected gender

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gender Selection')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the selected gender
            Text(
              _selectedGender == null
                  ? 'No gender selected'
                  : 'Selected Gender: $_selectedGender',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // The MenuAnchor wrapped around an ElevatedButton
          ],
        ),
      ),
    );
  }
}
