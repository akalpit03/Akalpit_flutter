import 'package:flutter/material.dart';

class ClubPoliciesPage extends StatelessWidget {
  final String clubId;

  const ClubPoliciesPage({
    super.key,
    required this.clubId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: const SingleChildScrollView(
        padding:   EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:   [
            _ClubHeader(),
            SizedBox(height: 24),
            _SectionCard(
              icon: Icons.description_outlined,
              title: 'Description',
              content:
                  'The Akalpit Club is a community-driven space focused on learning, collaboration, and meaningful discussions. We aim to create a supportive environment where members grow together.',
            ),
            SizedBox(height: 16),
            _SectionCard(
              icon: Icons.rule,
              title: 'Rules',
              bullets: [
                'Respect all members and their opinions',
                'No hate speech, abuse, or harassment',
                'Follow platform and community guidelines',
                'Admin decisions are final',
              ],
            ),
            SizedBox(height: 16),
            _SectionCard(
              icon: Icons.gavel_outlined,
              title: 'Regulations',
              bullets: [
                'Only approved members can post content',
                'Spamming or promotions are prohibited',
                'Events must be approved by admins',
                'Violations may lead to removal',
              ],
            ),
            SizedBox(height: 16),
            _SectionCard(
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy & Conduct',
              content:
                  'All club interactions should maintain confidentiality. Personal data of members must not be shared without consent.',
            ),
          ],
        ),
      ),
    );
  }
}

/// ================= HEADER =================
class _ClubHeader extends StatelessWidget {
  const _ClubHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blueGrey.shade800,
            Colors.blueGrey.shade600,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 32,
            backgroundColor: Colors.white24,
            child: Icon(Icons.groups, size: 34, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'The Akalpit Club',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Rules • Regulations • Description',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= SECTION CARD =================
class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? content;
  final List<String>? bullets;

  const _SectionCard({
    required this.icon,
    required this.title,
    this.content,
    this.bullets,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title Row
            Row(
              children: [
                Icon(icon, size: 22, color: const Color.fromARGB(255, 189, 194, 197)),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// Text Content
            if (content != null)
              Text(
                content!,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: Colors.white,
                ),
              ),

            /// Bullet Points
            if (bullets != null)
              Column(
                children: bullets!
                    .map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.circle,
                              size: 6,
                              color: Colors.blueGrey,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }
}
