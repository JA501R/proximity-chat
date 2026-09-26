import 'package:flutter/material.dart';

import '../chat/chat_screen.dart';
import '../profile/profile_screen.dart';
import '../profile/user_profile.dart';
import 'nearby_user.dart';

class NearbyScreen extends StatefulWidget {
  final UserProfile profile;
  final ValueChanged<UserProfile> onProfileUpdated;

  const NearbyScreen({
    super.key,
    required this.profile,
    required this.onProfileUpdated,
  });

  @override
  State<NearbyScreen> createState() => _NearbyScreenState();
}

class _NearbyScreenState extends State<NearbyScreen> {
  final List<NearbyUser> _users = [
    const NearbyUser(
      id: 'mock-user-alex',
      name: 'Alex',
      bio: 'Coffee, music & spontaneous conversations.',
    ),
    const NearbyUser(
      id: 'mock-user-sam',
      name: 'Sam',
      bio: 'Say hi 👋 I promise I don’t bite.',
    ),
    const NearbyUser(
      id: 'mock-user-robin',
      name: 'Robin',
      bio: 'Probably here for the same reason you are.',
    ),
  ];

  List<NearbyUser> get _nearbyUsers {
    return _users.where((user) => user.isNearby).toList();
  }

  Future<void> _openProfile() async {
    final updatedProfile = await Navigator.of(context).push<UserProfile>(
      MaterialPageRoute(
        builder: (context) => ProfileScreen(profile: widget.profile),
      ),
    );

    if (updatedProfile != null) {
      widget.onProfileUpdated(updatedProfile);
    }
  }

  void _openChat(NearbyUser user) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            ChatScreen(user: user, localProfile: widget.profile),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final nearbyUsers = _nearbyUsers;

    return Scaffold(
      backgroundColor: const Color(0xFF080A0D),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 16, 16),
              child: Row(
                children: [
                  const Spacer(),
                  const Text(
                    'Glance',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: _openProfile,
                    icon: const Icon(Icons.settings_outlined),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Icon(Icons.radar, size: 52, color: Color(0xFF4DA3FF)),
            const SizedBox(height: 16),
            Text(
              nearbyUsers.isEmpty
                  ? 'Looking around...'
                  : '${nearbyUsers.length} '
                        '${nearbyUsers.length == 1 ? 'person' : 'people'} nearby',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              'Only people close enough to connect are visible',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withValues(alpha: 0.5),
              ),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: nearbyUsers.isEmpty
                  ? _buildEmptyState()
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: nearbyUsers.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final user = nearbyUsers[index];

                        return _NearbyUserCard(
                          user: user,
                          onTap: () => _openChat(user),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.people_outline, size: 46, color: Colors.white24),
            const SizedBox(height: 16),
            const Text(
              'No one nearby',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              'When someone using Glance is nearby, '
              'they can appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white.withValues(alpha: 0.4)),
            ),
          ],
        ),
      ),
    );
  }
}

class _NearbyUserCard extends StatelessWidget {
  final NearbyUser user;
  final VoidCallback onTap;

  const _NearbyUserCard({required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF182230),
              ),
              child: Center(
                child: Text(
                  user.initials,
                  style: const TextStyle(
                    color: Color(0xFF4DA3FF),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.bio,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.45),
                    ),
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: Color(0xFF4DA3FF),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 7),
                      Text(
                        'Nearby',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white38),
          ],
        ),
      ),
    );
  }
}
