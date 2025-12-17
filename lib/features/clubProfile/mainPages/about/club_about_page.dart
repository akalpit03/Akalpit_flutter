import 'package:akalpit/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ClubAboutPage extends StatelessWidget {
  final bool isAdmin;

  const ClubAboutPage({
    super.key,
    required this.isAdmin,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ================= CLUB POSTER (16:9) =================
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                ),
                child: const Icon(
                  Icons.image,
                  size: 60,
                  color: Colors.white70,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _StatsCard(),
            ),
            const SizedBox(height: 16),

            /// ================= INFO CARD =================
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _InfoTile(
                    title: "Institution Name",
                    value: "XYZ University",
                  ),
                  _InfoTile(
                    title: "Council Name",
                    value: "Technical Council",
                  ),
                  _InfoTile(
                    title: "About",
                    value:
                        "Akalpit Tech Club focuses on innovation, development, and technology-driven learning experiences for students.",
                  ),
                  _InfoTile(
                    title: "Address",
                    value: "XYZ University Campus, City, State",
                  ),
                  _InfoTile(
                    title: "What Services We Offer",
                    value:
                        "Workshops, Hackathons, Tech Talks, Mentorship Programs",
                  ),
                  _InfoTile(
                    title: "Founder / Founded By",
                    value: "John Doe",
                  ),
                  _InfoTile(
                    title: "Founding Year",
                    value: "2021",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// ================= STATS CARD =================

            // space for FAB
          ],
        ),
      ),

      /// ================= ADMIN EDIT BUTTON =================
      floatingActionButton: isAdmin
          ? FloatingActionButton.extended(
              onPressed: () {},
              icon: const Icon(Icons.edit),
              label: const Text("Edit"),
              backgroundColor: Colors.white,
            )
          : null,
    );
  }
}

/// ================= INFO TILE =================
class _InfoTile extends StatelessWidget {
  final String title;
  final String value;

  const _InfoTile({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= STATS CARD =================
class _StatsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _StatItem(label: "Followers", value: "1.2K"),
          _Divider(),
          _StatItem(label: "Members", value: "85"),
          _Divider(),
          _StatItem(label: "Events", value: "24"),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: 1,
      color: Colors.grey.shade300,
    );
  }
}
