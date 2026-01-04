class ClubOwner {
  final String id;           // userId (ObjectId as string)
  final String displayName;  // snapshot name stored in club

  const ClubOwner({
    required this.id,
    required this.displayName,
  });

  factory ClubOwner.fromJson(Map<String, dynamic> json) {
    return ClubOwner(
      id: json["id"].toString(),
      displayName: json["displayName"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "displayName": displayName,
    };
  }
}
