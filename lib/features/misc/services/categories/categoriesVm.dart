 
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/misc/services/actions.dart';
import 'package:akalpit/features/misc/services/categories/categoryModel.dart';
import 'package:redux/redux.dart';

class CategoryViewModel {
  final bool isLoading;
  final List<Category> categories;
  final Category? selectedCategory;
  final String? errorMessage;

  final VoidCallback fetchCategories;
  final Function(Category) selectCategory;

  CategoryViewModel({
    required this.isLoading,
    required this.categories,
    required this.selectedCategory,
    required this.errorMessage,
    required this.fetchCategories,
    required this.selectCategory,
  });

  static CategoryViewModel fromStore(Store<AppState> store) {
    return CategoryViewModel(
      isLoading: store.state.categoryState.isLoading,
      categories: store.state.categoryState.categories,
      selectedCategory: store.state.categoryState.selectedCategory,
      errorMessage: store.state.categoryState.errorMessage,

      fetchCategories: () {
        print("Dispatching FetchCategoriesRequest");
        store.dispatch(FetchCategoriesRequest());
      },

      selectCategory: (category) {
        store.dispatch(SelectCategory(category));
      },
    );
  }
}
