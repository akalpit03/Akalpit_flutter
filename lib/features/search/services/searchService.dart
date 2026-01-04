// features/profile_search/services/profile_search_service.dart

import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_endpoints.dart';

class ProfileSearchService {
  final ApiClient client;

  ProfileSearchService(this.client);

  Future<Map<String, dynamic>> searchProfiles({
    required String query,
    int page = 1,
    int limit = 10,
  }) async {
    final response = await client.get(
      ApiEndpoints.searchProfiles(query: query, page: page ),
    );

    final body = response.data;

    if (body is Map<String, dynamic>) {
      final results = body["data"]?["results"] as List<dynamic>? ?? [];
      final pagination = body["data"]?["pagination"] as Map<String, dynamic>? ?? {};

      // Optionally, map results to typed model
      final profiles = results.map((e) => {
            "_id": e["_id"] ?? "",
            "displayName": e["displayName"] ?? "",
            "username": e["username"] ?? "",
            "imageUrl": e["imageUrl"] ?? "",
            "role": e["role"] ?? "",
            "createdAt": e["createdAt"] ?? "",
          }).toList();

      return {
        "success": body["success"] ?? false,
        "results": profiles,
        "pagination": {
          "total": pagination["total"] ?? 0,
          "page": pagination["page"] ?? 1,
          "limit": pagination["limit"] ?? 10,
          "totalPages": pagination["totalPages"] ?? 1,
          "hasNextPage": pagination["hasNextPage"] ?? false,
        },
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
