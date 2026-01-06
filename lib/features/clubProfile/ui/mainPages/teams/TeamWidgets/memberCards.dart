import 'package:akalpit/core/constants/app_colors.dart';
import 'package:akalpit/features/profile/ui/profile_page.dart';
import 'package:flutter/material.dart';

class MemberCard extends StatelessWidget {
  final Map<String, dynamic> member;

  const MemberCard({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    // 1. Extract the nested user object
    final userData = member['user'] ?? {};
    
    // 2. Extract specific fields with fallbacks
    final String userId = userData['_id'] ?? ''; // Extract the ID for navigation
    final String username = userData['username'] ?? 'Unknown User';
    final String? profileImage = userData['profileImage'];
    final String role = member['role'] ?? 'member';
    
    final String initial = username.isNotEmpty ? username[0].toUpperCase() : '?';

    return InkWell(
      onTap: () {
        if (userId.isNotEmpty) {
          // Replace 'UserProfilePage' with your actual profile widget name
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => ProfilePage(userId: userId))
          );
      
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.cardBackground),
        ),
        child: Row(
          children: [
            /// Profile Image / Initial
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.blue.shade50,
              backgroundImage: profileImage != null ? NetworkImage(profileImage) : null,
              child: profileImage == null 
                  ? Text(initial, style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.bold))
                  : null,
            ),
            
            const SizedBox(width: 12),

            /// Username and Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.white, // Assuming dark theme based on cardBackground
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    role.toLowerCase(),
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            /// Trailing Action
            const Icon(Icons.chevron_right, color: Colors.grey, size: 18),
          ],
        ),
      ),
    );
  }
}