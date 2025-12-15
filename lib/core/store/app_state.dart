import '../../features/auth/services/auth_state.dart';

import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  final AuthState authState;

  const AppState({
    required this.authState,
  });

  factory AppState.initial() => AppState(
        authState: AuthState.initial(),
      );

  AppState copyWith({
    AuthState? authState,
  }) {
    return AppState(
      authState: authState ?? this.authState,
    );
  }

  Map<String, dynamic> toJson() => {
        'authState': authState.toJson(),
      };

  static AppState fromJson(dynamic json) {
    if (json == null) return AppState.initial();

    return AppState(
      authState: AuthState.fromJson(json['authState']),
    );
  }

  @override
  List<Object?> get props => [
        authState,
      ];
}
