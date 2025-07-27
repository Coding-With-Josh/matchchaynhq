import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matchchayn/ui/core/primary_button.dart';

import '../../app_router/route_destinations.dart';
import '../app_theme/app_theme.dart';
import '../core/alt_auth_text.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 16),
                      Image.asset("assets/images/get_started.png"),
                      SizedBox(height: 38),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              'Relax. Connect. Match.',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          SizedBox(height: 18),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "Find meaningful connections and intentional love with  Web3 professionals ",
                              style: Theme.of(context).textTheme.bodyLarge,
                              //align text to center
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 37),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            PrimaryButton(
                              text: "Get Started",
                              onPressed: () {
                                context.push(RouteDestinations.signUp);
                              },
                            ),
                            SizedBox(height: 30),
                            AltAuthText(
                              textPrompt: "Already registered on Matchchayn? ",
                              actionText: "Login",
                              onTap: () {
                                context.push(RouteDestinations.login);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
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
