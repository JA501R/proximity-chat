class UserProfile {
  final String id;
  final String displayName;
  final String bio;

  const UserProfile({
    required this.id,
    required this.displayName,
    required this.bio,
  });

  String get initials {
    final parts = displayName.trim().split(RegExp(r'\s+'));

    if (parts.isEmpty || parts.first.isEmpty) {
      return '?';
    }

    if (parts.length == 1) {
      return parts.first[0].toUpperCase();
    }

    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }
}
