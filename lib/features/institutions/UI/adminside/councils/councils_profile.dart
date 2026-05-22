import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// DUMMY DATA
// ─────────────────────────────────────────────────────────────

final _dummyCouncilDetail = {
  'id': '1',
  'name': 'Student Council CSJMU',
  'logo': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
  'coverImage': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
  'theme': 'Academic Excellence & Governance',
  'about':
      'The Student Council of CSJMU is the apex student body responsible for academic and cultural governance of the university. We bridge the gap between students and administration, ensuring that every student voice is heard and represented effectively.',
  'totalMembers': 240,
  'admins': [
    {
      'id': 'u1',
      'name': 'Anurag Chauhan',
      'username': 'anurag30',
      'designation': 'President',
      'avatar': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
    },
    {
      'id': 'u2',
      'name': 'Priya Sharma',
      'username': 'priya_s',
      'designation': 'Secretary',
      'avatar': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
    },
    {
      'id': 'u3',
      'name': 'Rahul Verma',
      'username': 'rahul_v',
      'designation': 'Treasurer',
      'avatar': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
    },
  ],
  'clubs': [
    {
      'id': 'c1',
      'name': 'Vivek Poetry Club',
      'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
      'members': 45,
      'role': 'Cultural',
    },
    {
      'id': 'c2',
      'name': 'Debate Society',
      'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
      'members': 52,
      'role': 'Academic',
    },
    {
      'id': 'c3',
      'name': 'Robotics Club',
      'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
      'members': 60,
      'role': 'Technical',
    },
    {
      'id': 'c4',
      'name': 'Photography Club',
      'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
      'members': 38,
      'role': 'Arts',
    },
    {
      'id': 'c5',
      'name': 'Music Club',
      'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
      'members': 70,
      'role': 'Cultural',
    },
  ],
};

// ─────────────────────────────────────────────────────────────
// COUNCIL DETAIL PAGE
// ─────────────────────────────────────────────────────────────

class CouncilDetailPage extends StatelessWidget {
  // In real app: pass council id and fetch from API
  // final String councilId;
  const CouncilDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final council = _dummyCouncilDetail;
    final admins =
        List<Map<String, dynamic>>.from(council['admins'] as List);
    final clubs =
        List<Map<String, dynamic>>.from(council['clubs'] as List);

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
       
          

          // ── Body ─────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Logo + Name + Theme ─────────────────────
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Logo (overlaps cover)
                      Transform.translate(
                        offset: const Offset(0, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                                color: Colors.black, width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 12,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: CachedNetworkImage(
                              imageUrl: council['logo'] as String,
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                              errorWidget: (_, __, ___) => Container(
                                height: 80,
                                width: 80,
                                color: const Color(0xFF2A2A2A),
                                child: const Icon(Icons.groups,
                                    color: Colors.white24, size: 32),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              council['name'] as String,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              council['theme'] as String,
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // ── Stats Row ───────────────────────────────
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      _StatBox(
                        value: '${council['totalMembers']}',
                        label: 'Members',
                        icon: Icons.people_outline,
                      ),
                      const SizedBox(width: 10),
                      _StatBox(
                        value: '${clubs.length}',
                        label: 'Clubs',
                        icon: Icons.hub_outlined,
                      ),
                      const SizedBox(width: 10),
                      _StatBox(
                        value: '${admins.length}',
                        label: 'Admins',
                        icon: Icons.admin_panel_settings_outlined,
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // ── About ────────────────────────────────────
                  _SectionHeader('About'),
                  const SizedBox(height: 10),
                  Text(
                    council['about'] as String,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ── Admins ───────────────────────────────────
                  _SectionHeader('Council Admins'),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 110,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: admins.length,
                      itemBuilder: (_, i) =>
                          _AdminCard(admin: admins[i]),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ── Clubs ────────────────────────────────────
                  _SectionHeader('Clubs under this Council'),
                  const SizedBox(height: 12),
                  ...clubs.map((club) => _ClubTile(club: club)),
                ],
              ),
            ),
          ),
        ],
      ),

      // ── Join Button ────────────────────────────────────────
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                // TODO: join council API
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Join Council',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// STAT BOX
// ─────────────────────────────────────────────────────────────

class _StatBox extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const _StatBox({
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white38, size: 18),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                  color: Colors.white38, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// SECTION HEADER
// ─────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.2,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// ADMIN CARD (horizontal scroll)
// ─────────────────────────────────────────────────────────────

class _AdminCard extends StatelessWidget {
  final Map<String, dynamic> admin;
  const _AdminCard({required this.admin});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          // Avatar
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF2A2A2A), width: 2),
            ),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: admin['avatar'],
                height: 56,
                width: 56,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => Container(
                  height: 56,
                  width: 56,
                  color: const Color(0xFF2A2A2A),
                  child: const Icon(Icons.person,
                      color: Colors.white24, size: 24),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            admin['name'],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            admin['designation'],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white38,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// CLUB TILE (vertical list)
// ─────────────────────────────────────────────────────────────

class _ClubTile extends StatelessWidget {
  final Map<String, dynamic> club;
  const _ClubTile({required this.club});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          // Club image
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: club['image'],
              height: 48,
              width: 48,
              fit: BoxFit.cover,
              errorWidget: (_, __, ___) => Container(
                height: 48,
                width: 48,
                color: const Color(0xFF2A2A2A),
                child: const Icon(Icons.groups,
                    color: Colors.white24, size: 22),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Name + role
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  club['name'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  club['role'],
                  style: const TextStyle(
                      color: Colors.white38, fontSize: 12),
                ),
              ],
            ),
          ),

          // Members count
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${club['members']}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const Text(
                'members',
                style: TextStyle(color: Colors.white38, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}