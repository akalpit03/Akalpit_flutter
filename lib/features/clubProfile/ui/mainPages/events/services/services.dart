// features/events/services/event_service.dart

import 'package:akalpit/core/api/api_client.dart';
import 'package:akalpit/core/api/api_endpoints.dart';
 

class EventService {
  final ApiClient client;

  EventService(this.client);

  /// Create a new event
  Future<Map<String, dynamic>> createEvent(Map<String, dynamic> eventData) async {
    final response = await client.post(
      ApiEndpoints.createEvent,
      data: eventData,
    );

    final body = response.data;

    if (body is Map<String, dynamic> && (body["success"] == true || response.statusCode == 201)) {
      return {
        "success": true,
        "data": body["data"], // The created event object
      };
    }

    throw Exception(body["message"] ?? "Failed to create event");
  }

  /// Fetch upcoming events for a specific club
 
  Future<Map<String, dynamic>> getEvents(String clubId) async {
  try {
  final response = await client.get(
      ApiEndpoints.getEvents(clubId),
    );

  

    // If Dio/ApiClient already returns a Map
    if (response.data != null) {
      return response.data as Map<String, dynamic>;
    }
    
    throw Exception("Response data was null");
  } catch (e) {
 
    rethrow;  
  }
}
}