import 'package:akalpit/features/Events/activities/services/services.dart';
import 'package:akalpit/features/auth/services/auth_service.dart';
import 'package:akalpit/features/clubProfile/services/gettingClub/services.dart';
import 'package:akalpit/features/clubProfile/services/membership/joinClubServices.dart';
import 'package:akalpit/features/clubProfile/ui/mainPages/events/services/services.dart';
import 'package:akalpit/features/clubsection/services/services.dart';
import 'package:akalpit/features/misc/services/service.dart';
import 'package:akalpit/features/posts/story/redux/story_services.dart';

import 'package:akalpit/features/profile/services/profileServices.dart';
import 'package:akalpit/features/search/services/searchService.dart';

import 'api_client.dart';

class ApiGateway {
  final AuthService authService;
  final ProfileSearchService profileSearchService;
  final ProfileService profileService;
  final ClubService clubService;
  final ClubMembershipService clubMembershipService;
  final EventService eventService;
  final ActivityService activityService;
  final StoryService storyService;
  final MiscService miscService;
  final ClubSectionService clubSectionService;

  ApiGateway._({
    required this.authService,
    required this.profileSearchService,
    required this.profileService,
    required this.clubService,
    required this.clubMembershipService,
    required this.eventService,
    required this.activityService,
    required this.storyService,
    required this.miscService,
    required this.clubSectionService,
  });

  factory ApiGateway.create() {
    final client = ApiClient();
    return ApiGateway._(
      authService: AuthService(client),
      profileSearchService: ProfileSearchService(client),
      profileService: ProfileService(client),
      clubService: ClubService(client),
      clubMembershipService: ClubMembershipService(client),
      eventService: EventService(client),
      activityService: ActivityService(client),
      storyService: StoryService(client),
      miscService: MiscService(client),
      clubSectionService: ClubSectionService(client),
    );
  }
}
