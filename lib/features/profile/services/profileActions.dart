import 'package:akalpit/features/profile/services/models/friends/friendmodel.dart';
import 'package:akalpit/features/profile/services/models/incomoingRequests/request.dart';
import 'package:akalpit/features/profile/services/models/userProfileModel.dart';
import 'package:image_picker/image_picker.dart';

/// 🔍 Request
class GetPublicProfileAction {
  final String userId;
  GetPublicProfileAction(this.userId);
}

/// ✅ Success
class GetPublicProfileSuccessAction {
  final UserProfileModel profile;
  GetPublicProfileSuccessAction(this.profile);
}

/// ❌ Failure
class GetPublicProfileFailureAction {
  final String error;
  GetPublicProfileFailureAction(this.error);
}

/// 🔹 1. Trigger Action (Start Loading)
class FetchIncomingRequestsAction {}

/// 🔹 2. Success Action
class FetchIncomingRequestsSuccessAction {
  final List<IncomingRequest> requests;
  FetchIncomingRequestsSuccessAction(this.requests);
}

/// 🔹 3. Failure Action
class FetchIncomingRequestsFailureAction {
  final String error;
  FetchIncomingRequestsFailureAction(this.error);
}

class GetMyProfileAction {}

class GetMyProfileSuccessAction {
  final UserProfileModel? profile;
  GetMyProfileSuccessAction(this.profile);
}

class GetMyProfileFailureAction {
  final String error;
  GetMyProfileFailureAction(this.error);
}

class CreateProfileAction {
  final Map<String, dynamic> profileData;
  final XFile? imageFile;
  CreateProfileAction(this.profileData, {this.imageFile});
}

class CreateProfileSuccessAction {
  final UserProfileModel profile;
  CreateProfileSuccessAction(this.profile);
}

class CreateProfileFailureAction {
  final String error;
  CreateProfileFailureAction(this.error);
}

class UpdateProfileAction {
  final Map<String, dynamic> profileData;
  final XFile? imageFile;
  UpdateProfileAction(this.profileData, {this.imageFile});
}

class UpdateProfileSuccessAction {
  final UserProfileModel profile;
  UpdateProfileSuccessAction(this.profile);
}

class UpdateProfileFailureAction {
  final String error;
  UpdateProfileFailureAction(this.error);
}
/// POST /friends/request/:requestId/accept
class AcceptFriendRequestAction {
  final String requestId;

  AcceptFriendRequestAction(this.requestId);
}

class AcceptFriendRequestSuccessAction {
  final String requestId;

  AcceptFriendRequestSuccessAction(this.requestId);
}
/// POST /friends/request/:requestId/reject
class RejectFriendRequestAction {
  final String requestId;

  RejectFriendRequestAction(this.requestId);
}

class RejectFriendRequestSuccessAction {
  final String requestId;

  RejectFriendRequestSuccessAction(this.requestId);
}
class FetchMyFriendsAction {}

class FetchMyFriendsSuccessAction {
  final List<FriendModel> friends; // later we’ll convert to FriendModel

  FetchMyFriendsSuccessAction(this.friends);
}

class FetchMyFriendsFailureAction {
  final String error;

  FetchMyFriendsFailureAction(this.error);
}
