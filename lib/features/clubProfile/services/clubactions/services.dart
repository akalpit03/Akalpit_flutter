import 'dart:io';

import 'package:akalpit/core/api/api_endpoints.dart';
import 'package:akalpit/features/clubProfile/services/models/post_data.dart';
import 'package:akalpit/features/clubProfile/services/states/clubstate.dart';

import '../../../../core/api/api_client.dart';

import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;

class ClubService {
  final ApiClient client;

  ClubService(this.client);

  /// Fetch club details
  Future<Club> getClubDetails(String clubId) async {
    final response = await client.get(
      ApiEndpoints.getClubDetails(clubId),
    );

    final body = response.data;

    if (body is Map<String, dynamic>) {
      final clubJson = body["data"];
      return Club.fromJson(clubJson); // ✅ parse here
    }

    throw Exception("Failed to fetch club details");
  }

  Future<Map<String, dynamic>> createClub(
    Map<String, dynamic> clubData,
  ) async {
    final response = await client.post(
      ApiEndpoints.createClub,
      data: clubData,
    );

    final body = response.data;

    print("\n\n$body");

    if (body is Map<String, dynamic>) {
      return {
        "success": true,
        "data": body["data"], // Created club object
      };
    }

    throw Exception("Failed to create club");
  }

  Future<ClubPost> createClubPost(
    Map<String, dynamic> postData,
  ) async {
    final response = await client.post(
      ApiEndpoints.createClubPost,
      data: postData,
    );

    final body = response.data;

    if (body is Map<String, dynamic>) {
      final postJson = body["data"];
      return ClubPost.fromJson(postJson);
    }

    throw Exception("Failed to create post");
  }
Future<List<ClubPost>> fetchClubPostsByDate({
    required String clubId,
    required String date, // yyyy-MM-dd
  }) async {
    final response = await client.get(
      ApiEndpoints.fetchClubPostsByDate(clubId, date),
    );

    final body = response.data;

    if (body is Map<String, dynamic>) {
      final List<dynamic> postsJson = body["data"] ?? [];

      return postsJson.map((json) => ClubPost.fromJson(json)).toList();
    }

    throw Exception("Failed to fetch club posts");
  }

  Future<String> uploadClubImage(File imageFile) async {
    final fileName = path.basename(imageFile.path);

    final formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName,
      ),
    });

    final response = await client.postFormData(
      ApiEndpoints.UploadUrl,
      formData: formData,
    );

    final body = response.data;

    if (body is Map<String, dynamic> && body["url"] != null) {
      return body["url"];
    }

    throw Exception("Image upload failed");
  }
}
