import 'dart:io';

import 'package:akalpit/features/clubProfile/services/states/clubs.dart';
 
class GetClubAction {
  final String clubId;
  GetClubAction(this.clubId);
}

class GetClubSuccessAction {
  final Club club;
  GetClubSuccessAction(this.club);
}

class GetClubFailureAction {
  final String error;
  GetClubFailureAction(this.error);
}

class SelectClubImageAction {
  final String imagePath; // store path, not File
  SelectClubImageAction(this.imagePath);
}

class RemoveClubImageAction {}
class SubmitCreateClubAction {
  final Map<String, dynamic> clubData;

  SubmitCreateClubAction(this.clubData);
}

 

 
/// 🔹 Optional: reset create state (useful after success)
class ResetCreateClubAction {}
