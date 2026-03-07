// features/profile/services/profile_service.dart

import 'package:akalpit/core/api/api_endpoints.dart';
import 'package:dio/dio.dart';

import '../../../../core/api/api_client.dart';

import 'package:image_picker/image_picker.dart';

class ProfileService {
  final ApiClient client;

  ProfileService(this.client);

  Future<String> uploadProfileImage(XFile imageFile) async {
    final fileName = imageFile.name;
    final bytes = await imageFile.readAsBytes();

    final formData = FormData.fromMap({
      "image": MultipartFile.fromBytes(
        bytes,
        filename: fileName,
      ),
    });

    final response = await client.postFormData(
      ApiEndpoints.UploadUrl,
      formData: formData,
    );

    final body = response.data;

    // Check both 'url' and 'data' depending on API response format
    if (body is Map<String, dynamic>) {
      final url = body["url"] ?? body["data"];
      if (url != null) return url;
    }

    throw Exception("Image upload failed");
  }

  Future<Map<String, dynamic>?> getMyProfile() async {
    try {
      final response = await client.get(ApiEndpoints.myProfile());
      final body = response.data;

      if (body is Map<String, dynamic> && body["success"] == true) {
        return body;
      }
      return null;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return null; // Profile not created yet
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
  Future<Map<String, dynamic>> getIncomingRequests() async {
  final response =
      await client.get(ApiEndpoints.getIncomingRequests);

  final body = response.data;

  if (body is Map<String, dynamic> && body["success"] == true) {
    return {
      "success": true,
      "data": body["data"], // List of requests
    };
  }

  throw Exception(
    body is Map<String, dynamic>
        ? body["message"] ?? "Failed to fetch incoming requests"
        : "Unexpected response format",
  );
}

Future<Map<String, dynamic>> getPublicProfileByUserId(String userId) async {
  try {
    final response = await client.get(
      ApiEndpoints.getPublicUserProfile(userId),
    );

    if (response.data == null) {
      throw Exception("Empty server response");
    }

    final Map<String, dynamic> body =
        Map<String, dynamic>.from(response.data);

    if (body["success"] == true && body["data"] != null) {
      return Map<String, dynamic>.from(body["data"]);
    } else {
      throw Exception(body["message"] ?? "Failed to fetch public profile");
    }
  } on DioException catch (e) {
    final errorData = e.response?.data;

    if (errorData is Map<String, dynamic>) {
      throw Exception(errorData["message"] ?? "Failed to fetch public profile");
    }

    throw Exception("Something went wrong while fetching profile");
  }
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

  /// POST /friends/request/:requestId/accept
Future<void> acceptFriendRequest(String requestId) async {
  final response = await client.post(
    ApiEndpoints.acceptFriendRequest(requestId),
  );

  final body = response.data;

  if (body is Map<String, dynamic> && body["success"] == true) {
    return;
  }

  throw Exception(
    body is Map<String, dynamic>
        ? body["message"] ?? "Failed to accept friend request"
        : "Unexpected response format",
  );
}

/// POST /friends/request/:requestId/reject
Future<void> rejectFriendRequest(String requestId) async {
  final response = await client.post(
    ApiEndpoints.rejectFriendRequest(requestId),
  );

  final body = response.data;

  if (body is Map<String, dynamic> && body["success"] == true) {
    return;
  }

  throw Exception(
    body is Map<String, dynamic>
        ? body["message"] ?? "Failed to reject friend request"
        : "Unexpected response format",
  );
}
/// GET /friends/my
Future<Map<String, dynamic>> getMyFriends() async {
  final response = await client.get(
    ApiEndpoints.getMyFriends,
  );

  final body = response.data;

  if (body is Map<String, dynamic> && body["success"] == true) {
    return {
      "success": true,
      "data": body["data"], // List of friends
    };
  }

  throw Exception(
    body is Map<String, dynamic>
        ? body["message"] ?? "Failed to fetch friends list"
        : "Unexpected response format",
  );
}

Future<Map<String, dynamic>> updateMyProfile(Map<String, dynamic> updates) async {
  final response = await client.patch(
    ApiEndpoints.updateMyProfile(),
    data: updates,
  );

  final body = response.data;
  if (body is Map<String, dynamic> && body["success"] == true) {
    return {
      "success": true,
      "data": body["data"],
    };
  }

  throw Exception(body["message"] ?? "Failed to update profile");
}

}
