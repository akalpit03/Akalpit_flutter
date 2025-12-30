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

  const AppState({
    required this.authState,
    required this.profileSearchState,
    required this.clubAvailabilityState,
    required this.clubSearchState,    
  });

  factory AppState.initial() => AppState(
        authState: AuthState.initial(),
        profileSearchState: ProfileSearchState.initial(),
        clubAvailabilityState: ClubAvailabilityState.initial(),
        clubSearchState: ClubSearchState.initial(),
      );

  AppState copyWith({
    AuthState? authState,
  }) {
    return AppState(
      authState: authState ?? this.authState,
      profileSearchState: profileSearchState,
      clubAvailabilityState: clubAvailabilityState,
      clubSearchState: clubSearchState,
    );
  }

  Map<String, dynamic> toJson() => {
        'authState': authState.toJson(),
        'profileSearchState': profileSearchState.toJson(),
        'clubAvailabilityState': clubAvailabilityState.toJson(),
        'clubSearchState': clubSearchState.toJson(),
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
    );
  }

  @override
  List<Object?> get props => [authState, profileSearchState, clubAvailabilityState, clubSearchState];
}
