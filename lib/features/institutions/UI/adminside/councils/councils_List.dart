import 'package:akalpit/features/institutions/UI/adminside/councils/councils_create.dart';
import 'package:akalpit/features/institutions/UI/adminside/councils/councils_profile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
 

// ─────────────────────────────────────────────────────────────
// DUMMY DATA
// ─────────────────────────────────────────────────────────────

const _dummyCouncils = [
  {
    'id': '1',
    'name': 'Student Council CSJMU',
    'logo': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
    'theme': 'Academic Excellence & Governance',
    'about': 'The apex student body responsible for academic and cultural governance of the university.',
    'adminName': 'Anurag Chauhan',
    'adminRole': 'President',
    'clubCount': 5,
    'memberCount': 240,
    'isJoined': true,
  },
  {
    'id': '2',
    'name': 'Cultural Council',
    'logo': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
    'theme': 'Arts, Music & Expression',
    'about': 'Nurturing creativity and cultural expression through music, drama and fine arts.',
    'adminName': 'Priya Sharma',
    'adminRole': 'Secretary',
    'clubCount': 8,
    'memberCount': 310,
    'isJoined': false,
  },
  {
    'id': '3',
    'name': 'Sports Council',
    'logo': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
    'theme': 'Athletics & Fitness',
    'about': 'Managing all sports activities, tournaments and fitness programs across the institution.',
    'adminName': 'Rahul Verma',
    'adminRole': 'Sports Secretary',
    'clubCount': 6,
    'memberCount': 180,
    'isJoined': true,
  },
  {
    'id': '4',
    'name': 'Tech Council',
    'logo': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
    'theme': 'Innovation & Technology',
    'about': 'Driving tech innovation through hackathons, coding clubs and research initiatives.',
    'adminName': 'Neha Singh',
    'adminRole': 'Tech Lead',
    'clubCount': 4,
    'memberCount': 150,
    'isJoined': false,
  },
];

// ─────────────────────────────────────────────────────────────
// COUNCILS PAGE
// ─────────────────────────────────────────────────────────────

class CouncilsPage extends StatefulWidget {
  final bool isInstitutionAdmin;

  const CouncilsPage({
    super.key,
    this.isInstitutionAdmin = true,
  });

  @override
  State<CouncilsPage> createState() => _CouncilsPageState();
}

class _CouncilsPageState extends State<CouncilsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // User sees: All | Joined
    // Institution sees: All Councils only (they manage, not join)
    _tabController = TabController(
      length: widget.isInstitutionAdmin ? 1 : 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _allCouncils =>
      List<Map<String, dynamic>>.from(_dummyCouncils);

  List<Map<String, dynamic>> get _joinedCouncils =>
      _allCouncils.where((c) => c['isJoined'] == true).toList();

  List<Map<String, dynamic>> _filtered(List<Map<String, dynamic>> list) {
    if (_searchQuery.isEmpty) return list;
    return list
        .where((c) =>
            c['name'].toString().toLowerCase().contains(_searchQuery) ||
            c['theme'].toString().toLowerCase().contains(_searchQuery))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Councils',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(widget.isInstitutionAdmin ? 0 : 48),
          child: widget.isInstitutionAdmin
              ? const SizedBox.shrink()
              : TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.white,
                  indicatorWeight: 2,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white38,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  tabs: const [
                    Tab(text: 'All Councils'),
                    Tab(text: 'Joined'),
                  ],
                ),
        ),
      ),

      // ── FAB: only institution admin ──────────────────────────
      floatingActionButton: widget.isInstitutionAdmin
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const CreateCouncilPage(),
                  ),
                );
              },
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              icon: const Icon(Icons.add),
              label: const Text(
                'New Council',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            )
          : null,

      body: Column(
        children: [
          // ── Search Bar ───────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
            child: TextField(
              controller: _searchController,
              onChanged: (v) =>
                  setState(() => _searchQuery = v.toLowerCase().trim()),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search councils...',
                hintStyle: const TextStyle(color: Colors.white38),
                prefixIcon:
                    const Icon(Icons.search, color: Colors.white54, size: 20),
                filled: true,
                fillColor: const Color(0xFF1C1C1C),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // ── Content ──────────────────────────────────────────
          Expanded(
            child: widget.isInstitutionAdmin
                ? _CouncilList(
                    councils: _filtered(_allCouncils),
                    isAdmin: true,
                  )
                : TabBarView(
                    controller: _tabController,
                    children: [
                      _CouncilList(
                        councils: _filtered(_allCouncils),
                        isAdmin: false,
                      ),
                      _CouncilList(
                        councils: _filtered(_joinedCouncils),
                        isAdmin: false,
                        emptyMessage: "You haven't joined any councils yet.",
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// COUNCIL LIST
// ─────────────────────────────────────────────────────────────

class _CouncilList extends StatelessWidget {
  final List<Map<String, dynamic>> councils;
  final bool isAdmin;
  final String emptyMessage;

  const _CouncilList({
    required this.councils,
    required this.isAdmin,
    this.emptyMessage = 'No councils found.',
  });

  @override
  Widget build(BuildContext context) {
    if (councils.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.groups_outlined, color: Colors.white12, size: 60),
            const SizedBox(height: 14),
            Text(
              emptyMessage,
              style: const TextStyle(color: Colors.white38, fontSize: 14),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
      itemCount: councils.length,
      itemBuilder: (context, index) {
        return _CouncilCard(
          council: councils[index],
          isAdmin: isAdmin,
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────
// COUNCIL CARD
// ─────────────────────────────────────────────────────────────

class _CouncilCard extends StatelessWidget {
  final Map<String, dynamic> council;
  final bool isAdmin;

  const _CouncilCard({required this.council, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    final isJoined = council['isJoined'] == true;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header: Logo + Name + Theme ──────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: CachedNetworkImage(
                    imageUrl: council['logo'],
                    height: 64,
                    width: 64,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(
                      height: 64,
                      width: 64,
                      color: const Color(0xFF2A2A2A),
                      child: const Icon(Icons.groups,
                          color: Colors.white24, size: 28),
                    ),
                    errorWidget: (_, __, ___) => Container(
                      height: 64,
                      width: 64,
                      color: const Color(0xFF2A2A2A),
                      child: const Icon(Icons.groups,
                          color: Colors.white24, size: 28),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // Name + Theme
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        council['name'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        council['theme'],
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Admin badge
                      Row(
                        children: [
                          const Icon(Icons.person_outline,
                              color: Colors.white38, size: 13),
                          const SizedBox(width: 4),
                          Text(
                            '${council['adminName']} · ${council['adminRole']}',
                            style: const TextStyle(
                              color: Colors.white38,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Admin menu
                if (isAdmin)
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert,
                        color: Colors.white38, size: 20),
                    color: const Color(0xFF2A2A2A),
                    onSelected: (val) {
                      // TODO: handle edit / delete
                    },
                    itemBuilder: (_) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Text('Edit',
                            style: TextStyle(color: Colors.white)),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete',
                            style: TextStyle(color: Colors.redAccent)),
                      ),
                    ],
                  ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // ── About ────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              council['about'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white60,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // ── Stats row ────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                _StatChip(
                  icon: Icons.hub_outlined,
                  label: '${council['clubCount']} Clubs',
                ),
                const SizedBox(width: 10),
                _StatChip(
                  icon: Icons.people_outline,
                  label: '${council['memberCount']} Members',
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // ── Divider ──────────────────────────────────────────
          Divider(color: Colors.white.withOpacity(0.06), height: 1),

          // ── Action Button ────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
            child: isAdmin
                ? Row(
                    children: [
                      Expanded(
                        child: _ActionButton(
                          label: 'Manage Members',
                          icon: Icons.people,
                          onTap: () {
                            // TODO: navigate to members page
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _ActionButton(
                          label: 'Post Update',
                          icon: Icons.campaign_outlined,
                          onTap: () {
                            // TODO: navigate to post announcement
                          },
                        ),
                      ),
                    ],
                  )
                : _ActionButton(
                    label: isJoined ? 'View Council' : 'Join Council',
                    icon: isJoined ? Icons.arrow_forward : Icons.add,
                    onTap: () {
                      if (isJoined) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const CouncilDetailPage(),
                          ),
                        );
                      } else {
                        // TODO: join council API
                      }
                    },
                    filled: !isJoined,
                  ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// STAT CHIP
// ─────────────────────────────────────────────────────────────

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _StatChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white38, size: 13),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(color: Colors.white54, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// ACTION BUTTON
// ─────────────────────────────────────────────────────────────

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool filled;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.onTap,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: filled ? Colors.white : Colors.white.withOpacity(0.06),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: 16, color: filled ? Colors.black : Colors.white70),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: filled ? Colors.black : Colors.white70,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}