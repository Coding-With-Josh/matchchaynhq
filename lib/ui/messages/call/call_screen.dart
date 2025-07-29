import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

import '../../app_theme/app_theme.dart';
import 'call_control_icon.dart';

// TODO : REPLACE THIS SCREEN WITH A VIDEO CALL USING ZEGO OR AGORA SDK
class CallScreen extends StatelessWidget {
  const CallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppTheme.surfaceGradientBox(),
        child: VideoApp(),
      ),
    );
  }
}

/// Stateful widget to fetch and then display video content.
class VideoApp extends StatefulWidget {
  const VideoApp({super.key});

  @override
  VideoAppState createState() => VideoAppState();
}

class VideoAppState extends State<VideoApp> {
  bool hasPickedCall = false;
  late VideoPlayerController _controller1;

  // late VideoPlayerController _controller2;

  final String videoUrl1 =
      'https://github.com/bethel-m/matchayn_images/raw/refs/heads/main/man.mp4';
  final String videoUrl2 =
      'https://github.com/bethel-m/matchayn_images/raw/refs/heads/main/boy.mp4'; // Another example video

  @override
  void initState() {
    super.initState();

    _controller1 = VideoPlayerController.networkUrl(Uri.parse(videoUrl1))
      ..initialize().then((_) {
        _controller1.setLooping(true);
        _controller1.setVolume(0.0); // 🔇 MUTE
        _controller1.play();
        setState(() {});
      });

    // _controller2 = VideoPlayerController.networkUrl(Uri.parse(videoUrl2))
    //   ..initialize().then((_) {
    //     _controller2.setLooping(true);
    //     _controller2.setVolume(0.0); // 🔇 MUTE
    //     _controller2.play();
    //     setState(() {});
    //   });
    // Timer.periodic(Duration(seconds: 1), (timer) {
    //   if (_controller1.value.isInitialized) {
    //     print("Video 1: ${_controller1.value.position}---------------------------------------------------------------------------------------------------------------------------");
    //   }
    //   if (_controller2.value.isInitialized) {
    //     print("Video 2: ${_controller2.value.position}==============================================================================================================================");
    //   }
    // });

    Future.delayed(Duration(seconds: 5), () {
      if (mounted) {
        // Check if the widget is still in the widget tree
        setState(() {
          hasPickedCall = true;
        });
      }
    });
  }

  @override
  dispose() {
    _controller1.dispose();
    // _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SizedBox(
          child: !hasPickedCall
              ? Image.asset(
                  "assets/images/user2.jpg",
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                )
              : _controller1.value.isInitialized
              ? SizedBox.expand(
                  // Takes up all available space
                  child: FittedBox(
                    fit: BoxFit.cover, // This is key for cropping while filling
                    child: SizedBox(
                      width: _controller1.value.size.width,
                      height: _controller1.value.size.height,
                      child: VideoPlayer(_controller1),
                    ),
                  ),
                )
              : Image.asset(
                  "assets/images/user2.jpg",
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
        ),
        Visibility(
          visible: hasPickedCall,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 150, right: 30),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: SizedBox(
                  height: 120,
                  width: 100,
                  child: _controller1.value.isInitialized
                      ? SizedBox.expand(
                          // Takes up all available space
                          child: FittedBox(
                            fit: BoxFit
                                .cover, // This is key for cropping while filling
                            child: SizedBox(
                              width: _controller1.value.size.width,
                              height: _controller1.value.size.height,
                              child: VideoPlayer(_controller1),
                            ),
                          ),
                        )
                      : Image.asset(
                          "assets/images/user1.png",
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: hasPickedCall,
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Tiana Brooks",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    "1:05",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: !hasPickedCall,
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                UserCallPendingImage(),
                Text(
                  "Tiana Brooks",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 24),
                Text(
                  "Ringing...",
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 36),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CallControlIcon(iconPath: "assets/icons/speaker.svg"),
                SizedBox(width: 18),
                CallControlIcon(iconPath: "assets/icons/video_mode.svg"),
                SizedBox(width: 18),
                CallControlIcon(iconPath: "assets/icons/mic.svg"),
                SizedBox(width: 18),
                CallControlIcon(
                  iconPath: "assets/icons/call_mode.svg",
                  isDestructive: true,
                  onTap: () {
                    context.pop();
                  },
                ),
                // SizedBox(width: 18),
                // FloatingActionButton(
                //   onPressed: () {
                //     setState(() {
                //       _controller.value.isPlaying
                //           ? _controller.pause()
                //           : _controller.play();
                //     });
                //   },
                //   child: Icon(
                //     _controller.value.isPlaying
                //         ? Icons.pause
                //         : Icons.play_arrow,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class UserCallPendingImage extends StatelessWidget {
  const UserCallPendingImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage("assets/images/user1.png"),
          radius: 45,
        ),
      ],
    );
  }
}
