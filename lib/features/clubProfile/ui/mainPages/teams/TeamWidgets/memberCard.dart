import 'package:flutter/material.dart';

class MemberCard extends StatelessWidget {
  final String name;
  final String designation;
  final bool isAdmin;
  final VoidCallback? onEdit;

  const MemberCard({
    super.key,
    required this.name,
    required this.designation,
    this.isAdmin = false,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.grey.shade300,
            child: const Icon(Icons.person, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  designation,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          // ================= ADMIN EDIT BUTTON =================
          if (isAdmin)
            IconButton(
              icon: const Icon(Icons.edit, size: 20,color: Colors.black,),
              onPressed: onEdit,
            ),
        ],
      ),
    );
  }
}
