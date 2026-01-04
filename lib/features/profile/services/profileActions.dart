 
import 'package:akalpit/features/profile/services/models/userProfileModel.dart';
 

/// 🔍 Get public profile by userId
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

 

class GetMyProfileAction {}

class GetMyProfileSuccessAction {
  final UserProfileModel profile;
  GetMyProfileSuccessAction(this.profile);
}

class GetMyProfileFailureAction {
  final String error;
  GetMyProfileFailureAction(this.error);
}
 

class CreateProfileAction {
  final Map<String, dynamic> profileData;
  CreateProfileAction(this.profileData);
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
  UpdateProfileAction(this.profileData);
}

class UpdateProfileSuccessAction {
  final UserProfileModel profile;
  UpdateProfileSuccessAction(this.profile);
}

class UpdateProfileFailureAction {
  final String error;
  UpdateProfileFailureAction(this.error);
}
