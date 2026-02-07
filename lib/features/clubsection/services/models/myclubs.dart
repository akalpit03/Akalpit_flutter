class MyClub {
  final String id;
  final String clubName;
  final String? clubImage;
  final String myRole;

  MyClub({
    required this.id,
    required this.clubName,
    required this.clubImage,
    required this.myRole,
  });

  factory MyClub.fromJson(Map<String, dynamic> json) {
    return MyClub(
      id: json["_id"] ?? "",
      clubName: json["clubName"] ?? "",
      clubImage: json["clubImage"] ?? "",
      myRole: json["myRole"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "clubName": clubName,
      "clubImage": clubImage,
      "myRole": myRole,
    };
  }
}