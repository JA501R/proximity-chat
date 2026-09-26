import 'package:flutter/material.dart';

import '../../services/profile_service.dart';
import 'user_profile.dart';

class ProfileScreen extends StatefulWidget {
  final UserProfile profile;

  const ProfileScreen({super.key, required this.profile});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileService _profileService = ProfileService();

  late final TextEditingController _nameController;
  late final TextEditingController _bioController;

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.profile.displayName);

    _bioController = TextEditingController(text: widget.profile.bio);
  }

  Future<void> _saveProfile() async {
    final displayName = _nameController.text.trim();
    final bio = _bioController.text.trim();

    if (displayName.isEmpty || _isSaving) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final updatedProfile = UserProfile(
      id: widget.profile.id,
      displayName: displayName,
      bio: bio,
    );

    final savedProfile = await _profileService.saveProfile(updatedProfile);

    if (!mounted) {
      return;
    }

    Navigator.of(context).pop(savedProfile);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080A0D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF080A0D),
        title: const Text('Profile'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 88,
                  height: 88,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF182230),
                  ),
                  child: Center(
                    child: Text(
                      widget.profile.initials,
                      style: const TextStyle(
                        color: Color(0xFF4DA3FF),
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 36),

              const Text(
                'Display name',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: _nameController,
                maxLength: 30,
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
                'About you',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: _bioController,
                maxLength: 100,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Say something about yourself...',
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
                  onPressed: _isSaving ? null : _saveProfile,
                  child: _isSaving
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text(
                          'Save changes',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 28),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.shield_outlined,
                      size: 20,
                      color: Colors.white54,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Your exact distance is never shown to other Glance users.',
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.4,
                          color: Colors.white54,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
