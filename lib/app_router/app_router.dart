import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matchchayn/app_router/route_destinations.dart';
import 'package:matchchayn/ui/authentication/create_new_password.dart';
import 'package:matchchayn/ui/authentication/forget_password_screen.dart';
import 'package:matchchayn/ui/authentication/login_screen.dart';
import 'package:matchchayn/ui/home/home_screen.dart';
import 'package:matchchayn/ui/messages/call/call_screen.dart';
import 'package:matchchayn/ui/messages/chat/chat_screen.dart';
import 'package:matchchayn/ui/messages/messages_screen.dart';
import 'package:matchchayn/ui/notifications/notifications.dart';
import 'package:matchchayn/ui/onboarding_auth/sign_up_screen.dart';
import 'package:matchchayn/ui/premium/premium_screen.dart';
import 'package:matchchayn/ui/profile/profile_screen.dart';
import 'package:matchchayn/ui/profile_onboarding/user_profile_onboarding_screen.dart';

import '../ui/bottom_nav_component.dart';
import '../ui/likes/likes_screen.dart';
import '../ui/moments/moments_screen.dart';
import '../ui/onboarding_auth/email_verification_screen.dart';
import '../ui/onboarding_auth/get_started_screen.dart';
import '../ui/onboarding_auth/set_password_screen.dart';
import '../ui/splash_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
final GlobalKey<StatefulNavigationShellState> _shellNavigatorKey =
    GlobalKey<StatefulNavigationShellState>(debugLabel: 'shell');

GoRouter createAppRouter({required bool isAuthenticated}) {
  final appRouter = GoRouter(
    initialLocation: RouteDestinations.splash,
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: RouteDestinations.splash,
        builder: (context, state) =>
            SplashScreen(isUnauthenticated: isAuthenticated),
      ),
      GoRoute(
        path: RouteDestinations.getStarted,
        builder: (context, state) => const GetStartedScreen(),
      ),
      StatefulShellRoute.indexedStack(
        key: _shellNavigatorKey,
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },

        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteDestinations.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteDestinations.likes,
                builder: (context, state) => const LikesScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteDestinations.messages,
                builder: (context, state) => const MessagesScreen(),
                routes: [
                  GoRoute(
                    path: RouteDestinations.chatScreenRelative,
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) => const ChatScreen(),
                  ),
                  GoRoute(
                    path: RouteDestinations.callRelative,
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) => const CallScreen(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteDestinations.profile,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      // GoRoute(
      //   path: RouteDestinations.home,
      //   builder: (context, state) => const HomeScreen(),
      // ),
      // GoRoute(
      //   path: RouteDestinations.likes,
      //   builder: (context, state) => const LikesScreen(),
      // ),
      // GoRoute(
      //   path: RouteDestinations.messages,
      //   builder: (context, state) => const MessagesScreen(),
      // ),
      GoRoute(
        path: RouteDestinations.moments,
        builder: (context, state) {
          final bool? isCreateMoment = state.extra as bool?;
          return MomentsScreen(isCreateMoment: isCreateMoment ?? false);
        },
      ),
      GoRoute(
        path: RouteDestinations.premium,
        builder: (context, state) => const PremiumScreen(),
      ),
      GoRoute(
        path: RouteDestinations.notifications,
        builder: (context, state) => const NotificationScreen(),
      ),
      GoRoute(
        path: RouteDestinations.signUp,
        builder: (context, state) => const SignUpScreen(),
        routes: [
          GoRoute(
            path: RouteDestinations.setPasswordRelative,
            builder: (context, state) => const SetPasswordScreen(),
          ),
          GoRoute(
            path: RouteDestinations.verifyEmailRelative,
            builder: (context, state) => const EmailVerificationScreen(
              buttonText: 'Verify Email',
              nextPage: RouteDestinations.setPassword,
            ),
          ),
        ],
      ),
      GoRoute(
        path: RouteDestinations.login,
        builder: (context, state) => const LoginScreen(),
      ),

      GoRoute(
        path: RouteDestinations.userProfileOnboarding,
        builder: (context, state) => const UserProfileOnboardingScreen(),
      ),

      GoRoute(
        path: RouteDestinations.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
        routes: [
          GoRoute(
            path: RouteDestinations.verifyEmailRelative,
            builder: (context, state) => const EmailVerificationScreen(
              buttonText: 'Verify OTP',
              nextPage: RouteDestinations.createNewPassword,
            ),
          ),
        ],
      ),
      GoRoute(
        path: RouteDestinations.createNewPassword,
        builder: (context, state) => const CreateNewPasswordScreen(),
      ),
    ],
  );
  return appRouter;
}
