import 'dart:async';

import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/clubProfile/ui/onboarding/screens/create/register.dart';
import 'package:akalpit/features/search/viewmodels/ClubAvailabilityViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class VerifyClubPage extends StatefulWidget {
  const VerifyClubPage({super.key});

  @override
  State<VerifyClubPage> createState() => _VerifyClubPageState();
}

class _VerifyClubPageState extends State<VerifyClubPage> {
  final TextEditingController _clubIdController = TextEditingController();
  final RegExp _clubIdRegex = RegExp(r'^[a-z0-9._]+$');
  Timer? _debounce;

  void _onClubIdChanged(String value, ClubAvailabilityViewModel vm) {
    final clubId = value.trim().toLowerCase();

    _debounce?.cancel();

    if (clubId.isEmpty || !_clubIdRegex.hasMatch(clubId)) {
      vm.clear();
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 600), () {
      debugPrint('🔍 Checking availability for: $clubId');
      vm.checkAvailability(clubId);
    });
  }

  void _registerClub() {
    final clubId = _clubIdController.text.trim().toLowerCase();
    if (clubId.isEmpty) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SetClubProfilePage(
          initialClubId: clubId, // Pass the ID here
        ),
      ),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _clubIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ClubAvailabilityViewModel>(
      converter: ClubAvailabilityViewModel.fromStore,
      distinct: true,
      builder: (context, vm) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Register Your Club',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Register Your Club',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _clubIdController,
                        textInputAction: TextInputAction.done,
                        onChanged: (value) => _onClubIdChanged(value, vm),
                        decoration: InputDecoration(
                          hintText: 'Club ID (e.g. chess.club_01)',
                          helperText:
                              'Lowercase letters, numbers, "_" and "." only',
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: vm.isChecking
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Padding(
                                    padding: EdgeInsets.all(12),
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                )
                              : vm.available == true
                                  ? const Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                    )
                                  : vm.available == false
                                      ? const Icon(
                                          Icons.cancel,
                                          color: Colors.red,
                                        )
                                      : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (vm.available == false)
                        const Text(
                          'This Club ID is already taken',
                          style: TextStyle(color: Colors.red),
                        ),
                      if (vm.error != null)
                        Text(
                          vm.error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      const SizedBox(height: 16),
                      if (vm.available == true)
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _registerClub,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Register Your Club',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
