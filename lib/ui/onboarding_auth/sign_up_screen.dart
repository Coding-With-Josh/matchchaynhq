import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:matchchayn/ui/core/gradient_text_field.dart';
import 'package:matchchayn/ui/core/logo_and_text.dart';
import 'package:matchchayn/ui/core/primary_button.dart';
import 'package:matchchayn/ui/core/round_icon.dart';

import '../../app_router/route_destinations.dart';
import '../app_theme/app_theme.dart';
import '../core/agree_to_terms_widget.dart';
import '../core/alt_auth_text.dart';
import '../core/intro_header_and_text.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController controller;
  bool _isAgreedToTerms = false;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
                              header: "Welcome to Matchchayn",
                              subtext:
                                  "Match with those who vibe on your frequency on-chain.",
                              useSmallPadding: true,
                            ),
                            SizedBox(height: 64),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GradientBorderTextField(
                                  fieldLabel: "Email Address",
                                  controller: controller,
                                  hintText: "enter email",
                                ),
                                SizedBox(height: 12),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _isAgreedToTerms = !_isAgreedToTerms;
                                        });
                                      },
                                      child: _isAgreedToTerms
                                          ? SvgPicture.asset(
                                              "assets/icons/checked_icon.svg",
                                              width: 16,
                                              height: 16,
                                              colorFilter: ColorFilter.mode(
                                                Theme.of(
                                                  context,
                                                ).colorScheme.onSurface,
                                                BlendMode.srcIn,
                                              ),
                                            )
                                          : SvgPicture.asset(
                                              "assets/icons/unchecked_icon.svg",
                                              width: 16,
                                              height: 16,
                                              colorFilter: ColorFilter.mode(
                                                Theme.of(
                                                  context,
                                                ).colorScheme.onSurface,
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                    ),
                                    SizedBox(width: 4),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Agree with ",
                                          style: Theme.of(
                                            context,
                                          ).textTheme.labelSmall,
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Text(
                                            "Terms and Conditions ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall
                                                ?.copyWith(
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                          ),
                                        ),
                                        Text(
                                          "(18+ Only)",
                                          style: Theme.of(
                                            context,
                                          ).textTheme.labelSmall,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 48),
                                PrimaryButton(
                                  text: "Get Started",
                                  onPressed: () {
                                    context.push(RouteDestinations.verifyEmailFromSignUp);
                                  },
                                ),
                                SizedBox(height: 40),
                                AltAuthText(
                                  textPrompt:
                                      "Already registered on Matchchayn? ",
                                  actionText: "Login",
                                  onTap: () {
                                    context.pushReplacement(
                                      RouteDestinations.login,
                                    );
                                  },
                                ),
                                SizedBox(height: 40),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(child: Divider()),
                                    SizedBox(width: 20),
                                    Text(
                                      "Or continue with ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w400,
                                          ),
                                    ),
                                    SizedBox(width: 20),
                                    Expanded(child: Divider()),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RoundedIcon(
                                      svgAssetPath: "assets/icons/x.svg",
                                      onTap: () {},
                                    ),
                                    SizedBox(width: 20),
                                    RoundedIcon(
                                      svgAssetPath: "assets/icons/Google.svg",
                                      onTap: () {},
                                    ),
                                    SizedBox(width: 20),
                                    RoundedIcon(
                                      svgAssetPath: "assets/icons/apple.svg",
                                      onTap: () {},
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
