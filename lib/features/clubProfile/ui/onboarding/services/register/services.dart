 
import 'package:akalpit/core/api/api_client.dart';
import 'package:akalpit/core/api/api_endpoints.dart';

class ClubService {
  final ApiClient client;

  ClubService(this.client);

  /// Fetch club details by clubId
  // Future<Map<String, dynamic>> fetchClubDetails({
  //   required String clubId,
  // }) async {
  //   // final response = await client.get(
  //     // ApiEndpoints.getClubDetails(clubId: clubId),
  //   // );

  //   final body = response.data;

  //   if (body is Map<String, dynamic>) {
  //     return {
  //       "ownerId": body["data"]?["ownerId"],
  //       "clubId": body["data"]?["clubId"],
  //       "clubName": body["data"]?["clubName"],
  //       "image": body["data"]?["image"],
  //       "about": body["data"]?["about"],
  //       "categories": body["data"]?["categories"] ?? [],
  //       "councilId": body["data"]?["councilId"],
  //       "institutionId": body["data"]?["institutionId"],
  //       "admins": body["data"]?["admins"] ?? [],
  //       "members": body["data"]?["members"] ?? [],
  //       "privacy": body["data"]?["privacy"],
  //       "status": body["data"]?["status"],
  //       "membersCount": body["data"]?["membersCount"] ?? 0,
  //       "postsCount": body["data"]?["postsCount"] ?? 0,
  //       "createdAt": body["data"]?["createdAt"],
  //       "updatedAt": body["data"]?["updatedAt"],
  //     };
  //   }

  //   throw Exception("Unexpected club details response: $body");
  // }
}
