import 'package:flutter/material.dart';

class CreateEventPageAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CreateEventPageAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: const Text(
        "Create Event",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      actions: [
        TextButton.icon(
          onPressed: () {
            // TODO: Navigate to add sponsors screen
          },
          icon: const Icon(Icons.handshake_outlined),
          label: const Text("Add Sponsors"),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
