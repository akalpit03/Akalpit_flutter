import 'package:akalpit/core/constants/app_colors.dart';
import 'package:akalpit/features/search/services/searchviewmodel.dart';
import 'package:flutter/material.dart';

class ProfileSearchBar extends StatelessWidget {
  final ProfileSearchViewModel vm;

  const ProfileSearchBar({required this.vm});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Material(
        elevation: 4,
        shadowColor: Colors.black12,
        borderRadius: BorderRadius.circular(16),
        child: TextField(
          onChanged: vm.search,
          decoration: InputDecoration(
            hintText: "Search people...",
            prefixIcon: const Icon(Icons.search),
            suffixIcon: vm.query.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: vm.clear,
                  )
                : null,
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
}
