import 'package:flutter/material.dart';

import 'features/nearby/nearby_screen.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/profile/user_profile.dart';

void main() {
  runApp(const GlanceApp());
}

class GlanceApp extends StatefulWidget {
  const GlanceApp({super.key});

  @override
  State<GlanceApp> createState() => _GlanceAppState();
}

class _GlanceAppState extends State<GlanceApp> {
  UserProfile? _profile;

  void _completeOnboarding(UserProfile profile) {
    setState(() {
      _profile = profile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glance',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF080A0D),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4DA3FF),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: _profile == null
          ? OnboardingScreen(onCompleted: _completeOnboarding)
          : const NearbyScreen(),
    );
  }
}
