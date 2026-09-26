import 'package:flutter/material.dart';

import '../profile/user_profile.dart';

class OnboardingScreen extends StatefulWidget {
  final ValueChanged<UserProfile> onCompleted;

  const OnboardingScreen({super.key, required this.onCompleted});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  bool get _canContinue {
    return _nameController.text.trim().isNotEmpty;
  }

  void _completeOnboarding() {
    if (!_canContinue) {
      return;
    }

    final profile = UserProfile(
      displayName: _nameController.text.trim(),
      bio: _bioController.text.trim(),
    );

    widget.onCompleted(profile);
  }

  @override
  void initState() {
    super.initState();

    _nameController.addListener(_onInputChanged);
    _bioController.addListener(_onInputChanged);
  }

  void _onInputChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _nameController.removeListener(_onInputChanged);
    _bioController.removeListener(_onInputChanged);

    _nameController.dispose();
    _bioController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080A0D),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.radar, size: 64, color: Color(0xFF4DA3FF)),

                  const SizedBox(height: 28),

                  const Text(
                    'Welcome to Glance',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'Meet and connect with people who are right around you.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.4,
                      color: Colors.white.withValues(alpha: 0.55),
                    ),
                  ),

                  const SizedBox(height: 44),

                  const Text(
                    'What should people call you?',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 10),

                  TextField(
                    controller: _nameController,
                    maxLength: 30,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Display name',
                      filled: true,
                      fillColor: Colors.white.withValues(alpha: 0.07),
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Say something about yourself',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    'Keep it short. This is what nearby people will see.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.4),
                    ),
                  ),

                  const SizedBox(height: 10),

                  TextField(
                    controller: _bioController,
                    maxLength: 100,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Coffee, music & spontaneous conversations.',
                      filled: true,
                      fillColor: Colors.white.withValues(alpha: 0.07),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  SizedBox(
                    height: 54,
                    child: FilledButton(
                      onPressed: _canContinue ? _completeOnboarding : null,
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.lock_outline,
                        size: 15,
                        color: Colors.white38,
                      ),
                      const SizedBox(width: 7),
                      Flexible(
                        child: Text(
                          'Your exact distance is never shown.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
