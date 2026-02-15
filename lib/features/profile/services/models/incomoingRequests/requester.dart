class Requester {
  final String id;
  final String imageUrl;
  final String? username;

  Requester({
    required this.id,
    required this.imageUrl,
    this.username,
  });

  factory Requester.fromJson(Map<String, dynamic> json) {
    return Requester(
      id: json['_id'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'imageUrl': imageUrl,
      'username': username,
    };
  }
}
