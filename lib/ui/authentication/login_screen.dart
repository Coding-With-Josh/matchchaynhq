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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool hideText = false;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                              header: "Welcome  back to Matchchayn",
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
                                  controller: emailController,
                                  hintText: "enter email",
                                ),
                                SizedBox(height: 20),

                                GradientBorderTextField(
                                  fieldLabel: "Password",
                                  controller: passwordController,
                                  hideText: hideText,
                                  hintText: "enter password",
                                  // onTextChanged: (value) {
                                  //
                                  // },
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
                                SizedBox(height: 8),
                                GestureDetector(
                                  onTap: () {
                                    context.push(RouteDestinations.forgotPassword);
                                  },
                                  child: Text(
                                    "Forgot password?",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(fontWeight: FontWeight.w400),
                                  ),
                                ),
                                SizedBox(height: 48),
                                PrimaryButton(text: "Login", onPressed: () {
                                  context.go(RouteDestinations.home);
                                }),
                                SizedBox(height: 40),
                                AltAuthText(
                                  textPrompt:
                                      "Don’t have an account on Matchchayn? ",
                                  actionText: "Signup",
                                  onTap: () {
                                    context.pushReplacement(RouteDestinations.signUp);
                                  },
                                ),
                                SizedBox(height: 40),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(child: Divider()),
                                    SizedBox(width: 20),
                                    Text(
                                      "Or Login with ",
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
