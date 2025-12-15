class TimelineEventModel {
  final String title;
  final String? description;
  final DateTime? date;
  final String? image;

  TimelineEventModel({
    required this.title,
    this.description,
    this.date,
    this.image,
  });

  factory TimelineEventModel.fromMap(Map<String, dynamic> map) {
    return TimelineEventModel(
      title: map['title'] ?? '',
      description: map['description'],
      date: map['date'] != null ? DateTime.tryParse(map['date']) : null,
      image: map['image'],
    );
  }
}

class TimelineBlockModel {
  final List<TimelineEventModel> events;
  final int order;

  TimelineBlockModel({required this.events, required this.order});

  factory TimelineBlockModel.fromMap(Map<String, dynamic> map) {
    final events = (map['events'] as List? ?? [])
        .map((e) => TimelineEventModel.fromMap(e))
        .toList();
    return TimelineBlockModel(
      events: events,
      order: map['order'] ?? 0,
    );
  }
}
