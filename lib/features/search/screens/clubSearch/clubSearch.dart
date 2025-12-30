// features/club_search/ui/club_search_screen.dart

import 'package:akalpit/core/constants/app_colors.dart';
import 'package:akalpit/features/search/screens/clubsearch/widgets/ClubSearchBar.dart';
import 'package:akalpit/features/search/screens/clubsearch/widgets/ClubSearchResults.dart';

import 'package:akalpit/features/search/viewmodels/clubSearchViewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../../../core/store/app_state.dart';

class ClubSearchScreen extends StatelessWidget {
  const ClubSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ClubSearchViewModel>(
      // We use a specific ClubSearchViewModel to isolate logic
      converter: ClubSearchViewModel.fromStore,
      builder: (context, vm) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          body: SafeArea(
            child: Column(
              children: [
                ClubSearchBar(vm: vm), // Specifically for Clubs
                const SizedBox(height: 12),
                Expanded(
                  child: ClubSearchResults(vm: vm),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
