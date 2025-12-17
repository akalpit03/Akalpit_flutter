import 'package:akalpit/features/Events/layout/ui/widgets/body.dart';
import 'package:flutter/material.dart';

class ClubEventsPage extends StatelessWidget {
  final bool isAdmin;

  const ClubEventsPage({
    super.key,
    required this.isAdmin,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const EventBody(
        isClub: true,
      ),

      /// ================= ADMIN ADD EVENT BUTTON =================
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              onPressed: () {
                 ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Admin Can create an event from here page'),
        duration: Duration(seconds: 2),
      ),
    );
              },
              child: const Icon(Icons.add),
              backgroundColor: Colors.white,
            )
          : null,
    );
  }
}
