import 'package:akalpit/features/auth/services/auth_service.dart';
import 'package:akalpit/features/profile/services/profileServices.dart';
import 'package:akalpit/features/search/services/searchService.dart';

import 'api_client.dart';

class ApiGateway {
  final AuthService authService;
  final ProfileSearchService profileSearchService;
  final ProfileService profileService;

  ApiGateway._({
    required this.authService,
    required this.profileSearchService,
    required this.profileService,
  });

  factory ApiGateway.create() {
    final client = ApiClient();
    return ApiGateway._(
        authService: AuthService(client),
        profileSearchService: ProfileSearchService(client),
        profileService: ProfileService(client));
  }
}
