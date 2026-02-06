 
import 'package:akalpit/core/api/api_gateway.dart';
import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/misc/services/actions.dart';
import 'package:akalpit/features/misc/services/categories/categoryModel.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> categoryMiddleware(ApiGateway apiGateway) {
  return [
    TypedMiddleware<AppState, FetchCategoriesRequest>(
      fetchCategories(apiGateway),
    ),
  ];
}
Middleware<AppState> fetchCategories(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is FetchCategoriesRequest) {
      next(action); // Let reducer set isLoading = true
print(  "Middleware received FetchCategoriesRequest, calling API...");
      try {
        final response =
            await apiGateway.miscService.fetchCategories();

        final List<Category> categories =
            (response["data"] as List)
                .map((e) => Category.fromJson(e))
                .toList();

        store.dispatch(
          FetchCategoriesSuccess(categories),
        );
      } catch (e) {
        store.dispatch(
          FetchCategoriesFailure(e.toString()),
        );
      }
    } else {
      next(action);
    }
  };
}
