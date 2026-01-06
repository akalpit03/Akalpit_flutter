import 'package:flutter/material.dart';

class AdminHeader extends StatelessWidget {
  final dynamic owner;

  // Accept the owner data passed from ClubTeamPage
  const AdminHeader({super.key, required this.owner});

  @override
  Widget build(BuildContext context) {
    // Extracting data safely from the owner object
    final String name = owner?.displayName ?? 'No Name';
    // final String? profilePic = owner?.profileImage; 
    final String initial = name.isNotEmpty ? name[0].toUpperCase() : '?';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
      ),
      child: Column(
        children: [
          /// Profile Image / Avatar
          CircleAvatar(
            radius: 42,
            backgroundColor: Colors.blueGrey.shade100,
            // backgroundImage: profilePic != null ? NetworkImage(profilePic) : null,
            // child: profilePic == null 
            //     ? Text(initial, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueGrey))
            //     : null,
          ),
          
          const SizedBox(height: 12),

          /// Owner Name
          Text(
          name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              letterSpacing: 0.5,
            ),
          ),

          const SizedBox(height: 4),

          /// Role Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.orange.shade200),
            ),
            child: const Text(
              'CLUB OWNER',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: Colors.orange,
              ),
            ),
          ),
        ],
      ),
    );
  }
}