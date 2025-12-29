import 'package:akalpit/features/search/services/searchProfileState.dart';
import 'package:akalpit/features/search/services/state/clubAvailability.dart';

import '../../features/auth/services/auth_state.dart';

import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  final AuthState authState;
  final ProfileSearchState profileSearchState;
  final ClubAvailabilityState clubAvailabilityState;

  const AppState({
    required this.authState,
    required this.profileSearchState,
    required this.clubAvailabilityState,
  });

  factory AppState.initial() => AppState(
        authState: AuthState.initial(),
        profileSearchState: ProfileSearchState.initial(),
        clubAvailabilityState: ClubAvailabilityState.initial(),
      );

  AppState copyWith({
    AuthState? authState,
  }) {
    return AppState(
      authState: authState ?? this.authState,
      profileSearchState: profileSearchState,
      clubAvailabilityState: clubAvailabilityState,
    );
  }

  Map<String, dynamic> toJson() => {
        'authState': authState.toJson(),
        'profileSearchState': profileSearchState.toJson(),
        'clubAvailabilityState': clubAvailabilityState.toJson(),
      };

  static AppState fromJson(dynamic json) {
    if (json == null) return AppState.initial();

    return AppState(
      authState: AuthState.fromJson(json['authState']),
      profileSearchState:
          ProfileSearchState.fromJson(json['profileSearchState']),
      clubAvailabilityState:
          ClubAvailabilityState.fromJson(json['clubAvailabilityState']),
    );
  }

  @override
  List<Object?> get props => [authState, profileSearchState, clubAvailabilityState];
}
