import 'package:akalpit/features/profile/ui/widget/profile/about/awards.dart';
import 'package:akalpit/features/profile/ui/widget/profile/about/experience.dart';
import 'package:flutter/material.dart';

class ProfileAboutTab extends StatelessWidget {
  const ProfileAboutTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          // ===== About =====
          Text(
            'About',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 6),
          Text('Passionate developer and lifelong learner.'),

          SizedBox(height: 20),
          Divider(),
          // ===== Awards =====

          SizedBox(height: 10),
          ProfileAwardsCarousel(),

          SizedBox(height: 20),
          Divider(),
          // ===== Experience =====
          Text(
            'Experience',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 12),
          ProfileExperienceTimeline(),
        ],
      ),
    );
  }
}
