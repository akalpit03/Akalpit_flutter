class ClubOwner {
  final String id;
  final String? name; // optional (future)

  const ClubOwner({
    required this.id,
    this.name,
  });

  factory ClubOwner.fromJson(Map<String, dynamic> json) {
    return ClubOwner(
      id: json["id"].toString(),
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
    };
  }
}
