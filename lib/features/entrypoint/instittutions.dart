import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// INSTITUTION — MY SERVICES PAGE
// ─────────────────────────────────────────────────────────────
class InstitutionServicesPage extends StatelessWidget {
  const InstitutionServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _PlaceholderPage(
      icon: Icons.miscellaneous_services,
      title: 'My Services',
    );
  }
}

// ─────────────────────────────────────────────────────────────
// INSTITUTION — BOOKINGS / REQUESTS PAGE
// ─────────────────────────────────────────────────────────────
class InstitutionBookingsPage extends StatelessWidget {
  const InstitutionBookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _PlaceholderPage(
      icon: Icons.book_online,
      title: 'Bookings & Requests',
    );
  }
}

// ─────────────────────────────────────────────────────────────
// INSTITUTION — POSTS PAGE
// ─────────────────────────────────────────────────────────────
class InstitutionPostsPage extends StatelessWidget {
  const InstitutionPostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _PlaceholderPage(
      icon: Icons.post_add,
      title: 'Posts',
    );
  }
}

// ─────────────────────────────────────────────────────────────
// INSTITUTION — COUNCILS PAGE
// ─────────────────────────────────────────────────────────────
class InstitutionCouncilsPage extends StatelessWidget {
  const InstitutionCouncilsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _PlaceholderPage(
      icon: Icons.groups,
      title: 'Councils',
    );
  }
}

// ─────────────────────────────────────────────────────────────
// INSTITUTION — PROFILE PAGE
// ─────────────────────────────────────────────────────────────
 

// ─────────────────────────────────────────────────────────────
// SHARED PLACEHOLDER WIDGET
// ─────────────────────────────────────────────────────────────
class _PlaceholderPage extends StatelessWidget {
  final IconData icon;
  final String title;

  const _PlaceholderPage({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white24, size: 64),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white38,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Coming soon',
              style: TextStyle(color: Colors.white24, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}