import 'dart:io';

import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/clubProfile/services/clubactions/actions.dart';
import 'package:akalpit/features/clubProfile/services/clubactions/state.dart';
import 'package:akalpit/features/clubProfile/services/models/post_data.dart';
import 'package:akalpit/features/clubProfile/services/states/clubstate.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
class ClubViewModel {
  /// ====== STATE ======
  final bool isLoading;
  final Club? club;
  final String? error;
  final String? selectedImagePath;

  final List<ClubPost> posts;
  final bool isPostsLoading;
  final bool isPostCreating;

  /// ====== ACTIONS ======
  final VoidCallback clearError;
  final void Function(String clubId) getClub;
  final void Function(String imagePath) selectImagePath;
  final VoidCallback removeSelectedImage;
  final void Function(Map<String, dynamic> clubData) submitCreateClub;

  final void Function(String clubId, String date) fetchPostsByDate;
  final void Function(Map<String, dynamic> postData) createPost;

  ClubViewModel({
    required this.isLoading,
    required this.club,
    required this.error,
    required this.selectedImagePath,
    required this.posts,
    required this.isPostsLoading,
    required this.isPostCreating,
    required this.clearError,
    required this.getClub,
    required this.selectImagePath,
    required this.removeSelectedImage,
    required this.submitCreateClub,
    required this.fetchPostsByDate,
    required this.createPost,
  });

  File? get selectedImage =>
      selectedImagePath != null ? File(selectedImagePath!) : null;

  static ClubViewModel fromStore(Store<AppState> store) {
    final ClubState state = store.state.clubState;

    return ClubViewModel(
      /// ====== STATE ======
      isLoading: state.isLoading,
      club: state.club,
      error: state.error,
      selectedImagePath: state.selectedImagePath,
      posts: state.posts,
      isPostsLoading: state.isPostsLoading,
      isPostCreating: state.isPostCreating,

      /// ====== ACTIONS ======
      clearError: () {},

      getClub: (String clubId) {
        store.dispatch(GetClubAction(clubId));
      },

      selectImagePath: (String path) {
        store.dispatch(SelectClubImageAction(path));
      },

      removeSelectedImage: () {
        store.dispatch(RemoveClubImageAction());
      },

      submitCreateClub: (Map<String, dynamic> clubData) {
        store.dispatch(SubmitCreateClubAction(clubData));
      },

      fetchPostsByDate: (String clubId, String date) {
        store.dispatch(
          FetchClubPostsByDateAction(
            clubId: clubId,
            date: date,
          ),
        );
      },

      createPost: (Map<String, dynamic> postData) {
        store.dispatch(
          CreateClubPostAction(postData),
        );
      },
    );
  }
}
