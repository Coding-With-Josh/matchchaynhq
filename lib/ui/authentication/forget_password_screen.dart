import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matchchayn/ui/core/gradient_text_field.dart';
import 'package:matchchayn/ui/core/logo_and_text.dart';
import 'package:matchchayn/ui/core/primary_button.dart';

import '../../app_router/route_destinations.dart';
import '../app_theme/app_theme.dart';
import '../core/agree_to_terms_widget.dart';
import '../core/intro_header_and_text.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late TextEditingController emailController;

  @override
  void initState() {
    emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
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
                              header: "Forgot your password?",
                              subtext: "Enter your email to receive a link to reset your password.",
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
                                SizedBox(height: 48),
                                PrimaryButton(text: "Reset Password", onPressed: () {
                                  context.push(RouteDestinations.verifyEmailFromForgotPassword);
                                }),
                                SizedBox(height: 40),
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
