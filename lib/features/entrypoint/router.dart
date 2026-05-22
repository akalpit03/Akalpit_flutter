import 'package:akalpit/features/entrypoint/institutionentrypoint.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:akalpit/features/entrypoint/entrypoint_ui.dart';
 

/// Place this as your first route after login/splash.
/// It reads the role from SharedPreferences and routes accordingly.
class RoleBasedRouter extends StatefulWidget {
  const RoleBasedRouter({super.key});

  @override
  State<RoleBasedRouter> createState() => _RoleBasedRouterState();
}

class _RoleBasedRouterState extends State<RoleBasedRouter> {
  @override
  void initState() {
    super.initState();
    _route();
  }

  Future<void> _route() async {
    final prefs = await SharedPreferences.getInstance();

    // Expect 'user' or 'institution' saved at login time:
    // await prefs.setString('role', 'institution');
    final role = prefs.getString('role') ?? 'user';

    if (!mounted) return;

    Widget destination;
    if (role == 'institution') {
      destination = const InstitutionEntryPointUI();
    } else {
      destination = const EntryPointUI();
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => destination),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Show a plain black screen while reading prefs
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}