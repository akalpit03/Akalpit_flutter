class TableBlockModel {
  final List<String>? headers;
  final List<List<String>> rows;
  final int order;

  TableBlockModel({
    this.headers,
    required this.rows,
    required this.order,
  });

  factory TableBlockModel.fromMap(Map<String, dynamic> map) {
    final rows = (map['rows'] as List? ?? [])
        .map((r) => (r as List).map((cell) => cell.toString()).toList())
        .toList();

    final headers = (map['headers'] as List?)?.map((h) => h.toString()).toList();

    return TableBlockModel(
      headers: headers,
      rows: rows,
      order: map['order'] ?? 0,
    );
  }
}
