// features/search/screens/clubsearch/widgets/ClubCard.dart

import 'package:akalpit/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ClubCard extends StatelessWidget {
  final Map<String, dynamic> club;

  const ClubCard({super.key, required this.club});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          // 👉 Navigate to club details page
          // Navigator.pushNamed(context, '/club-detail', arguments: club["clubId"]);
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Club Image - Rounded Square style
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 60,
                  height: 60,
                  color: Colors.grey.shade200,
                  child: club["image"] != null
                      ? Image.network(
                          club["image"],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.groups, size: 30, color: Colors.grey),
                        )
                      : const Icon(Icons.groups, size: 30, color: Colors.grey),
                ),
              ),
              const SizedBox(width: 14),
              
              // Club Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      club["clubName"] ?? "Unnamed Club",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "${club["membersCount"] ?? 0} members",
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.blueAccent, // Or your primary theme color
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Brief 'About' section
                    Text(
                      club["about"] ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white60,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Icon(
                  Icons.chevron_right,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}