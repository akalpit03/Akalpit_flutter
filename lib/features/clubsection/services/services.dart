import 'package:akalpit/core/api/api_client.dart';
import 'package:akalpit/core/api/api_endpoints.dart';
import 'package:akalpit/features/clubProfile/services/states/clubs.dart';
 

class ClubSectionService {
  final ApiClient client;

  ClubSectionService(this.client);

  /// =========================================
  /// 🏠 Fetch My Club (Logged-in user)
  /// =========================================
Future<Club> createClub(Map<String, dynamic> clubData) async {
  final response = await client.post(
    ApiEndpoints.createClub,
    data: clubData,
  );

  final body = response.data;

  if (body is Map<String, dynamic> &&
      (body["success"] == true || response.statusCode == 200)) {
    return Club.fromJson(body["data"]);
  }

  throw Exception(body["message"] ?? "Failed to create club");
}


  // /// =========================================
  // /// 🔍 Search Clubs
  // /// =========================================
  // Future<Map<String, dynamic>> searchClubs({
  //   required String query,
  //   int page = 1,
  // }) async {
  //   final response = await client.get(
  //     ApiEndpoints.searchClubs(query: query, page: page),
  //   );

  //   final body = response.data;

  //   if (body is Map<String, dynamic> &&
  //       (body["success"] == true || response.statusCode == 200)) {
  //     return {
  //       "results": body["data"],
  //       "pagination": body["pagination"],
  //     };
  //   }

  //   throw Exception(body["message"] ?? "Failed to search clubs");
  // }

  // /// =========================================
  // /// 🤝 Follow Club
  // /// =========================================
  // Future<void> followClub(String clubId) async {
  //   final response = await client.post(
  //     ApiEndpoints.followClub(clubId),
  //   );

  //   final body = response.data;

  //   if (body is Map<String, dynamic> &&
  //       (body["success"] == true || response.statusCode == 200)) {
  //     return;
  //   }

  //   throw Exception(body["message"] ?? "Failed to follow club");
  // }

  // /// =========================================
  // /// 🚪 Leave Club
  // /// =========================================
  // Future<void> leaveClub(String clubId) async {
  //   final response = await client.post(
  //     ApiEndpoints.leaveClub(clubId),
  //   );

  //   final body = response.data;

  //   if (body is Map<String, dynamic> &&
  //       (body["success"] == true || response.statusCode == 200)) {
  //     return;
  //   }

  //   throw Exception(body["message"] ?? "Failed to leave club");
  // }

  /// =========================================
  /// 📋 Fetch Clubs I Follow
  /// =========================================
  // Future<List<Club>> fetchFollowingClubs() async {
  //   final response = await client.get(
  //     ApiEndpoints.fetchFollowingClubs,
  //   );

  //   final body = response.data;

  //   if (body is Map<String, dynamic> &&
  //       body["data"] is List) {
  //     return (body["data"] as List)
  //         .map((e) => Club.fromJson(e))
  //         .toList();
  //   }

  //   throw Exception(body["message"] ?? "Failed to fetch following clubs");
  // }
}
