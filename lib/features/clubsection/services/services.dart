import 'package:akalpit/core/api/api_client.dart';
import 'package:akalpit/core/api/api_endpoints.dart';
import 'package:akalpit/features/clubProfile/services/states/clubstate.dart';
import 'package:akalpit/features/clubsection/services/models/myclubs.dart';

class ClubSectionService {
  final ApiClient client;

  ClubSectionService(this.client);

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

  Future<List<MyClub>> getMyClubs() async {
    final response = await client.get(
      ApiEndpoints.getMyClubs,
    );

    final body = response.data;

    if (body is Map<String, dynamic> &&
        (body["success"] == true || response.statusCode == 200)) {
      final List<dynamic> dataList = body["data"] ?? [];

      return dataList.map((clubJson) => MyClub.fromJson(clubJson)).toList();
    }

    throw Exception(body["message"] ?? "Failed to fetch clubs");
  }
}
