import 'dart:async';
import 'package:akalpit/core/constants/app_colors.dart';
import 'package:akalpit/features/search/viewmodels/ProfileSearchViewModel.dart';
import 'package:flutter/material.dart';

class ProfileSearchBar extends StatefulWidget {
  final ProfileSearchViewModel vm;

  const ProfileSearchBar({required this.vm, super.key});

  @override
  _ProfileSearchBarState createState() => _ProfileSearchBarState();
}

class _ProfileSearchBarState extends State<ProfileSearchBar> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Debounce: 500ms delay
    _debounce = Timer(const Duration(milliseconds: 700), () {
      widget.vm.search(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Material(
        elevation: 4,
        shadowColor: Colors.black12,
        borderRadius: BorderRadius.circular(16),
        child: TextField(
          onChanged: _onSearchChanged,
          decoration: InputDecoration(
            hintText: "Search people with userName...",
            prefixIcon: const Icon(Icons.search),
            suffixIcon: widget.vm.query.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: widget.vm.clear,
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
