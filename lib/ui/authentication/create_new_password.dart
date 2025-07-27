import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matchchayn/ui/constants/app_colors.dart';
import 'package:matchchayn/ui/core/gradient_text_field.dart';
import 'package:matchchayn/ui/core/logo_and_text.dart';
import 'package:matchchayn/ui/core/primary_button.dart';

import '../app_theme/app_theme.dart';
import '../core/agree_to_terms_widget.dart';
import '../core/intro_header_and_text.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  late TextEditingController hiddenTextController;
  late TextEditingController passwordTextController;

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
                              header: "Create a new Password",
                              subtext: "",
                            ),
                            SizedBox(height: 32),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.loggedInCardColor,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 20,
                                  ),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/user.svg",
                                        width: 32,
                                        height: 32,
                                      ),
                                      SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Email Address",
                                            style: Theme.of(
                                              context,
                                            ).textTheme.labelSmall,
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            "dipedeji@gmail.com",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                GradientBorderTextField(
                                  fieldLabel: "Password",
                                  controller: hiddenTextController,
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
                                SizedBox(height: 12),
                                Row(
                                  children: [
                                    Expanded(
                                      child: PasswordStrengthIndicator(
                                        isActive: true,
                                        text: "Poor",
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: PasswordStrengthIndicator(
                                        isActive: true,
                                        text: "weak",
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: PasswordStrengthIndicator(
                                        isActive: false,
                                        text: "Normal",
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: PasswordStrengthIndicator(
                                        isActive: false,
                                        text: "Strong",
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 50),
                                PrimaryButton(
                                  text: "Get Started",
                                  onPressed: () {},
                                ),
                                SizedBox(height: 50),
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
