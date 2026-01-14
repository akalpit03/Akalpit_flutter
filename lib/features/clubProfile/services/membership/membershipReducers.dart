
import 'package:akalpit/features/clubProfile/services/membership/joinClubActions.dart';
import 'package:akalpit/features/clubProfile/services/membership/membershipState.dart';
import 'package:redux/redux.dart';

final clubMembershipReducer = combineReducers<ClubMembershipState>([
  /// Loading actions
  TypedReducer<ClubMembershipState, JoinClubAction>(_setLoading),
  TypedReducer<ClubMembershipState, RequestToJoinClubAction>(_setLoading),
  TypedReducer<ClubMembershipState, LeaveClubAction>(_setLoading),
  TypedReducer<ClubMembershipState, AcceptJoinRequestAction>(_setLoading),
  TypedReducer<ClubMembershipState, RejectJoinRequestAction>(_setLoading),
  TypedReducer<ClubMembershipState, PromoteToAdminAction>(_setLoading),
  TypedReducer<ClubMembershipState, RemoveAdminAction>(_setLoading),
  TypedReducer<ClubMembershipState, RemoveMemberAction>(_setLoading),
  TypedReducer<ClubMembershipState, GetClubMembersAction>(_setLoading),
 TypedReducer<ClubMembershipState, GetClubAdminsAction>(_setLoading),
  TypedReducer<ClubMembershipState, GetClubAdminsSuccessAction>(_getAdminsSuccess),
  TypedReducer<ClubMembershipState, GetPendingJoinRequestsAction>(_setLoading),
  TypedReducer<ClubMembershipState, GetClubMemberCountAction>(_setLoading),
  TypedReducer<ClubMembershipState, GetMyRoleInClubAction>(_setLoading),
  TypedReducer<ClubMembershipState, GetMyClubsAction>(_setLoading),

  /// Failure action
  TypedReducer<ClubMembershipState, ClubMembershipFailureAction>(_setError),

  /// Success actions
  TypedReducer<ClubMembershipState, JoinClubSuccessAction>(_joinClubSuccess),
  TypedReducer<ClubMembershipState, RequestToJoinClubSuccessAction>(_requestSuccess),
  TypedReducer<ClubMembershipState, LeaveClubSuccessAction>(_leaveClubSuccess),

  TypedReducer<ClubMembershipState, AcceptJoinRequestSuccessAction>(_acceptRequestSuccess),
  TypedReducer<ClubMembershipState, RejectJoinRequestSuccessAction>(_rejectRequestSuccess),

  TypedReducer<ClubMembershipState, PromoteToAdminSuccessAction>(_promoteAdminSuccess),
  TypedReducer<ClubMembershipState, RemoveAdminSuccessAction>(_removeAdminSuccess),
  TypedReducer<ClubMembershipState, RemoveMemberSuccessAction>(_removeMemberSuccess),

  TypedReducer<ClubMembershipState, GetClubMembersSuccessAction>(_getMembersSuccess),
  TypedReducer<ClubMembershipState, GetPendingJoinRequestsSuccessAction>(_getPendingRequestsSuccess),
  TypedReducer<ClubMembershipState, GetClubMemberCountSuccessAction>(_getMemberCountSuccess),
  TypedReducer<ClubMembershipState, GetMyRoleInClubSuccessAction>(_getMyRoleSuccess),
  TypedReducer<ClubMembershipState, GetMyClubsSuccessAction>(_getMyClubsSuccess),
]);

/// =====================
/// REDUCER HELPERS
/// =====================

ClubMembershipState _setLoading(ClubMembershipState state, dynamic action) {
  return state.copyWith(isLoading: true, error: null);
}

ClubMembershipState _setError(ClubMembershipState state, ClubMembershipFailureAction action) {
  return state.copyWith(isLoading: false, error: action.error);
}

/// =====================
/// MEMBER ACTIONS SUCCESS
/// =====================

ClubMembershipState _joinClubSuccess(ClubMembershipState state, JoinClubSuccessAction action) {
  return state.copyWith(isLoading: false, myRole: "member");
}

ClubMembershipState _requestSuccess(ClubMembershipState state, RequestToJoinClubSuccessAction action) {
  return state.copyWith(isLoading: false, myRole: "requested");
}

ClubMembershipState _leaveClubSuccess(ClubMembershipState state, LeaveClubSuccessAction action) {
  return state.copyWith(isLoading: false, myRole: "guest");
}

/// =====================
/// JOIN REQUEST SUCCESS
/// =====================

ClubMembershipState _acceptRequestSuccess(ClubMembershipState state, AcceptJoinRequestSuccessAction action) {
  // Remove from pendingRequests
  final updatedRequests = List<dynamic>.from(state.pendingRequests)
    ..removeWhere((r) => r["id"] == action.membershipId);
  return state.copyWith(isLoading: false, pendingRequests: updatedRequests);
}

ClubMembershipState _rejectRequestSuccess(ClubMembershipState state, RejectJoinRequestSuccessAction action) {
  final updatedRequests = List<dynamic>.from(state.pendingRequests)
    ..removeWhere((r) => r["id"] == action.membershipId);
  return state.copyWith(isLoading: false, pendingRequests: updatedRequests);
}

/// =====================
/// ADMIN / ROLE SUCCESS
/// =====================

ClubMembershipState _promoteAdminSuccess(ClubMembershipState state, PromoteToAdminSuccessAction action) {
  // Update myRole if needed
  return state.copyWith(isLoading: false);
}

ClubMembershipState _removeAdminSuccess(ClubMembershipState state, RemoveAdminSuccessAction action) {
  return state.copyWith(isLoading: false);
}

ClubMembershipState _removeMemberSuccess(ClubMembershipState state, RemoveMemberSuccessAction action) {
  // Remove from members list
  final updatedMembers = List<dynamic>.from(state.members)
    ..removeWhere((m) => m["id"] == action.membershipId);
  return state.copyWith(isLoading: false, members: updatedMembers);
}

/// =====================
/// FETCH ACTIONS SUCCESS
/// =====================
 
/// REDUCER HELPERS
/// =====================

ClubMembershipState _getAdminsSuccess(ClubMembershipState state, GetClubAdminsSuccessAction action) {
  return state.copyWith(
    isLoading: false,
    admins: action.admins,
    error: null,
  );
}
ClubMembershipState _getMembersSuccess(ClubMembershipState state, GetClubMembersSuccessAction action) {
  return state.copyWith(isLoading: false, members: action.members);
}

ClubMembershipState _getPendingRequestsSuccess(ClubMembershipState state, GetPendingJoinRequestsSuccessAction action) {
  return state.copyWith(isLoading: false, pendingRequests: action.requests);
}

ClubMembershipState _getMemberCountSuccess(ClubMembershipState state, GetClubMemberCountSuccessAction action) {
  return state.copyWith(isLoading: false, memberCount: action.count);
}

ClubMembershipState _getMyRoleSuccess(ClubMembershipState state, GetMyRoleInClubSuccessAction action) {
  return state.copyWith(isLoading: false, myRole: action.role);
}

ClubMembershipState _getMyClubsSuccess(ClubMembershipState state, GetMyClubsSuccessAction action) {
  return state.copyWith(isLoading: false, myClubs: action.clubs);
}
