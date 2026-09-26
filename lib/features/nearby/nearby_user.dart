class NearbyUser {
  final String id;
  final String name;
  final String bio;
  final bool isNearby;

  const NearbyUser({
    required this.id,
    required this.name,
    required this.bio,
    this.isNearby = true,
  });

  String get initials {
    final parts = name.trim().split(RegExp(r'\s+'));

    if (parts.isEmpty || parts.first.isEmpty) {
      return '?';
    }

    if (parts.length == 1) {
      return parts.first[0].toUpperCase();
    }

    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  NearbyUser copyWith({String? id, String? name, String? bio, bool? isNearby}) {
    return NearbyUser(
      id: id ?? this.id,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      isNearby: isNearby ?? this.isNearby,
    );
  }
}
