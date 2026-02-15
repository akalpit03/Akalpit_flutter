import './requester.dart';
class IncomingRequest {
  final String id;
  final Requester requester;
  final String recipient;
  final String status;
  final String actionBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  IncomingRequest({
    required this.id,
    required this.requester,
    required this.recipient,
    required this.status,
    required this.actionBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory IncomingRequest.fromJson(Map<String, dynamic> json) {
    return IncomingRequest(
      id: json['_id'] ?? '',
      requester: Requester.fromJson(json['requester'] ?? {}),
      recipient: json['recipient'] ?? '',
      status: json['status'] ?? '',
      actionBy: json['actionBy'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'requester': requester.toJson(),
      'recipient': recipient,
      'status': status,
      'actionBy': actionBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
