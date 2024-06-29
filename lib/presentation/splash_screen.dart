import 'package:flutter/material.dart';
import 'package:healthcy/widgets/splash_screen_widgets/animated_logo.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return  Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: const Center(
          child: AnimatedLogo(),
        ));
  }
}
