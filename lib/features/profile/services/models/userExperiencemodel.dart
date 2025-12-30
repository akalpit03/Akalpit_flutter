class UserExperience {
  final String title;
  final String organization;
  final DateTime? startDate;
  final DateTime? endDate;
  final String description;

  UserExperience({
    required this.title,
    required this.organization,
    this.startDate,
    this.endDate,
    required this.description,
  });

  /// 📥 Creates an instance from JSON (Backend -> App)
  factory UserExperience.fromJson(Map<String, dynamic> json) => UserExperience(
        title: json['title'] ?? "",
        organization: json['organization'] ?? "",
        startDate: json['startDate'] != null 
            ? DateTime.tryParse(json['startDate']) 
            : null,
        endDate: json['endDate'] != null 
            ? DateTime.tryParse(json['endDate']) 
            : null,
        description: json['description'] ?? "",
      );

  /// 📦 Converts instance to JSON (App -> Backend/Storage)
  Map<String, dynamic> toJson() => {
        'title': title,
        'organization': organization,
        'startDate': startDate?.toIso8601String(),
        'endDate': endDate?.toIso8601String(),
        'description': description,
      };
}