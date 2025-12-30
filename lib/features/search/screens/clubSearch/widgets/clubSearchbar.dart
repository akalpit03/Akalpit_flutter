// features/search/screens/clubsearch/widgets/ClubSearchBar.dart

import 'package:akalpit/core/constants/app_colors.dart';
 
import 'package:akalpit/features/search/viewmodels/clubSearchViewmodel.dart';
import 'package:flutter/material.dart';

class ClubSearchBar extends StatelessWidget {
  final ClubSearchViewModel vm;

  const ClubSearchBar({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Material(
        elevation: 4,
        shadowColor: Colors.black12,
        borderRadius: BorderRadius.circular(16),
        child: TextField(
          onChanged: (value) {
            // 🛑 Constraint: Only trigger search if 4 or more characters are entered
            if (value.length >= 4) {
              vm.onSearch(value);
            } else if (value.isEmpty) {
              // Clear results if the user deletes everything
              vm.onClear();
            }
          },
          decoration: InputDecoration(
            hintText: "Search clubs (min. 4 letters)...",
            prefixIcon: const Icon(Icons.groups_outlined),
            suffixIcon: _buildSuffixIcon(),
            filled: true,
            fillColor: AppColors.cardBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget? _buildSuffixIcon() {
    // Show loading spinner if searching
    if (vm.isSearching) {
      return const SizedBox(
        width: 20,
        height: 20,
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }
    
    // Show clear button if there are results OR if there is text in the query
    // This allows users to clear the "min. 4 letters" state easily
    if (vm.clubs.isNotEmpty) {
      return IconButton(
        icon: const Icon(Icons.close),
        onPressed: vm.onClear,
      );
    }
    
    return null;
  }
}