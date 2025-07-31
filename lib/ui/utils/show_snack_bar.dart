import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matchchayn/ui/constants/app_colors.dart';

class SnackBarWithProgress extends StatefulWidget {
  final String message;
  final String subMessage;
  final Duration duration;
  final VoidCallback onClose;

  const SnackBarWithProgress({
    super.key,
    required this.message,
    required this.subMessage,
    required this.duration,
    required this.onClose,
  });

  @override
  State<SnackBarWithProgress> createState() => _SnackBarWithProgressState();
}

class _SnackBarWithProgressState extends State<SnackBarWithProgress> {
  late final ValueNotifier<double> progress = ValueNotifier(1.0);
  Timer? timer;

  @override
  void initState() {
    super.initState();

    final totalMs = widget.duration.inMilliseconds;
    const interval = 100;
    final decrement = 1 / (totalMs / interval);

    timer = Timer.periodic(const Duration(milliseconds: interval), (t) {
      if (!mounted) return;
      progress.value -= decrement;
      if (progress.value <= 0) {
        t.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    progress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 8, 20),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/success_check.svg",
                      width: 28,
                      height: 28,
                    ),
                    SizedBox(width: 25),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.message,
                            style: Theme.of(context).textTheme.labelMedium
                                ?.copyWith(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Text(
                            widget.subMessage,
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.close,
                  color: AppColors.blackColor,
                  size: 16,
                ),
                onPressed: () {
                  widget.onClose();
                },
              ),
            ],
          ),
        ),
        ValueListenableBuilder<double>(
          valueListenable: progress,
          builder: (context, value, _) {
            return LinearProgressIndicator(
              value: value.clamp(0.0, 1.0),
              minHeight: 4,
              backgroundColor: Colors.transparent,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.snackBarSuccess,
              ),
            );
          },
        ),
      ],
    );
  }
}

void showCustomSnackBar({
  required BuildContext context,
  required String message,
  required String subMessage,
}) {
  final messenger = ScaffoldMessenger.of(context);
  const duration = Duration(seconds: 5);

  final snackBar = SnackBar(
    duration: duration,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.only(bottom: 80, left: 16, right: 16),
    backgroundColor: AppColors.whiteColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
    padding: EdgeInsets.zero,
    content: SnackBarWithProgress(
      message: message,
      subMessage: subMessage,
      duration: duration,
      onClose: () {
        messenger.hideCurrentSnackBar();
      },
    ),
  );

  messenger.showSnackBar(snackBar);
}
