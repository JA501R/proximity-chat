import 'package:flutter/material.dart';

import 'features/nearby/nearby_screen.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/profile/user_profile.dart';
import 'services/profile_service.dart';

void main() {
  runApp(const GlanceApp());
}

class GlanceApp extends StatefulWidget {
  const GlanceApp({super.key});

  @override
  State<GlanceApp> createState() => _GlanceAppState();
}

class _GlanceAppState extends State<GlanceApp> {
  final ProfileService _profileService = ProfileService();

  UserProfile? _profile;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final profile = await _profileService.loadProfile();

    if (profile != null) {
      debugPrint('GLANCE PROFILE LOADED');
      debugPrint('User ID: ${profile.id}');
      debugPrint('Display name: ${profile.displayName}');
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _profile = profile;
      _isLoading = false;
    });
  }

  Future<void> _completeOnboarding(UserProfile profile) async {
    final savedProfile = await _profileService.saveProfile(profile);

    if (!mounted) {
      return;
    }

    setState(() {
      _profile = savedProfile;
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
      home: _buildHome(),
    );
  }

  Widget _buildHome() {
    if (_isLoading) {
      return const _SplashScreen();
    }

    if (_profile == null) {
      return OnboardingScreen(onCompleted: _completeOnboarding);
    }

    return const NearbyScreen();
  }
}

class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF080A0D),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.radar, size: 64, color: Color(0xFF4DA3FF)),
            SizedBox(height: 20),
            Text(
              'Glance',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
