import 'package:akalpit/features/misc/services/categories/categoryModel.dart';

class CategoryState {
  final bool isLoading;
  final List<Category> categories;
  final Category? selectedCategory;
  final String? selectedParentId;
  final String? errorMessage;

  const CategoryState({
    required this.isLoading,
    required this.categories,
    this.selectedCategory,
    this.selectedParentId,
    this.errorMessage,
  });

  CategoryState copyWith({
    bool? isLoading,
    List<Category>? categories,
    Category? selectedCategory,
    String? selectedParentId,
    String? errorMessage,
  }) {
    return CategoryState(
      isLoading: isLoading ?? this.isLoading,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedParentId: selectedParentId ?? this.selectedParentId,
      errorMessage: errorMessage,
    );
  }

  Map<String, dynamic> toJson() => {
        'isLoading': isLoading,
        'categories': categories.map((e) => e.toJson()).toList(),
        'selectedCategory': selectedCategory?.toJson(),
        'selectedParentId': selectedParentId,
        'errorMessage': errorMessage,
      };

  factory CategoryState.initial() => const CategoryState(
        isLoading: false,
        categories: [],
        selectedCategory: null,
        selectedParentId: null,
        errorMessage: null,
      );

  static CategoryState fromJson(Map<String, dynamic>? json) {
    if (json == null) return CategoryState.initial();

    return CategoryState(
      isLoading: json['isLoading'] ?? false,
      categories: (json['categories'] as List<dynamic>? ?? [])
          .map((e) => Category.fromJson(e))
          .toList(),
      selectedCategory: json['selectedCategory'] != null
          ? Category.fromJson(json['selectedCategory'])
          : null,
      selectedParentId: json['selectedParentId'],
      errorMessage: json['errorMessage'],
    );
  }
}
