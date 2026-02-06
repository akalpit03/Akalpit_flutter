import 'package:akalpit/features/misc/services/actions.dart';
import 'package:akalpit/features/misc/services/categories/categoriesState.dart';

CategoryState categoryReducer(CategoryState state, dynamic action) {
  if (action is FetchCategoriesRequest) {
    return state.copyWith(isLoading: true, errorMessage: null);
  }

  if (action is FetchCategoriesSuccess) {
    return state.copyWith(
      isLoading: false,
      categories: action.categories,
    );
  }

  if (action is FetchCategoriesFailure) {
    return state.copyWith(
      isLoading: false,
      errorMessage: action.error,
    );
  }

  if (action is SelectCategory) {
    return state.copyWith(
      selectedCategory: action.category,
    );
  }

  return state;
}
