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

  /// ✅ allowed: a-z, 0-9, _, .
  final RegExp _clubIdRegex = RegExp(r'^[a-z0-9._]+$');

  Timer? _debounce;

  bool _hasInvalidChar = false;
  bool _isTooShort = false;

  void _onClubIdChanged(String value, ClubAvailabilityViewModel vm) {
    final lower = value.toLowerCase();

    /// 🔽 Auto convert uppercase → lowercase
    if (value != lower) {
      _clubIdController.value = _clubIdController.value.copyWith(
        text: lower,
        selection: TextSelection.collapsed(offset: lower.length),
      );
    }

    _debounce?.cancel();

    /// ❌ Invalid characters
    if (lower.isNotEmpty && !_clubIdRegex.hasMatch(lower)) {
      setState(() {
        _hasInvalidChar = true;
        _isTooShort = false;
      });
      vm.clear();
      return;
    }

    /// ❌ Less than 6 characters
    if (lower.isNotEmpty && lower.length < 6) {
      setState(() {
        _hasInvalidChar = false;
        _isTooShort = true;
      });
      vm.clear();
      return;
    }

    /// ✅ Valid input
    setState(() {
      _hasInvalidChar = false;
      _isTooShort = false;
    });

    if (lower.isEmpty) {
      vm.clear();
      return;
    }

    /// 🔍 Debounced availability check
    _debounce = Timer(const Duration(milliseconds: 600), () {
      vm.checkAvailability(lower);
    });
  }

  void _registerClub() {
    final clubId = _clubIdController.text.trim().toLowerCase();

    if (clubId.isEmpty || _hasInvalidChar || _isTooShort) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SetClubProfilePage(
          initialClubId: clubId,
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

                      /// 🔤 Club ID input
                      TextField(
                        controller: _clubIdController,
                        onChanged: (value) => _onClubIdChanged(value, vm),
                        decoration: InputDecoration(
                          hintText: 'Club ID (e.g. chess.club_01)',
                          helperText:
                              'Min 6 chars • Allowed: a-z, 0-9, "_" and "."',
                          prefixIcon: const Icon(Icons.search),

                          suffixIcon: vm.isChecking
                              ? const Padding(
                                  padding: EdgeInsets.all(12),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
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

                          /// ❌ Validation errors
                          errorText: _hasInvalidChar
                              ? 'Only lowercase letters, numbers, "_" and "." are allowed'
                              : _isTooShort
                                  ? 'Club ID must be at least 6 characters'
                                  : null,

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      if (vm.available == false &&
                          !_hasInvalidChar &&
                          !_isTooShort)
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

                      /// ✅ Register button
                      if (vm.available == true &&
                          !_hasInvalidChar &&
                          !_isTooShort)
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _registerClub,
                            style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14),
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
