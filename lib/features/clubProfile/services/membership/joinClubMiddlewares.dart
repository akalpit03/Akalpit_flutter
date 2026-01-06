import 'package:akalpit/core/api/api_gateway.dart';
import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/clubProfile/services/membership/joinClubActions.dart';

import 'package:redux/redux.dart';

List<Middleware<AppState>> clubMembershipMiddleware(
  ApiGateway apiGateway,
) {
  return [
    /// Member actions
    TypedMiddleware<AppState, JoinClubAction>(
      _handleJoinClub(apiGateway),
    ),
    TypedMiddleware<AppState, RequestToJoinClubAction>(
      _handleRequestToJoinClub(apiGateway),
    ),
    TypedMiddleware<AppState, LeaveClubAction>(
      _handleLeaveClub(apiGateway),
    ),

    /// Join request actions
    TypedMiddleware<AppState, AcceptJoinRequestAction>(
      _handleAcceptJoinRequest(apiGateway),
    ),
    TypedMiddleware<AppState, RejectJoinRequestAction>(
      _handleRejectJoinRequest(apiGateway),
    ),

    /// Admin / role actions
    TypedMiddleware<AppState, PromoteToAdminAction>(
      _handlePromoteToAdmin(apiGateway),
    ),
    TypedMiddleware<AppState, RemoveAdminAction>(
      _handleRemoveAdmin(apiGateway),
    ),
    TypedMiddleware<AppState, RemoveMemberAction>(
      _handleRemoveMember(apiGateway),
    ),

    /// Fetch actions
    TypedMiddleware<AppState, GetClubMembersAction>(
      _handleGetClubMembers(apiGateway),
    ),
    TypedMiddleware<AppState, GetPendingJoinRequestsAction>(
      _handleGetPendingJoinRequests(apiGateway),
    ),
    TypedMiddleware<AppState, GetClubMemberCountAction>(
      _handleGetClubMemberCount(apiGateway),
    ),
    TypedMiddleware<AppState, GetMyRoleInClubAction>(
      _handleGetMyRoleInClub(apiGateway),
    ),
    // TypedMiddleware<AppState, GetMyClubsAction>(
    //   _handleGetMyClubs(apiGateway),
    // ),
  ];
}

Middleware<AppState> _handleJoinClub(ApiGateway apiGateway) {
  return (store, action, next) async {
    next(action);

    try {
      await apiGateway.clubMembershipService.joinClub(action.clubId);
      store.dispatch(JoinClubSuccessAction(action.clubId));
    } catch (e) {
      store.dispatch(ClubMembershipFailureAction(e.toString()));
    }
  };
}

Middleware<AppState> _handleRequestToJoinClub(ApiGateway apiGateway) {
  return (store, action, next) async {
    if (action is RequestToJoinClubAction) {
      next(action);

      try {
        print("Middleware: Requesting to join club ${action.clubId}");
        await apiGateway.clubMembershipService.requestToJoinClub(action.clubId);
        store.dispatch(RequestToJoinClubSuccessAction(action.clubId));
      } catch (e) {
        store.dispatch(ClubMembershipFailureAction(e.toString()));
      }
    } else {
      next(action);
    }
    return;
  };
}

Middleware<AppState> _handleLeaveClub(ApiGateway apiGateway) {
  return (store, action, next) async {
    next(action);

    try {
      await apiGateway.clubMembershipService.leaveClub(action.clubId);
      store.dispatch(LeaveClubSuccessAction(action.clubId));
    } catch (e) {
      store.dispatch(ClubMembershipFailureAction(e.toString()));
    }
  };
}

Middleware<AppState> _handleAcceptJoinRequest(ApiGateway apiGateway) {
  return (store, action, next) async {
    if (action is AcceptJoinRequestAction) {
      next(action);

      try {
        await apiGateway.clubMembershipService
            .acceptJoinRequest(action.membershipId);
        store.dispatch(
          AcceptJoinRequestSuccessAction(action.membershipId),
        );
      } catch (e) {
        store.dispatch(ClubMembershipFailureAction(e.toString()));
      }
    } else {
      next(action);
    }
  };
}

Middleware<AppState> _handleRejectJoinRequest(ApiGateway apiGateway) {
  return (store, action, next) async {
    next(action);

    try {
      await apiGateway.clubMembershipService
          .rejectJoinRequest(action.membershipId);
      store.dispatch(
        RejectJoinRequestSuccessAction(action.membershipId),
      );
    } catch (e) {
      store.dispatch(ClubMembershipFailureAction(e.toString()));
    }
  };
}

Middleware<AppState> _handlePromoteToAdmin(ApiGateway apiGateway) {
  return (store, action, next) async {
    next(action);

    try {
      await apiGateway.clubMembershipService
          .promoteToAdmin(action.membershipId);
      store.dispatch(
        PromoteToAdminSuccessAction(action.membershipId),
      );
    } catch (e) {
      store.dispatch(ClubMembershipFailureAction(e.toString()));
    }
  };
}

Middleware<AppState> _handleRemoveAdmin(ApiGateway apiGateway) {
  return (store, action, next) async {
    next(action);

    try {
      await apiGateway.clubMembershipService.removeAdmin(action.membershipId);
      store.dispatch(
        RemoveAdminSuccessAction(action.membershipId),
      );
    } catch (e) {
      store.dispatch(ClubMembershipFailureAction(e.toString()));
    }
  };
}

Middleware<AppState> _handleRemoveMember(ApiGateway apiGateway) {
  return (store, action, next) async {
    next(action);

    try {
      await apiGateway.clubMembershipService.removeMember(action.membershipId);
      store.dispatch(
        RemoveMemberSuccessAction(action.membershipId),
      );
    } catch (e) {
      store.dispatch(ClubMembershipFailureAction(e.toString()));
    }
  };
}

Middleware<AppState> _handleGetClubMembers(ApiGateway apiGateway) {
  return (store, action, next) async {
    next(action);

    try {
      final members =
          await apiGateway.clubMembershipService.getClubMembers(action.clubId);

      store.dispatch(
        GetClubMembersSuccessAction(action.clubId, members),
      );
    } catch (e) {
      store.dispatch(ClubMembershipFailureAction(e.toString()));
    }
  };
}

Middleware<AppState> _handleGetPendingJoinRequests(
  ApiGateway apiGateway,
) {
  return (store, action, next) async {
    if (action is GetPendingJoinRequestsAction) {
      next(action);

      try {
        final requests = await apiGateway.clubMembershipService
            .getPendingJoinRequests(action.clubId);

        store.dispatch(
          GetPendingJoinRequestsSuccessAction(
            action.clubId,
            requests,
          ),
        );
      } catch (e) {
        store.dispatch(ClubMembershipFailureAction(e.toString()));
      }
    } else {
      next(action);
    }
  };
}

Middleware<AppState> _handleGetClubMemberCount(
  ApiGateway apiGateway,
) {
  return (store, action, next) async {
    next(action);

    try {
      final count = await apiGateway.clubMembershipService
          .getClubMemberCount(action.clubId);

      store.dispatch(
        GetClubMemberCountSuccessAction(action.clubId, count),
      );
    } catch (e) {
      store.dispatch(ClubMembershipFailureAction(e.toString()));
    }
  };
}

Middleware<AppState> _handleGetMyRoleInClub(
  ApiGateway apiGateway,
) {
  return (store, action, next) async {
    next(action);

    try {
      final role =
          await apiGateway.clubMembershipService.getMyRoleInClub(action.clubId);

      store.dispatch(
        GetMyRoleInClubSuccessAction(action.clubId, role),
      );
    } catch (e) {
      store.dispatch(ClubMembershipFailureAction(e.toString()));
    }
  };
}

// Middleware<AppState> _handleGetMyClubs(ApiGateway apiGateway) {
//   return (store, action, next) async {
//     next(action);

//     try {
//       final clubs = await apiGateway.clubMembershipService.fetchClubByUserId();

//       store.dispatch(GetMyClubsSuccessAction(clubs));
//     } catch (e) {
//       store.dispatch(ClubMembershipFailureAction(e.toString()));
//     }
//   };
// }
