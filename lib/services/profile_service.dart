import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../features/profile/user_profile.dart';

class ProfileService {
  static const String _userIdKey = 'profile_user_id';
  static const String _displayNameKey = 'profile_display_name';
  static const String _bioKey = 'profile_bio';

  static const Uuid _uuid = Uuid();

  Future<UserProfile?> loadProfile() async {
    final preferences = await SharedPreferences.getInstance();

    var userId = preferences.getString(_userIdKey);
    final displayName = preferences.getString(_displayNameKey);
    final bio = preferences.getString(_bioKey);

    if (displayName == null || displayName.trim().isEmpty) {
      return null;
    }

    // Existing Glance profiles created before IDs were introduced
    // receive an ID automatically.
    if (userId == null || userId.isEmpty) {
      userId = _uuid.v4();

      await preferences.setString(_userIdKey, userId);
    }

    return UserProfile(id: userId, displayName: displayName, bio: bio ?? '');
  }

  Future<UserProfile> saveProfile(UserProfile profile) async {
    final preferences = await SharedPreferences.getInstance();

    var userId = profile.id;

    if (userId.isEmpty) {
      userId = _uuid.v4();
    }

    await preferences.setString(_userIdKey, userId);

    await preferences.setString(_displayNameKey, profile.displayName);

    await preferences.setString(_bioKey, profile.bio);

    return UserProfile(
      id: userId,
      displayName: profile.displayName,
      bio: profile.bio,
    );
  }

  Future<void> deleteProfile() async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.remove(_userIdKey);
    await preferences.remove(_displayNameKey);
    await preferences.remove(_bioKey);
  }
}
