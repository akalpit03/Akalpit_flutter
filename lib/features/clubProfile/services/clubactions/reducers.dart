import 'package:akalpit/features/clubProfile/services/clubactions/actions.dart';
import 'package:akalpit/features/clubProfile/services/clubactions/state.dart';
import 'package:redux/redux.dart';

final clubReducer = combineReducers<ClubState>([
  /// ===== GET CLUB =====
  TypedReducer<ClubState, GetClubAction>(_getClub),
  TypedReducer<ClubState, GetClubSuccessAction>(_getClubSuccess),
  TypedReducer<ClubState, GetClubFailureAction>(_getClubFailure),

  /// ===== CREATE POST =====
  TypedReducer<ClubState, CreateClubPostAction>(_createPost),
  TypedReducer<ClubState, CreateClubPostSuccessAction>(_createPostSuccess),
  TypedReducer<ClubState, CreateClubPostFailureAction>(_createPostFailure),

  /// ===== FETCH POSTS =====
  TypedReducer<ClubState, FetchClubPostsByDateAction>(_fetchPostsByDate),
  TypedReducer<ClubState, FetchClubPostsByDateSuccessAction>(_fetchPostsByDateSuccess),
  TypedReducer<ClubState, FetchClubPostsByDateFailureAction>(_fetchPostsByDateFailure),

  /// ===== RESET =====
  TypedReducer<ClubState, ResetCreateClubAction>(_resetCreateClub),

  /// ===== IMAGE SELECT =====
  TypedReducer<ClubState, SelectClubImageAction>(_selectClubImage),
]);

/// ================= GET CLUB =================

ClubState _getClub(ClubState state, GetClubAction action) {
  return state.copyWith(
    isLoading: true,
    error: null,
  );
}

ClubState _getClubSuccess(ClubState state, GetClubSuccessAction action) {
  return state.copyWith(
    isLoading: false,
    club: action.club,
    error: null,
  );
}

ClubState _getClubFailure(ClubState state, GetClubFailureAction action) {
  return state.copyWith(
    isLoading: false,
    error: action.error,
  );
}

/// ================= CREATE POST =================

ClubState _createPost(
    ClubState state,
    CreateClubPostAction action) {
  return state.copyWith(
    isPostCreating: true,
    error: null,
  );
}

ClubState _createPostSuccess(
    ClubState state,
    CreateClubPostSuccessAction action) {
  return state.copyWith(
    isPostCreating: false,
    lastCreatedPost: action.post,

    /// Optional: auto-add to list at top
    posts: [action.post, ...state.posts],

    error: null,
  );
}

ClubState _createPostFailure(
    ClubState state,
    CreateClubPostFailureAction action) {
  return state.copyWith(
    isPostCreating: false,
    error: action.error,
  );
}

/// ================= FETCH POSTS =================

ClubState _fetchPostsByDate(ClubState state, FetchClubPostsByDateAction action) {
  return state.copyWith(isPostsLoading: true, error: null);
}

ClubState _fetchPostsByDateSuccess(
    ClubState state, FetchClubPostsByDateSuccessAction action) {
  return state.copyWith(
    isPostsLoading: false,
    posts: action.posts,
  );
}

ClubState _fetchPostsByDateFailure(
    ClubState state, FetchClubPostsByDateFailureAction action) {
  return state.copyWith(
    isPostsLoading: false,
    error: action.error,
  );
}

/// ================= RESET =================

ClubState _resetCreateClub(
    ClubState state,
    ResetCreateClubAction action) {
  return state.copyWith(
    isLoading: false,
    error: null,
  );
}

/// ================= IMAGE SELECT =================

ClubState _selectClubImage(
    ClubState state,
    SelectClubImageAction action) {
  return state.copyWith(
    selectedImagePath: action.imagePath,
  );
}
