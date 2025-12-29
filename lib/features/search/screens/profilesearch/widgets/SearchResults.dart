import 'package:akalpit/features/search/screens/profilesearch/widgets/profileCard.dart';
import 'package:akalpit/features/search/services/searchviewmodel.dart';
import 'package:flutter/material.dart';
 

class SearchResults extends StatelessWidget {
  final ProfileSearchViewModel vm;

  const SearchResults({required this.vm});

  @override
  Widget build(BuildContext context) {
    if (vm.isSearching && vm.results.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (vm.error != null) {
      return Center(
        child: Text(
          vm.error!,
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    if (vm.results.isEmpty) {
      return const Center(
        child: Text(
          "No profiles found",
          style: TextStyle(color: Colors.white70),
        ),
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (scroll) {
        if (scroll.metrics.pixels >=
            scroll.metrics.maxScrollExtent - 200) {
          vm.loadNextPage();
        }
        return false;
      },
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: vm.results.length,
        itemBuilder: (_, index) {
          final profile = vm.results[index];
          return ProfileCard(profile: profile);
        },
      ),
    );
  }
}
