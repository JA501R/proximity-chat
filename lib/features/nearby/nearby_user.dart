class NearbyUser {
  final String id;
  final String name;
  final bool isNearby;

  const NearbyUser({
    required this.id,
    required this.name,
    this.isNearby = true,
  });

  NearbyUser copyWith({String? id, String? name, bool? isNearby}) {
    return NearbyUser(
      id: id ?? this.id,
      name: name ?? this.name,
      isNearby: isNearby ?? this.isNearby,
    );
  }
}
