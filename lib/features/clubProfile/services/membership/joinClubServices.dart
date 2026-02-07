import 'package:akalpit/core/api/api_client.dart';
import 'package:akalpit/core/api/api_endpoints.dart';
 
import 'package:akalpit/features/clubsection/services/models/myclubs.dart';

class ClubMembershipService {
  final ApiClient client;

  ClubMembershipService(this.client);

  /// =====================
  /// MEMBER ACTIONS
  /// =====================

  /// POST /:clubId/join
  Future<void> joinClub(String clubId) async {
    final response = await client.post(
      ApiEndpoints.joinClub(clubId),
    );

    if (response.data is Map<String, dynamic>) return;

    throw Exception("Failed to join club");
  }

  /// POST /:clubId/request
  Future<void> requestToJoinClub(String clubId) async {
    final response = await client.post(
      ApiEndpoints.requestToJoinClub(clubId),
    );

    if (response.data is Map<String, dynamic>) return;

    throw Exception("Failed to request club join");
  }

  /// POST /:clubId/leave
  Future<void> leaveClub(String clubId) async {
    final response = await client.post(
      ApiEndpoints.leaveClub(clubId),
    );

    if (response.data is Map<String, dynamic>) return;

    throw Exception("Failed to leave club");
  }

  /// =====================
  /// JOIN REQUEST ACTIONS
  /// =====================

  /// POST /request/:membershipId/accept
  Future<void> acceptJoinRequest(String membershipId) async {
    final response = await client.post(
      ApiEndpoints.acceptJoinRequest(membershipId),
    );

    if (response.data is Map<String, dynamic>) return;

    throw Exception("Failed to accept join request");
  }

  /// POST /request/:membershipId/reject
  Future<void> rejectJoinRequest(String membershipId) async {
    final response = await client.post(
      ApiEndpoints.rejectJoinRequest(membershipId),
    );

    if (response.data is Map<String, dynamic>) return;

    throw Exception("Failed to reject join request");
  }

  /// =====================
  /// ADMIN / ROLE ACTIONS
  /// =====================

  /// POST /member/:membershipId/promote
  Future<void> promoteToAdmin(String membershipId) async {
    final response = await client.post(
      ApiEndpoints.promoteToAdmin(membershipId),
    );

    if (response.data is Map<String, dynamic>) return;

    throw Exception("Failed to promote member to admin");
  }

  /// POST /admin/:membershipId/remove
  Future<void> removeAdmin(String membershipId) async {
    final response = await client.post(
      ApiEndpoints.removeAdmin(membershipId),
    );

    if (response.data is Map<String, dynamic>) return;

    throw Exception("Failed to remove admin");
  }

  /// POST /member/:membershipId/remove
  Future<void> removeMember(String membershipId) async {
    final response = await client.post(
      ApiEndpoints.removeMember(membershipId),
    );

    if (response.data is Map<String, dynamic>) return;

    throw Exception("Failed to remove member");
  }

  /// =====================
  /// FETCH ACTIONS
  /// =====================

  /// GET /:clubId/members
  Future<List<dynamic>> getClubMembers(String clubId) async {
    final response = await client.get(
      ApiEndpoints.getClubMembers(clubId),
    );

    final body = response.data;

    if (body is Map<String, dynamic>) {
      return body["data"] ?? [];
    }

    throw Exception("Failed to fetch club members");
  }
// In ApiEndpoints class


// In ClubMembershipService class
Future<List<dynamic>> getClubAdmins(String clubId) async {
  final response = await client.get(
    ApiEndpoints.getClubAdmins(clubId),
  );

  final body = response.data;

  if (body is Map<String, dynamic>) {
    // Note: Since admins aren't usually paginated, we just return the "data" array
    return body["data"] ?? [];
  }

  throw Exception("Failed to fetch club admins");
}
  /// GET /:clubId/requests/pending
  Future<List<dynamic>> getPendingJoinRequests(String clubId) async {
    final response = await client.get(
      ApiEndpoints.getPendingJoinRequests(clubId),
    );

    final body = response.data;

    if (body is Map<String, dynamic>) {
      return body["data"] ?? [];
    }

    throw Exception("Failed to fetch join requests");
  }

  /// GET /:clubId/members/count
  Future<int> getClubMemberCount(String clubId) async {
    final response = await client.get(
      ApiEndpoints.getClubMemberCount(clubId),
    );

    final body = response.data;

    if (body is Map<String, dynamic>) {
      return body["data"]?["count"] ?? 0;
    }

    throw Exception("Failed to fetch member count");
  }

  /// GET /:clubId/my-role
  Future<String> getMyRoleInClub(String clubId) async {
    final response = await client.get(
      ApiEndpoints.getMyRoleInClub(clubId),
    );

    final body = response.data;

    if (body is Map<String, dynamic>) {
      return body["data"]?["role"] ?? "guest";
    }

    throw Exception("Failed to fetch role");
  }

 
 
  /// ✅ Fetch club owned by logged-in user
  Future<MyClub?> fetchClubByUserId() async {
    final response = await client.get(
      ApiEndpoints.fetchClubByUserId,
    );

    final body = response.data;

    if (body != null &&
        body is Map<String, dynamic> &&
        body['data'] != null) {
      return MyClub.fromJson(body['data']);
    }

    return null; // user has no club
  
}

}
