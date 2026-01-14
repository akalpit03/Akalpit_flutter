import 'package:akalpit/core/api/api_client.dart';
import 'package:akalpit/core/api/api_endpoints.dart';

class ActivityService {
  final ApiClient client;

  ActivityService(this.client);

  Future<Map<String, dynamic>> fetchSchedule(String eventId) async {
    try {
      final response = await client.get(ApiEndpoints.fetchSchedule(eventId));

      final body = response.data;
      print(body);
      if (body is Map<String, dynamic> &&
          (body["success"] == true || response.statusCode == 200)) {
        return {
          "success": true,
          "data": body["data"], // The list of days with metadata
        };
      }

      throw Exception(body["message"] ?? "Failed to fetch schedule");
    } catch (e) {
      rethrow;
    }
  }

  /// Fetch Single Activity Details (Includes scheduling, members, etc.)
  Future<Map<String, dynamic>> fetchActivityDetails(
      String eventId, String activityId) async {
    try {
      // Endpoint: /api/events/:eventId/days/:activityId
      final response =
          await client.get('/api/events/$eventId/days/$activityId');

      final body = response.data;

      if (body is Map<String, dynamic> &&
          (body["success"] == true || response.statusCode == 200)) {
        return {
          "success": true,
          "data": body["data"], // The single activity object
        };
      }

      throw Exception(body["message"] ?? "Failed to fetch activity details");
    } catch (e) {
      rethrow;
    }
  }

  /// Create a new activity for an event
  Future<Map<String, dynamic>> createActivity(
      String eventId, Map<String, dynamic> activityData) async {
    try {
      final response = await client.post(
        '/api/events/$eventId/days',
        data: activityData,
      );

      final body = response.data;

      if (body is Map<String, dynamic> &&
          (body["success"] == true || response.statusCode == 201)) {
        return {
          "success": true,
          "data": body["data"],
        };
      }

      throw Exception(body["message"] ?? "Failed to create activity");
    } catch (e) {
      rethrow;
    }
  }
}
