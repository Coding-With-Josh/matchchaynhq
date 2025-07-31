import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matchchayn/ui/constants/app_colors.dart';
import 'package:matchchayn/ui/core/primary_button.dart';

import '../app_theme/app_theme.dart';
import 'custom_dropdown.dart';

class MomentsScreen extends StatefulWidget {
  const MomentsScreen({super.key, this.isCreateMoment = false});

  final bool isCreateMoment;

  @override
  State<MomentsScreen> createState() => _MomentsScreenState();
}

class _MomentsScreenState extends State<MomentsScreen>
    with SingleTickerProviderStateMixin {
  final List<String> stories = [
    'assets/images/user3.jpg',
    'assets/images/user1.png',
    'assets/images/user2.jpg',
  ];
  XFile? momentImage;
  bool showMenu = false;
  bool showTextField = true;
  String momentText = "";
  final PageController _pageController = PageController();
  late AnimationController _animationController;
  int _currentIndex = 0;
  Duration storyDuration = Duration(seconds: 5);
  late TextEditingController _textEditingController;

  _pickImage() async {
    //pick image
    final newImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    //  return newImage;
    final image = newImage;
    setState(() {
      momentImage = image;
    });
  }

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _animationController = AnimationController(
      vsync: this,
      duration: storyDuration,
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _goToNextStory();
      }
    });
    if (widget.isCreateMoment) {
      _pickImage();
    }
    _animationController.forward();
  }

  void _goToNextStory() {
    if (_currentIndex < stories.length - 1) {
      setState(() {
        _currentIndex++;
        _pageController.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
        _restartAnimation();
      });
    } else {
      context.pop(); // Exit or loop, depending on app logic
    }
  }

  void _restartAnimation() {
    _animationController.stop();
    _animationController.reset();
    _animationController.forward();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isCreateMoment
          ? AppBar(
              title: Text(
                "Create Moments",
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
              ),
              actions: [
                GestureDetector(
                  child: SvgPicture.asset(
                    "assets/icons/close.svg",
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      AppColors.whiteColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  onTap: () {
                    context.pop();
                  },
                ),
                SizedBox(width: 24),
              ],
            )
          : null,
      body: GestureDetector(
        onTap: () {
          setState(() {
            showMenu = false;
          });
        },
        child: Container(
          decoration: AppTheme.surfaceGradientBox(),
          child: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Stack(
              children: [
                if (widget.isCreateMoment)
                  Center(
                    child: PrimaryButton(
                      hugContents: true,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      text: "pick Image",
                      onPressed: () async {
                        _pickImage();
                      },
                    ),
                  ),
                if (widget.isCreateMoment && momentImage != null)
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: Image.file(
                      File(momentImage!.path),
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                if (!widget.isCreateMoment)
                  PageView.builder(
                    controller: _pageController,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: stories.length,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        child: Image.asset(
                          stories[index],
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                Positioned(
                  top: 14,
                  left: 24,
                  right: 24,
                  child: Column(
                    children: [
                      if (!widget.isCreateMoment)
                        Row(
                          children: List.generate(stories.length, (index) {
                            return Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2),
                                child: index == _currentIndex
                                    ? AnimatedBuilder(
                                        animation: _animationController,
                                        builder: (context, child) {
                                          return LinearProgressIndicator(
                                            borderRadius: BorderRadius.circular(
                                              1,
                                            ),
                                            minHeight: 2,
                                            value: _animationController.value,
                                            backgroundColor: Colors.white24,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                  Colors.white,
                                                ),
                                          );
                                        },
                                      )
                                    : LinearProgressIndicator(
                                        minHeight: 2,
                                        value: index < _currentIndex ? 1 : 0,
                                        backgroundColor: Colors.white24,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                      ),
                              ),
                            );
                          }),
                        ),
                      SizedBox(height: 18),
                      Visibility(
                        visible:
                            (!widget.isCreateMoment) ||
                            (widget.isCreateMoment && momentImage != null),

                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.blackColor.withValues(alpha: 0.3),

                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: AssetImage(
                                      "assets/images/avatar3.jpg",
                                    ),
                                    radius: 15,
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    "Glory",
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "4h",
                                    style: Theme.of(context).textTheme.labelSmall
                                        ?.copyWith(fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.blackColor.withValues(alpha: 0.3),

                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // MyCascadingMenu(),
                                      GestureDetector(
                                        child: SvgPicture.asset(
                                          "assets/icons/more.svg",
                                          width: 24,
                                          height: 24,
                                        ),
                                        onTap: () {
                                          setState(() {
                                            showMenu = !showMenu;
                                          });
                                        },
                                      ),
                                      SizedBox(width: 10),
                                      GestureDetector(
                                        child: SvgPicture.asset(
                                          "assets/icons/close.svg",
                                          width: 24,
                                          height: 24,
                                          colorFilter: ColorFilter.mode(
                                            AppColors.whiteColor,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                        onTap: () {
                                          context.pop();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Visibility(
                                  visible: showMenu,
                                  child: CustomDropdownButton(
                                    isCreateMoment: widget.isCreateMoment,
                                    onTap: () {
                                      setState(() {
                                        showMenu = !showMenu;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (momentText.isNotEmpty)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 32),
                      child: Text(
                        momentText,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                if (showTextField)
                  Positioned(
                    bottom: 22,
                    left: 24,
                    right: 24,
                    child: TextField(
                      controller: _textEditingController,
                     // style: Theme.of(context).textTheme.labelSmall,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 14.0,
                        ),
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: "Type your message here...",
                        hintStyle: Theme.of(context).textTheme.labelSmall
                            ?.copyWith(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w400,
                            ),
                        filled: true,
                        fillColor: AppColors.whiteColor.withValues(alpha: 0.14),
                        suffixIcon: GestureDetector(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                "assets/icons/send.svg",
                                width: 24,
                                height: 24,
                                colorFilter: ColorFilter.mode(
                                  AppColors.whiteColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                              SizedBox(width: 14),
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              momentText = _textEditingController.text;
                              showTextField = false;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyCascadingMenu extends StatefulWidget {
  const MyCascadingMenu({super.key});

  @override
  State<MyCascadingMenu> createState() => _MyCascadingMenuState();
}

class _MyCascadingMenuState extends State<MyCascadingMenu> {
  final FocusNode _buttonFocusNode = FocusNode(debugLabel: 'Menu Button');

  @override
  void dispose() {
    _buttonFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      style: MenuStyle(
        backgroundColor: WidgetStateProperty.all(
          AppColors.whiteColor.withValues(alpha: 0.14),
        ),
      ),
      childFocusNode: _buttonFocusNode,
      menuChildren: <Widget>[
        MenuItemButton(onPressed: () {}, child: const Text('Revert')),
        MenuItemButton(onPressed: () {}, child: const Text('Setting')),
        MenuItemButton(onPressed: () {}, child: const Text('Send Feedback')),
      ],
      builder: (_, MenuController controller, Widget? child) {
        return GestureDetector(
          child: SvgPicture.asset(
            "assets/icons/more.svg",
            width: 24,
            height: 24,
          ),
          onTap: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
        );
        // return IconButton(
        //   focusNode: _buttonFocusNode,
        //   onPressed: () {
        //     if (controller.isOpen) {
        //       controller.close();
        //     } else {
        //       controller.open();
        //     }
        //   },
        //   icon: const Icon(Icons.more_vert),
        // );
      },
    );
  }
}
