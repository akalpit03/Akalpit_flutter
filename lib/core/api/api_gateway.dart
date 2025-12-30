import 'package:akalpit/features/auth/services/auth_service.dart';
import 'package:akalpit/features/search/services/searchService.dart';

import 'api_client.dart';

class ApiGateway {
  final AuthService authService;
  final ProfileSearchService profileSearchService;
 

  ApiGateway._({
    required this.authService,
    required this.profileSearchService,
 
  });

  factory ApiGateway.create() {
    final client = ApiClient(); // internally create client
    return ApiGateway._(
      authService: AuthService(client),
      profileSearchService: ProfileSearchService(client),
 
    );
  }
}
