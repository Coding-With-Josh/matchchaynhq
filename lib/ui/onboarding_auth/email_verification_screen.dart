import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:matchchayn/ui/core/gradient_text_field.dart';
import 'package:matchchayn/ui/core/logo_and_text.dart';
import 'package:matchchayn/ui/core/primary_button.dart';
import 'package:matchchayn/ui/utils/show_snack_bar.dart';

import '../app_theme/app_theme.dart';
import '../core/alt_auth_text.dart';
import '../core/intro_header_and_text.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({
    super.key,
    required this.buttonText,
    required this.nextPage,
  });

  final String buttonText;
  final String nextPage;

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  late TextEditingController controller1;
  late TextEditingController controller2;
  late TextEditingController controller3;
  late TextEditingController controller4;

  @override
  void initState() {
    controller1 = TextEditingController();
    controller2 = TextEditingController();
    controller3 = TextEditingController();
    controller4 = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
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
                            SizedBox(height: 12),
                            LogoAndText(),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/arrow-left.svg",
                                  width: 32,
                                  height: 32,
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            SvgPicture.asset(
                              "assets/icons/mail_icon.svg",
                              width: 64,
                              height: 64,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IntroHeaderAndSubtext(
                                  useSmallPadding: true,
                                  header: "You've got a mail",
                                  subtext:
                                      "Check your inbox. Please enter the verification code sent to your email:dipedeji@gmail.com.",
                                ),
                                SizedBox(height: 50),
                                Row(
                                  children: [
                                    Expanded(
                                      child: GradientBorderTextField(
                                        controller: controller1,
                                        isNumberKeyboard: true,
                                        fieldLabel: "",
                                      ),
                                    ),
                                    SizedBox(width: 21),
                                    Expanded(
                                      child: GradientBorderTextField(
                                        controller: controller2,
                                        isNumberKeyboard: true,
                                        fieldLabel: "",
                                      ),
                                    ),
                                    SizedBox(width: 21),
                                    Expanded(
                                      child: GradientBorderTextField(
                                        controller: controller3,
                                        isNumberKeyboard: true,
                                        fieldLabel: "",
                                      ),
                                    ),
                                    SizedBox(width: 21),
                                    Expanded(
                                      child: GradientBorderTextField(
                                        controller: controller4,
                                        isNumberKeyboard: true,
                                        fieldLabel: "",
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),
                                AltAuthText(
                                  textPrompt: "Didn’t receive an email? ",
                                  actionText: "Resend code",
                                  onTap: () {
                                    showCustomSnackBar(context);
                                  },
                                  isSmallTexts: true,
                                ),
                                SizedBox(height: 42),
                                PrimaryButton(
                                  text: widget.buttonText,
                                  onPressed: () {
                                    context.push(widget.nextPage);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "By continuing, you agree to matchchayn",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    "Terms of service ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(
                                          decoration: TextDecoration.underline,
                                        ),
                                  ),
                                ),

                                Text(
                                  "and ",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.labelMedium,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    "Privacy Policy ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(
                                          decoration: TextDecoration.underline,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                          ],
                        ),
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
