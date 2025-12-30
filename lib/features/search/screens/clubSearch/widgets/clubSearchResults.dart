
import 'package:akalpit/features/search/screens/clubsearch/widgets/ClubCard.dart';
import 'package:akalpit/features/search/viewmodels/clubSearchViewmodel.dart';
import 'package:flutter/material.dart';

class ClubSearchResults extends StatelessWidget {
  final ClubSearchViewModel vm;

  const ClubSearchResults({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    // 1. Loading State
    if (vm.isSearching && vm.clubs.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // 2. Error State
    if (vm.error != null) {
      return Center(
        child: Text(
          "Error: ${vm.error}",
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    // 3. Empty State
    if (vm.clubs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.group_off_outlined, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              "No clubs found",
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
          ],
        ),
      );
    }

    // 4. Success State (The List)
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Optional: Show total results from the 'meta' tag
        if (vm.clubs.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              "Found ${vm.clubs.length} clubs",
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ),
          
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: vm.clubs.length,
            itemBuilder: (context, index) {
              final clubData = vm.clubs[index];
              return ClubCard(club: clubData);
            },
          ),
        ),
      ],
    );
  }
}