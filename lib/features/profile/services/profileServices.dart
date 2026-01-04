// features/profile/services/profile_service.dart

import 'package:akalpit/core/api/api_endpoints.dart';

import '../../../../core/api/api_client.dart';

class ProfileService {
  final ApiClient client;

  ProfileService(this.client);

  Future<Map<String, dynamic>> getMyProfile() async {
    // Note: Ensure ApiEndpoints.myProfile exists in your constants
    final response = await client.get(ApiEndpoints.myProfile());

    final body = response.data;

    if (body is Map<String, dynamic> && body["success"] == true) {
      return {
        "success": true,
        "data": body["data"], // This contains the actual profile object
      };
    }

    throw Exception(body["message"] ?? "Failed to fetch profile");
  }

  Future<Map<String, dynamic>> getPublicProfileByUserId(String userId) async {
  final response = await client.get(
    ApiEndpoints.getPublicUserProfile(userId),
  );

  final body = response.data;

  if (body is Map<String, dynamic> && body["success"] == true) {
    return {
      "success": true,
      "data": body["data"],
    };
  }

  throw Exception(body["message"] ?? "Failed to fetch public profile");
}

  Future<Map<String, dynamic>> createProfile(
      Map<String, dynamic> profileData) async {
    final response = await client.post(
      ApiEndpoints.createProfile,
      data: profileData,
    );

    final body = response.data;

    if (body is Map<String, dynamic> && body["success"] == true) {
      return {
        "success": true,
        "message": body["message"] ?? "Success",
        "data": body["data"], // The profile object returned after creation
      };
    }

    throw Exception(body["message"] ?? "Failed to save profile");
  }
}
