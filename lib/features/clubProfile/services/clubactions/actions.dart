import 'dart:io';

import 'package:akalpit/features/clubProfile/services/models/post_data.dart';
import 'package:akalpit/features/clubProfile/services/states/clubstate.dart';
 
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

 
class CreateClubPostAction {
  final Map<String, dynamic> postData;
  CreateClubPostAction(this.postData);
}

class CreateClubPostSuccessAction {
  final ClubPost post;
  CreateClubPostSuccessAction(this.post);
}

class CreateClubPostFailureAction {
  final String error;
  CreateClubPostFailureAction(this.error);
}

 
/// 🔹 Optional: reset create state (useful after success)
class ResetCreateClubAction {}
class FetchClubPostsByDateAction {
  final String clubId;
  final String date;

  FetchClubPostsByDateAction({
    required this.clubId,
    required this.date,
  });
}

class FetchClubPostsByDateSuccessAction {
  final List<ClubPost> posts;

  FetchClubPostsByDateSuccessAction(this.posts);
}

class FetchClubPostsByDateFailureAction {
  final String error;

  FetchClubPostsByDateFailureAction(this.error);
}
