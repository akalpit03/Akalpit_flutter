import 'package:flutter/material.dart';

class AdminHeader extends StatelessWidget {
  const AdminHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24),
      color: Colors.grey.shade100,
      child: Column(
        children: [
          CircleAvatar(
            radius: 42,
            backgroundColor: Colors.grey.shade300,
            child: const Icon(Icons.person, size: 40),
          ),
          const SizedBox(height: 12),
          const Text(
            'Admin Name',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Admin-Literary Club',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
