import 'package:akalpit/features/Events/activities/services/state.dart';
import 'package:akalpit/features/clubProfile/services/clubactions/state.dart';
import 'package:akalpit/features/clubProfile/services/membership/membershipState.dart';
import 'package:akalpit/features/clubProfile/ui/mainPages/events/services/state.dart';
import 'package:akalpit/features/clubsection/services/clubscreenstate.dart';
import 'package:akalpit/features/misc/services/categories/categoriesState.dart';
import 'package:akalpit/features/posts/story/redux/story_state.dart';

import 'package:akalpit/features/profile/services/state/profileState.dart';
import 'package:akalpit/features/search/services/state/searchClubState.dart';
import 'package:akalpit/features/search/services/state/searchProfileState.dart';
import 'package:akalpit/features/search/services/state/clubAvailability.dart';

import '../../features/auth/services/auth_state.dart';

import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  final AuthState authState;
  final ProfileSearchState profileSearchState;
  final ClubAvailabilityState clubAvailabilityState;
  final ClubSearchState clubSearchState;
  final ProfileState profileState;
  final ClubState clubState;
  final ClubMembershipState clubMembershipState;
  final ClubScreenState clubScreenState;
  final ClubEventState clubEventState;
  final ActivityState activityState;
  final StoryState storyState;
  final CategoryState categoryState;

  const AppState({
    required this.authState,
    required this.profileSearchState,
    required this.clubAvailabilityState,
    required this.clubSearchState,
    required this.profileState,
    required this.clubState,
    required this.clubMembershipState,
    required this.clubScreenState,
    required this.clubEventState,
    required this.activityState,
    required this.storyState,
    required this.categoryState,
  });

  factory AppState.initial() => AppState(
        authState: AuthState.initial(),
        profileSearchState: ProfileSearchState.initial(),
        clubAvailabilityState: ClubAvailabilityState.initial(),
        clubSearchState: ClubSearchState.initial(),
        profileState: ProfileState.initial(),
        clubState: ClubState.initial(),
        clubMembershipState: ClubMembershipState.initial(),
        clubScreenState: ClubScreenState.initial(),
        clubEventState: ClubEventState.initial(),
        activityState: ActivityState.initial(),
        storyState: StoryState.initial(),
        categoryState: CategoryState.initial(),
      );

  AppState copyWith({
    AuthState? authState,
  }) {
    return AppState(
      authState: authState ?? this.authState,
      profileSearchState: profileSearchState,
      clubAvailabilityState: clubAvailabilityState,
      clubSearchState: clubSearchState,
      profileState: profileState,
      clubState: clubState,
      clubMembershipState: clubMembershipState,
      clubScreenState: clubScreenState,
      clubEventState: clubEventState,
      activityState: activityState,
      storyState: storyState,
      categoryState: categoryState,
    );
  }

  Map<String, dynamic> toJson() => {
        'authState': authState.toJson(),
        'profileSearchState': profileSearchState.toJson(),
        'clubAvailabilityState': clubAvailabilityState.toJson(),
        'clubSearchState': clubSearchState.toJson(),
        'profileState': profileState.toJson(),
        'clubState': clubState.toJson(),
        'clubMembershipState': clubMembershipState.toJson(),
        'clubScreenState': clubScreenState.toJson(),
        'clubEventState': clubEventState.toJson(),
        'activityState': activityState.toJson(),
        'storyState': storyState.toJson(),
        'categoryState': categoryState.toJson(),
      };

  static AppState fromJson(dynamic json) {
    if (json == null) return AppState.initial();

    return AppState(
      authState: AuthState.fromJson(json['authState']),
      profileSearchState:
          ProfileSearchState.fromJson(json['profileSearchState']),
      clubAvailabilityState:
          ClubAvailabilityState.fromJson(json['clubAvailabilityState']),
      clubSearchState: ClubSearchState.fromJson(json['clubSearchState']),
      profileState: ProfileState.fromJson(json['profileState']),
      clubState: ClubState.fromJson(json['clubState']),
      clubMembershipState:
          ClubMembershipState.fromJson(json['clubMembershipState']),
      clubScreenState: ClubScreenState.fromJson(json['clubScreenState']),
      clubEventState: ClubEventState.fromJson(json['clubEventState']),
      activityState: ActivityState.fromJson(json['activityState']),
      storyState: StoryState.fromJson(json['storyState']),
      categoryState: CategoryState.fromJson(json['categoryState']),
    );
  }

  @override
  List<Object?> get props => [
        authState,
        profileSearchState,
        clubAvailabilityState,
        clubSearchState,
        profileState,
        clubState,
        clubMembershipState,
        clubScreenState,
        clubEventState,
        activityState,
        storyState,
        categoryState,
      ];
}
