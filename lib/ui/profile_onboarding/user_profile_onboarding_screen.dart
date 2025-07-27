import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:matchchayn/ui/core/logo_and_text.dart';
import 'package:matchchayn/ui/profile_onboarding/create_profile_screen.dart';
import 'package:matchchayn/ui/profile_onboarding/select_interest_screen.dart';
import 'package:matchchayn/ui/profile_onboarding/upload_photo_screen.dart';
import 'package:matchchayn/ui/profile_onboarding/who_are_you_looking_to_meet.dart';

import '../../app_router/route_destinations.dart';
import '../app_theme/app_theme.dart';
import '../constants/app_colors.dart';
import '../core/agree_to_terms_widget.dart';
import '../core/primary_button.dart';

class UserProfileOnboardingScreen extends StatefulWidget {
  const UserProfileOnboardingScreen({super.key});

  @override
  State<UserProfileOnboardingScreen> createState() =>
      _UserProfileOnboardingScreenState();
}

class _UserProfileOnboardingScreenState
    extends State<UserProfileOnboardingScreen> {
  late PageController _controller;
  int _currentPage = 0;
  static const noScreens = 4;

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.whiteColor,
          title: SvgPicture.asset(
            "assets/icons/success_check.svg",
            width: 48,
            height: 48,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Account Successfully Created',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.alertBlackColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'Your profile is live. Start connecting with people who match your vibe.',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.alertGreyColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 28),
              PrimaryButton(
                text: "Start Exploring Matches",
                onPressed: () {
                  context.go(RouteDestinations.home);
                 // Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _nextPage(BuildContext context) {
    if (_currentPage < noScreens - 1) {
      _controller.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _showMyDialog();
      //context.go(Routes.home);
    }
  }

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppTheme.surfaceGradientBox(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      LogoAndText(),
                      SizedBox(height: 12),
                      ProgressIndicator(
                        progressNumber: _currentPage,
                        totalNumber: noScreens,
                      ),
                      SizedBox(height: 12),
                      Expanded(
                        child: PageView(
                          controller: _controller,
                          physics: NeverScrollableScrollPhysics(),
                          onPageChanged: (index) {
                            setState(() {
                              _currentPage = index;
                            });
                          },
                          children: [
                            CreateProfileScreen(),
                            SelectInterestScreen(),
                            WhoAreYouLookingToMeetScreen(),
                            UploadPhotosScreen(),
                          ],
                        ),
                      ),
                      PrimaryButton(
                        text: "Continue",
                        onPressed: () {
                          _nextPage(context);
                        },
                      ),
                      SizedBox(height: 32),
                    ],
                  ),
                ),
                AgreeToTermsWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProgressIndicator extends StatelessWidget {
  const ProgressIndicator({
    super.key,
    required this.progressNumber,
    required this.totalNumber,
  });

  final int totalNumber;
  final int progressNumber;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
          totalNumber,
          (index) => ProgressIndicatorTile(isActive: index <= progressNumber),
        ),
        SizedBox(width: 8),
        Text(
          "${progressNumber + 1}/$totalNumber",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}

class ProgressIndicatorTile extends StatelessWidget {
  const ProgressIndicatorTile({super.key, required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 6,
          width: 42,
          decoration: BoxDecoration(
            color: isActive ? AppColors.secondaryColor : AppColors.whiteColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }
}
