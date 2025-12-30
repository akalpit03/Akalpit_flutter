// features/profile/store/profile_actions.dart
import 'package:akalpit/features/profile/services/models/userProfileModel.dart';

// GET Profile
class GetMyProfileAction {}
class GetMyProfileSuccessAction {
  final UserProfileModel profile;
  GetMyProfileSuccessAction(this.profile);
}
class GetMyProfileFailureAction {
  final String error;
  GetMyProfileFailureAction(this.error);
}

// CREATE Profile
class CreateProfileAction {
  final Map<String, dynamic> profileData;
  CreateProfileAction(this.profileData);
}