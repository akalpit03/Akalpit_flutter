import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/clubProfile/services/membership/joinClubActions.dart';
import 'package:redux/redux.dart';

class ClubMembershipViewModel {
  final bool isLoading;
  final String? error;

  final List<dynamic> members;
  final List<dynamic> admins; // <--- Added for admins
  final List<dynamic> pendingRequests;
  final int memberCount;
  final String myRole;
  final List<dynamic> myClubs;

  final Function(String clubId) joinClub;
  final Function(String clubId) requestToJoinClub;
  final Function(String clubId) leaveClub;

  final Function(String membershipId) acceptJoinRequest;
  final Function(String membershipId) rejectJoinRequest;

  final Function(String membershipId) promoteToAdmin;
  final Function(String membershipId) removeAdmin;
  final Function(String membershipId) removeMember;

  final Function(String clubId) getClubMembers;
  final Function(String clubId) getClubAdmins; // <--- Added for admins
  final Function(String clubId) getPendingJoinRequests;
  final Function(String clubId) getClubMemberCount;
  final Function(String clubId) getMyRoleInClub;
  final Function() getMyClubs;

  ClubMembershipViewModel({
    required this.isLoading,
    required this.error,
    required this.members,
    required this.admins, // <--- Added
    required this.pendingRequests,
    required this.memberCount,
    required this.myRole,
    required this.myClubs,
    required this.joinClub,
    required this.requestToJoinClub,
    required this.leaveClub,
    required this.acceptJoinRequest,
    required this.rejectJoinRequest,
    required this.promoteToAdmin,
    required this.removeAdmin,
    required this.removeMember,
    required this.getClubMembers,
    required this.getClubAdmins, // <--- Added
    required this.getPendingJoinRequests,
    required this.getClubMemberCount,
    required this.getMyRoleInClub,
    required this.getMyClubs,
  });

  factory ClubMembershipViewModel.fromStore(Store<AppState> store) {
    final state = store.state.clubMembershipState;

    return ClubMembershipViewModel(
        isLoading: state.isLoading,
      error: state.error,
      members: state.members,
      pendingRequests: state.pendingRequests,
      memberCount: state.memberCount,
      myRole: state.myRole,
      myClubs: state.myClubs,
      admins: state.admins,
      /// MEMBER ACTIONS
      joinClub: (clubId) => store.dispatch(JoinClubAction(clubId)),
      requestToJoinClub: (clubId) => store.dispatch(RequestToJoinClubAction(clubId)),
      leaveClub: (clubId) => store.dispatch(LeaveClubAction(clubId)),

      /// JOIN REQUEST ACTIONS
      acceptJoinRequest: (membershipId) => store.dispatch(AcceptJoinRequestAction(membershipId)),
      rejectJoinRequest: (membershipId) => store.dispatch(RejectJoinRequestAction(membershipId)),

      /// ADMIN / ROLE ACTIONS
      promoteToAdmin: (membershipId) => store.dispatch(PromoteToAdminAction(membershipId)),
      removeAdmin: (membershipId) => store.dispatch(RemoveAdminAction(membershipId)),
      removeMember: (membershipId) => store.dispatch(RemoveMemberAction(membershipId)),

      /// FETCH ACTIONS
      getClubMembers: (clubId) => store.dispatch(GetClubMembersAction(clubId)),
      getClubAdmins: (clubId) => store.dispatch(GetClubAdminsAction(clubId)), // <--- Dispatch Action
      getPendingJoinRequests: (clubId) => store.dispatch(GetPendingJoinRequestsAction(clubId)),
      getClubMemberCount: (clubId) => store.dispatch(GetClubMemberCountAction(clubId)),
      getMyRoleInClub: (clubId) => store.dispatch(GetMyRoleInClubAction(clubId)),
      getMyClubs: () => store.dispatch(GetMyClubsAction()),
    );
  }
}