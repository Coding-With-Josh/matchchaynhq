import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/app_colors.dart';
import '../core/intro_header_and_text.dart';

class UploadPhotosScreen extends StatefulWidget {
  const UploadPhotosScreen({super.key});

  @override
  State<UploadPhotosScreen> createState() => _UploadPhotosScreenState();
}

class _UploadPhotosScreenState extends State<UploadPhotosScreen> {
  XFile? image1;
  XFile? image2;
  XFile? image3;
  XFile? image4;

  Future<XFile?> _pickImage() async {
    //pick image
    final newImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    return newImage;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IntroHeaderAndSubtext(
            header: "Upload your Photos",
            subtext: "To boost your match potential,include photos.",
          ),
          SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: PickImageBox(
                        imageFile: image1,
                        onImagePicked: () async {
                          final image = await _pickImage();
                          setState(() {
                            image1 = image;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 24),
                    Expanded(
                      child: PickImageBox(
                        imageFile: image2,
                        onImagePicked: () async {
                          final image = await _pickImage();
                          setState(() {
                            image2 = image;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: PickImageBox(
                        imageFile: image3,
                        onImagePicked: () async {
                          final image = await _pickImage();
                          setState(() {
                            image3 = image;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 24),
                    Expanded(
                      child: PickImageBox(
                        imageFile: image4,
                        onImagePicked: () async {
                          final image = await _pickImage();
                          setState(() {
                            image4 = image;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}

class PickImageBox extends StatelessWidget {
  const PickImageBox({
    super.key,
    required this.imageFile,
    required this.onImagePicked,
  });

  final XFile? imageFile;
  final Function() onImagePicked;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onImagePicked,
      child: Container(
        height: 140,
        color: AppColors.whiteColor,
        child: Center(
          child: imageFile == null
              ? SvgPicture.asset(
                  "assets/icons/add_circle.svg",
                  width: 32,
                  height: 32,
                )
              : Image.file(
                  File(imageFile!.path),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
        ),
      ),
    );
  }
}
