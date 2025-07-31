import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:matchchayn/ui/constants/app_colors.dart';
import 'package:matchchayn/ui/core/gradient_text_field.dart';
import 'package:matchchayn/ui/core/logo_and_text.dart';
import 'package:matchchayn/ui/core/primary_button.dart';

import '../../app_router/route_destinations.dart';
import '../app_theme/app_theme.dart';
import '../core/agree_to_terms_widget.dart';
import '../core/intro_header_and_text.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  late TextEditingController hiddenTextController;
  late TextEditingController passwordTextController;
  bool poorPasswordIndicator = false;
  bool weakPasswordIndicator = false;
  bool normalPasswordIndicator = false;
  bool strongPasswordIndicator = false;

  bool hideText = false;

  @override
  void initState() {
    hiddenTextController = TextEditingController();
    passwordTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    hiddenTextController.dispose();
    passwordTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppTheme.surfaceGradientBox(),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            LogoAndText(),
                            SizedBox(height: 24),
                            IntroHeaderAndSubtext(
                              useSmallPadding: true,
                              header: "Set Password",
                              subtext:
                                  "Secure your account by setting a password you’ll remember.",
                            ),
                            SizedBox(height: 64),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GradientBorderTextField(
                                  fieldLabel: "Password",
                                  controller: hiddenTextController,
                                  hideText: hideText,
                                  hintText: "enter password",
                                  onTextChanged: (value) {
                                    setState(() {
                                      //if its less than 8 its poor
                                      if (value.length < 8) {
                                        poorPasswordIndicator = true;
                                      }
                                      //if its 8 or more its weak
                                      if (value.length >= 8) {
                                        weakPasswordIndicator = true;
                                      } else {
                                        weakPasswordIndicator = false;
                                      }
                                      //if its 8 or more, and has a capital ler its normal
                                      if (value.length >= 8 &&
                                          (value.contains(RegExp(r'[A-Z]')) ||
                                              value.contains(
                                                RegExp(r'[0-9]'),
                                              ))) {
                                        normalPasswordIndicator = true;
                                      } else {
                                        normalPasswordIndicator = false;
                                      }
                                      //if its 8 or more, has a capital letter, and has a number its strong
                                      if (value.length >= 8 &&
                                          value.contains(RegExp(r'[A-Z]')) &&
                                          value.contains(RegExp(r'[0-9]'))) {
                                        strongPasswordIndicator = true;
                                      } else {
                                        strongPasswordIndicator = false;
                                      }
                                    });
                                  },
                                  onSuffixIconPressed: () {
                                    setState(() {
                                      hideText = !hideText;
                                    });
                                  },
                                  suffixIcon: hideText
                                      ? SvgPicture.asset(
                                          "assets/icons/invisible.svg",
                                          width: 16,
                                          height: 16,
                                        )
                                      : SvgPicture.asset(
                                          "assets/icons/visible.svg",
                                          width: 16,
                                          height: 16,
                                        ),
                                ),
                                SizedBox(height: 12),
                                Row(
                                  children: [
                                    Expanded(
                                      child: PasswordStrengthIndicator(
                                        isActive: poorPasswordIndicator,
                                        text: "Poor",
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: PasswordStrengthIndicator(
                                        isActive: weakPasswordIndicator,
                                        text: "weak",
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: PasswordStrengthIndicator(
                                        isActive: normalPasswordIndicator,
                                        text: "Normal",
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: PasswordStrengthIndicator(
                                        isActive: strongPasswordIndicator,
                                        text: "Strong",
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 50),
                                PrimaryButton(
                                  text: "Get Started",
                                  onPressed: () {
                                    context.go(
                                      RouteDestinations.userProfileOnboarding,
                                    );
                                  },
                                ),
                                SizedBox(height: 50),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Your password must contain the following",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall,
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        PasswordRequirementTile(
                                          text: "Minimum of 8 characters",
                                        ),
                                        PasswordRequirementTile(
                                          text: "Contains 1 capital letter",
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        PasswordRequirementTile(
                                          text: "Contain 1 number",
                                        ),
                                        PasswordRequirementTile(
                                          text: "Contains 1 special  letter",
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        AgreeToTermsWidget(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class PasswordStrengthIndicator extends StatelessWidget {
  const PasswordStrengthIndicator({
    super.key,
    required this.isActive,
    required this.text,
  });

  final bool isActive;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 6,
          // width: 64,
          decoration: BoxDecoration(
            color: isActive ? AppColors.secondaryColor : AppColors.whiteColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Text(
          text,
          style: Theme.of(
            context,
          ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}

class ListingBox extends StatelessWidget {
  const ListingBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        gradient: AppTheme.primaryLinearGradient(),
        // borderRadius: BorderRadius.circular(0),
      ),
    );
  }
}

class PasswordRequirementTile extends StatelessWidget {
  const PasswordRequirementTile({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          ListingBox(),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: Theme.of(
                context,
              ).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
