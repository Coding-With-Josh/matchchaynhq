import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_liveness_detection/flutter_liveness_detection.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:camera/camera.dart';

import '../core/primary_button.dart';


class FaceVerification extends StatefulWidget {
  const FaceVerification({super.key});

  @override
  State<FaceVerification> createState() => _FaceVerificationState();
}

class _FaceVerificationState extends State<FaceVerification> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> requestCameraPermission() async {
    final status = await Permission.camera.request();
  }

  File? imageFile;
  Uint8List? faceBytes;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                context.pop();
              },
              child: SvgPicture.asset(
                "assets/icons/arrow-left.svg",
                width: 32,
                height: 32,
              ),
            ),
            SizedBox(width: 16),
            Text(
              "Verify your face",
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontSize: 24),
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text(
                "To verify your account, we need to verify your face, is same as the pictures you uploaded",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 30),

              (imageFile != null)
                  ? SizedBox(
                      height: 200,
                      width: 150,
                      child: Image.file(imageFile!),
                    )
                  : SizedBox(),
              PrimaryButton(
                text: "verify now",
                onPressed: () async {
                  //method 1
                  // PermissionStatus status = await Permission.camera.request();
                  // if (status.isGranted && context.mounted) {
                  //   Uint8List? faceBytes = await FaceCollectScreen.show(context);
                  //   if (faceBytes != null) {
                  //     setState(() {
                  //       this.faceBytes = faceBytes;
                  //     });
                  //   }
                  // }


                  // method 2
                  await requestCameraPermission();

                  /// 1️⃣ Check if the device has any cameras.
                  /// (We need at least one front camera to run liveness detection)
                  final List<CameraDescription> cameras =
                      await availableCameras();

                  if (cameras.isNotEmpty) {
                    /// 2️⃣ Open the liveness detection screen.
                    /// Call the **FlutterLivenessDetection** widget — this is required.
                    /// It will guide the user to blink, smile, or turn their head,
                    /// then take a selfie automatically.
                    final XFile? result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FlutterLivenessDetection(),
                      ),
                    );

                    /// 3️⃣ If detection was successful, you will get a selfie image.
                    if (result != null) {
                      /// 4️⃣ Print the selfie image path (you can upload or save this file).
                      print('Selfie path: ${result.path}');

                      /// 5️⃣ Show a success message to the user.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Verification Successful!')),
                      );
                    }
                  } else {
                    /// ❌ No camera found → Show an error message.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Camera not active!')),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
// class FaceVerification extends StatefulWidget {
//   const FaceVerification({super.key});
//
//   @override
//   State<FaceVerification> createState() => _FaceVerificationState();
// }
//
// class _FaceVerificationState extends State<FaceVerification> {
//   @override
//   void initState() async {
//     await requestCameraPermission();
//     super.initState();
//   }
//
//   Future<void> requestCameraPermission() async {
//     final status = await Permission.camera.request();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Row(
//           children: [
//             GestureDetector(
//               onTap: () {
//                 context.pop();
//               },
//               child: SvgPicture.asset(
//                 "assets/icons/arrow-left.svg",
//                 width: 32,
//                 height: 32,
//               ),
//             ),
//             SizedBox(width: 16),
//             Text(
//               "Verify your face",
//               style: Theme.of(
//                 context,
//               ).textTheme.titleMedium?.copyWith(fontSize: 24),
//             ),
//           ],
//         ),
//       ),
//       body: Container(
//         decoration: AppTheme.surfaceGradientBox(),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "To verify your account, we need to verify your face, is same as the pictures you uploaded",
//                 ),
//                 SizedBox(height: 48,),
//                 PrimaryButton(text: "verify face", onPressed: () {}),
//                 ElevatedButton(
//                   onPressed: () async {
//
//                     /// 1️⃣ Check if the device has any cameras.
//                     /// (We need at least one front camera to run liveness detection)
//                     final List<CameraDescription> cameras = await availableCameras();
//
//                     if (cameras.isNotEmpty) {
//
//                       /// 2️⃣ Open the liveness detection screen.
//                       /// Call the **FlutterLivenessDetection** widget — this is required.
//                       /// It will guide the user to blink, smile, or turn their head,
//                       /// then take a selfie automatically.
//                       final XFile? result = await Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => const FlutterLivenessDetection()),
//                       );
//
//                       /// 3️⃣ If detection was successful, you will get a selfie image.
//                       if (result != null) {
//                         /// 4️⃣ Print the selfie image path (you can upload or save this file).
//                         print('Selfie path: ${result.path}');
//
//                         /// 5️⃣ Show a success message to the user.
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text('Verification Successful!')),
//                         );
//                       }
//                     } else {
//                       /// ❌ No camera found → Show an error message.
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text('Camera not active!')),
//                       );
//                     }
//                   },
//
//                   /// The button users click to start liveness detection.
//                   child: const Text('Start Liveness Detection'),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
