import './request.dart';
class IncomingRequestResponse {
  final int statusCode;
  final List<IncomingRequest> data;
  final String message;
  final bool success;

  IncomingRequestResponse({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory IncomingRequestResponse.fromJson(Map<String, dynamic> json) {
    return IncomingRequestResponse(
      statusCode: json['statusCode'] ?? 0,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => IncomingRequest.fromJson(e))
              .toList() ??
          [],
      message: json['message'] ?? '',
      success: json['success'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'data': data.map((e) => e.toJson()).toList(),
      'message': message,
      'success': success,
    };
  }
}
