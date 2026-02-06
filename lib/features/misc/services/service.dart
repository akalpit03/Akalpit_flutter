import 'package:akalpit/core/api/api_client.dart';
import 'package:akalpit/core/api/api_endpoints.dart';

class MiscService {
  final ApiClient client;

  MiscService(this.client);

  /// Fetch Categories (Level 1 or by parentId)
  Future<Map<String, dynamic>> fetchCategories() async {
    try {
      final response = await client.get(
        ApiEndpoints.fetchCategories,  
      );

      final body = response.data;

      if (body is Map<String, dynamic> &&
          (body["success"] == true || response.statusCode == 200)) {
        return {
          "success": true,
          "data": body["data"], // List of categories
        };
      }

      throw Exception(body["message"] ?? "Failed to fetch categories");
    } catch (e) {
      rethrow;
    }
  }
}
