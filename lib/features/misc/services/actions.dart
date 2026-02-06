 

import 'package:akalpit/features/misc/services/categories/categoryModel.dart';

class FetchCategoriesRequest {}

class FetchCategoriesSuccess {
  final List<Category> categories;
  FetchCategoriesSuccess(this.categories);
}

class FetchCategoriesFailure {
  final String error;
  FetchCategoriesFailure(this.error);
}

class SelectCategory {
  final Category category;
  SelectCategory(this.category);
}
