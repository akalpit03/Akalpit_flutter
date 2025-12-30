// features/profile_search/services/profile_search_service.dart

import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_endpoints.dart';

class ProfileSearchService {
  final ApiClient client;

  ProfileSearchService(this.client);

  Future<Map<String, dynamic>> searchProfiles({
    required String query,
    int page = 1,
  }) async {
    final response = await client.get(
      ApiEndpoints.searchProfiles(query: query, page: page),
    );

    final body = response.data;

    if (body is Map<String, dynamic>) {
      return {
        "success": body["success"] ?? false,
        "results": body["data"]?["results"] ?? [],
        "pagination": body["data"]?["pagination"] ?? {},
      };
    }

    throw Exception("Unexpected profile search response: $body");
  }

  Future<Map<String, dynamic>> checkclubAvailability({
    required String clubId,
  }) async {
    print(  'ProfileSearchService: Checking availability for Club ID: $clubId');
    final response =
        await client.get(ApiEndpoints.checkclubAvailability(clubId));

    final body = response.data;

    if (body is Map<String, dynamic>) {
      return {
        "available": body["available"] ?? false,
      };
    }

    throw Exception("Unexpected club availability response: $body");
  }
  Future<Map<String, dynamic>> searchClubs({
    required String query,
    int page = 1,
  }) async {
    final response = await client.get(
      ApiEndpoints.searchClubs(query: query, page: page),
    );

    final body = response.data;

    // Based on your JSON: { "data": [...], "meta": {...} }
    if (body is Map<String, dynamic>) {
      return {
        "results": body["data"] ?? [],
        "pagination": body["meta"] ?? {},
      };
    }

    throw Exception("Unexpected club search response: $body");
  }
}
