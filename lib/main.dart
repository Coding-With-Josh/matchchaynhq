import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_router/app_router.dart';
import 'ui/app_theme/app_theme.dart';

void main() {
  final appRouter = createAppRouter(isAuthenticated: false);

  runApp(MyApp(appRouter: appRouter));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});

  final GoRouter appRouter;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MATCHCHAYN',
      theme: ThemeData(
        colorScheme: AppTheme.appColorScheme(),
        textTheme: AppTheme.appTextTheme(),
        sliderTheme: AppTheme.sliderTheme(),
      ),
      // home: const UserProfileOnboardingScreen(),
      routerConfig: appRouter,
    );
  }
}
