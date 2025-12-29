import 'package:akalpit/features/search/services/searchProfileState.dart';

import '../../features/auth/services/auth_state.dart';

import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  final AuthState authState;
  final ProfileSearchState profileSearchState;

  const AppState({
    required this.authState,
     required this.profileSearchState,
  });

  factory AppState.initial() => AppState(
        authState: AuthState.initial(),
        profileSearchState: ProfileSearchState.initial()
      );

  AppState copyWith({
    AuthState? authState,
  }) {
    return AppState(
      authState: authState ?? this.authState,
      profileSearchState: profileSearchState ?? this.profileSearchState,
    );
  }

  Map<String, dynamic> toJson() => {
        'authState': authState.toJson(),
        'profileSearchState': profileSearchState.toJson(),
      };

  static AppState fromJson(dynamic json) {
    if (json == null) return AppState.initial();

    return AppState(
      authState: AuthState.fromJson(json['authState']),
      profileSearchState: ProfileSearchState.fromJson(json['profileSearchState']),
    );
  }

  @override
  List<Object?> get props => [
        authState,
        profileSearchState
      ];
}
