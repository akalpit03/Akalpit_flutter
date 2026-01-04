class ClubMeta {
  final String id;
  final String name;

  const ClubMeta({
    required this.id,
    required this.name,
  });

  factory ClubMeta.fromJson(Map<String, dynamic> json) {
    return ClubMeta(
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
