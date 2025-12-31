import 'package:akalpit/core/constants/app_colors.dart';
import 'package:akalpit/features/clubProfile/services/states/clubs.dart';
 import 'package:akalpit/features/clubProfile/ui/widgets/InfoCard.dart';
import 'package:flutter/material.dart';
 

class AboutSection extends StatelessWidget {
  final Club club;

  const AboutSection({super.key, required this.club});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.scaffoldBackground,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ================= SECTION TITLE =================
            const Text(
              "About",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 14),

            /// ================= ABOUT CARD =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                club.about?.isNotEmpty == true
                    ? club.about!
                    : "No description added yet.",
                style: const TextStyle(
                  fontSize: 14.5,
                  height: 1.5,
                  color: Colors.white70,
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// ================= INFO ROW =================
            Row(
              children: [
                ModernInfoCard(
                  value: club.membersCount.toString(),
                  label: "Members",
                  icon: Icons.group_outlined,
                ),
                const SizedBox(width: 12),
                ModernInfoCard(
                  value: club.postsCount.toString(),
                  label: "Posts",
                  icon: Icons.article_outlined,
                ),
                const SizedBox(width: 12),
                ModernInfoCard(
                  value: club.privacy.toUpperCase(),
                  label: "Privacy",
                  icon: Icons.lock_outline,
                  isTextValue: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
