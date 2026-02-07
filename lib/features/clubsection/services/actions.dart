import 'package:akalpit/features/clubProfile/services/states/clubstate.dart';
import 'package:akalpit/features/clubsection/services/models/myclubs.dart';
 

/// 🔹 Trigger
class FetchMyClubByUserIdAction {}

/// 🔹 Success
class FetchMyClubByUserIdSuccessAction {
  final MyClub club;

  FetchMyClubByUserIdSuccessAction(this.club);
}

/// 🔹 Failure
class FetchMyClubByUserIdFailureAction {
  final String error;

  FetchMyClubByUserIdFailureAction(this.error);
}

/// 🆕 Register/Create a new club
class RegisterClubAction {
  final Club club;
  RegisterClubAction(this.club);
}

/// 🤝 Follow a club
class FollowClubAction {
  final String clubId;
  FollowClubAction(this.clubId);
}

/// 🚪 Leave a club (Unfollow)
class LeaveClubAction {
  final String clubId;
  LeaveClubAction(this.clubId);
}

/// 👑 Update Role (Member/Admin level)
class UpdateClubRoleAction {
  final String clubId;
  final String newRole; // e.g., 'admin', 'moderator', 'member'
  UpdateClubRoleAction(this.clubId, this.newRole);
}

/// 🎯 Set Active Club (When opening a club profile)
class SetActiveClubAction {
  final String? clubId;
  SetActiveClubAction(this.clubId);
}

/// 🔄 Loading State
class SetClubLoadingAction {
  final bool isLoading;
  SetClubLoadingAction(this.isLoading);
}

/// ===============================
/// 🆕 CREATE CLUB
/// ===============================

/// 🔹 Request
class CreateClubRequestAction {
  final Map<String, dynamic> data;
  CreateClubRequestAction(this.data);
}

/// 🔹 Success
class CreateClubSuccessAction {
  final Club club;
  CreateClubSuccessAction(this.club);
}

/// 🔹 Failure
class CreateClubFailureAction {
  final String error;
  CreateClubFailureAction(this.error);
}
class GetMyClubsRequestAction {}
class GetMyClubsSuccessAction {
  final Map<String, MyClub> owned;
  final Map<String, MyClub> following;

  GetMyClubsSuccessAction({
    required this.owned,
    required this.following,
  });
}
class GetMyClubsFailureAction {
  final String error;

  GetMyClubsFailureAction(this.error);
}
