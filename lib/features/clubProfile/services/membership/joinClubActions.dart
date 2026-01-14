/// =====================
/// COMMON FAILURE ACTION
/// =====================
class ClubMembershipFailureAction {
  final String error;
  ClubMembershipFailureAction(this.error);
}

/// =====================
/// JOIN / LEAVE ACTIONS
/// =====================

/// POST /:clubId/join
class JoinClubAction {
  final String clubId;
  JoinClubAction(this.clubId);
}

class JoinClubSuccessAction {
  final String clubId;
  JoinClubSuccessAction(this.clubId);
}

/// POST /:clubId/request
class RequestToJoinClubAction {
  final String clubId;
  RequestToJoinClubAction(this.clubId);
}

class RequestToJoinClubSuccessAction {
  final String clubId;
  RequestToJoinClubSuccessAction(this.clubId);
}

/// POST /:clubId/leave
class LeaveClubAction {
  final String clubId;
  LeaveClubAction(this.clubId);
}

class LeaveClubSuccessAction {
  final String clubId;
  LeaveClubSuccessAction(this.clubId);
}

/// =====================
/// JOIN REQUEST ACTIONS
/// =====================

/// POST /request/:membershipId/accept
class AcceptJoinRequestAction {
  final String membershipId;
  AcceptJoinRequestAction(this.membershipId);
}

class AcceptJoinRequestSuccessAction {
  final String membershipId;
  AcceptJoinRequestSuccessAction(this.membershipId);
}

/// POST /request/:membershipId/reject
class RejectJoinRequestAction {
  final String membershipId;
  RejectJoinRequestAction(this.membershipId);
}

class RejectJoinRequestSuccessAction {
  final String membershipId;
  RejectJoinRequestSuccessAction(this.membershipId);
}

/// =====================
/// ADMIN / ROLE ACTIONS
/// =====================

/// POST /member/:membershipId/promote
class PromoteToAdminAction {
  final String membershipId;
  PromoteToAdminAction(this.membershipId);
}

class PromoteToAdminSuccessAction {
  final String membershipId;
  PromoteToAdminSuccessAction(this.membershipId);
}

/// POST /admin/:membershipId/remove
class RemoveAdminAction {
  final String membershipId;
  RemoveAdminAction(this.membershipId);
}

class RemoveAdminSuccessAction {
  final String membershipId;
  RemoveAdminSuccessAction(this.membershipId);
}

/// POST /member/:membershipId/remove
class RemoveMemberAction {
  final String membershipId;
  RemoveMemberAction(this.membershipId);
}

class RemoveMemberSuccessAction {
  final String membershipId;
  RemoveMemberSuccessAction(this.membershipId);
}

/// =====================
/// FETCH ACTIONS
/// =====================

/// GET /:clubId/members
class GetClubMembersAction {
  final String clubId;
  GetClubMembersAction(this.clubId);
}

class GetClubMembersSuccessAction {
  final String clubId;
  final List<dynamic> members;
  GetClubMembersSuccessAction(this.clubId, this.members);
}
class GetClubAdminsAction {
  final String clubId;
  GetClubAdminsAction(this.clubId);
}

class GetClubAdminsSuccessAction {
  final String clubId;
  final List<dynamic> admins;
  GetClubAdminsSuccessAction(this.clubId, this.admins);
}
/// GET /:clubId/requests/pending
class GetPendingJoinRequestsAction {
  final String clubId;
  GetPendingJoinRequestsAction(this.clubId);
}

class GetPendingJoinRequestsSuccessAction {
  final String clubId;
  final List<dynamic> requests;
  GetPendingJoinRequestsSuccessAction(this.clubId, this.requests);
}

/// GET /:clubId/members/count
class GetClubMemberCountAction {
  final String clubId;
  GetClubMemberCountAction(this.clubId);
}

class GetClubMemberCountSuccessAction {
  final String clubId;
  final int count;
  GetClubMemberCountSuccessAction(this.clubId, this.count);
}

/// GET /:clubId/my-role
class GetMyRoleInClubAction {
  final String clubId;
  GetMyRoleInClubAction(this.clubId);
}

class GetMyRoleInClubSuccessAction {
  final String clubId;
  final String role;
  GetMyRoleInClubSuccessAction(this.clubId, this.role);
}

/// GET /my/clubs
class GetMyClubsAction {
  GetMyClubsAction();
}

class GetMyClubsSuccessAction {
  final List<dynamic> clubs;
  GetMyClubsSuccessAction(this.clubs);
}
