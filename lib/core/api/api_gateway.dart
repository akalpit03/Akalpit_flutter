import 'package:akalpit/features/auth/services/auth_service.dart';
import 'package:akalpit/features/clubProfile/services/gettingClub/services.dart';
import 'package:akalpit/features/clubProfile/services/membership/joinClubServices.dart';
 
import 'package:akalpit/features/profile/services/profileServices.dart';
import 'package:akalpit/features/search/services/searchService.dart';

import 'api_client.dart';

class ApiGateway {
  final AuthService authService;
  final ProfileSearchService profileSearchService;
  final ProfileService profileService;
  final ClubService clubService;
  final ClubMembershipService clubMembershipService;

  ApiGateway._({
    required this.authService,
    required this.profileSearchService,
    required this.profileService,
    required this.clubService,
    required this.clubMembershipService,
  });

  factory ApiGateway.create() {
    final client = ApiClient();
    return ApiGateway._(
        authService: AuthService(client),
        profileSearchService: ProfileSearchService(client),
        profileService: ProfileService(client),
        clubService: ClubService(client),
          clubMembershipService: ClubMembershipService(client));
  }
}
