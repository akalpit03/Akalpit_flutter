import 'dart:async';
import 'package:akalpit/features/clubProfile/onboarding/create/register.dart';
import 'package:flutter/material.dart';

class VerifyClubPage extends StatefulWidget {
  const VerifyClubPage({super.key});

  @override
  State<VerifyClubPage> createState() => _VerifyClubPageState();
}

class _VerifyClubPageState extends State<VerifyClubPage> {
  final TextEditingController _clubIdController = TextEditingController();

  bool _isSearching = false;
  bool _showRegisterButton = false;
  bool _isRegistering = false;

  void _searchClub() {
    if (_clubIdController.text.trim().isEmpty) return;

    setState(() {
      _isSearching = true;
      _showRegisterButton = false;
    });

    // ⏳ Fake API delay
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _isSearching = false;
        _showRegisterButton = true;
      });
    });
  }

  void _registerClub() {
    setState(() {
      _isRegistering = true;
    });

    // Show success snackbar immediately
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Club registered successfully'),
        duration: Duration(seconds: 2),
      ),
    );

    // ⏳ Fake API + navigation delay
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _isRegistering = false;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const SetClubProfilePage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
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
                      /// Title
                      const Text(
                        'Register Your Club',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// Search Field
                      TextField(
                        controller: _clubIdController,
                        decoration: InputDecoration(
                          hintText: 'Register with your Club ID',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onSubmitted: (_) => _searchClub(),
                      ),

                      const SizedBox(height: 16),

                      /// Search Button
                      if (!_isSearching && !_showRegisterButton)
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _searchClub,
                            child: const Text('Search Club'),
                          ),
                        ),

                      /// Loader
                      if (_isSearching) ...[
                        const SizedBox(height: 16),
                        const CircularProgressIndicator(),
                      ],

                      /// Register Button
                      if (_showRegisterButton) ...[
                        const SizedBox(height: 20),
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        /// ================= FULL SCREEN LOADER =================
        if (_isRegistering)
          Container(
            color: Colors.black.withOpacity(0.4),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
