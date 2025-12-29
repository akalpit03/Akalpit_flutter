// features/profile_search/ui/profile_search_screen.dart

import 'package:akalpit/core/constants/app_colors.dart';
import 'package:akalpit/features/search/screens/widgets/SearchBar.dart';
import 'package:akalpit/features/search/screens/widgets/SearchResults.dart';
import 'package:akalpit/features/search/services/searchviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../core/store/app_state.dart';
 

class ProfileSearchScreen extends StatelessWidget {
  const ProfileSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProfileSearchViewModel>(
      converter: ProfileSearchViewModel.fromStore,
      builder: (context, vm) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          body: SafeArea(
            child: Column(
              children: [
                ProfileSearchBar(vm: vm),
                const SizedBox(height: 12),
                Expanded(
                  child: SearchResults(vm: vm),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
