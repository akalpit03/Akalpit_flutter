 
import 'package:akalpit/core/api/api_client.dart';
import 'package:akalpit/core/api/api_endpoints.dart';
import 'package:akalpit/features/posts/story/redux/story_model.dart';

class StoryService {
  final ApiClient client;

  StoryService(this.client);

  Future<StoryResponseModel> fetchStoryById(String storyId) async {
    try {
      final url = ApiEndpoints.getStoryByStoryId(storyId);

      final response = await client.get(url);
      final body = response.data as Map<String, dynamic>;

      if (body['data'] == null) {
        throw Exception("Missing 'data' field from backend.");
      }

      final responseModel = StoryResponseModel.fromJson(body['data']);
      return responseModel;
    } catch (e) {
      throw Exception("Failed to fetch story: $e");
    }
  }
}
