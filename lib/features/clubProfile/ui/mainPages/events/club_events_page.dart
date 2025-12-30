import 'package:akalpit/features/Events/create/ui/register_screen.dart';
import 'package:flutter/material.dart';

import 'package:akalpit/features/Events/layout/ui/widgets/body.dart';
 

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
              backgroundColor: Colors.white,
              elevation: 4,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CreateEventMainPage(),
                  ),
                );
              },
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            )
          : null,
    );
  }
}
