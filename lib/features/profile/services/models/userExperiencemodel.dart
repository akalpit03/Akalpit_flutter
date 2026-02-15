class ExperienceModel {
  final String id;
  final String title;
  final String organization;
  final DateTime? startDate;
  final DateTime? endDate;
  final String description;

  ExperienceModel({
    required this.id,
    required this.title,
    required this.organization,
    this.startDate,
    this.endDate,
    required this.description,
  });

  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      id: json['_id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      organization: json['organization']?.toString() ?? '',
      startDate: json['startDate'] != null
          ? DateTime.tryParse(json['startDate'])
          : null,
      endDate: json['endDate'] != null
          ? DateTime.tryParse(json['endDate'])
          : null,
      description: json['description']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "title": title,
      "organization": organization,
      "startDate": startDate?.toIso8601String(),
      "endDate": endDate?.toIso8601String(),
      "description": description,
    };
  }
}
