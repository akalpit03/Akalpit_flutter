class MCQOptionModel {
  final String text;

  MCQOptionModel({required this.text});

  factory MCQOptionModel.fromMap(Map<String, dynamic> map) {
    return MCQOptionModel(
      text: map['text'] ?? '',
    );
  }
}

class MCQBlockModel {
  final String question;
  final List<MCQOptionModel> options;
  final int? correctOption;
  final String? explanation;
  final int order;

  MCQBlockModel({
    required this.question,
    required this.options,
    this.correctOption,
    this.explanation,
    required this.order,
  });

  factory MCQBlockModel.fromMap(Map<String, dynamic> map) {
    final options = (map['options'] as List? ?? [])
        .map((opt) => MCQOptionModel.fromMap(opt))
        .toList();
    return MCQBlockModel(
      question: map['question'] ?? '',
      options: options,
      correctOption: map['correctOption'],
      explanation: map['explanation'],
      order: map['order'] ?? 0,
    );
  }
}
