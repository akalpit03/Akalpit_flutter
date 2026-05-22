import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// DUMMY CLUBS for search modal
// ─────────────────────────────────────────────────────────────

const _dummyClubs = [
  {
    'id': 'c1',
    'name': 'Vivek Poetry Club',
    'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
    'members': 45,
  },
  {
    'id': 'c2',
    'name': 'Robotics Club',
    'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
    'members': 60,
  },
  {
    'id': 'c3',
    'name': 'Photography Club',
    'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
    'members': 38,
  },
  {
    'id': 'c4',
    'name': 'Debate Society',
    'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
    'members': 52,
  },
  {
    'id': 'c5',
    'name': 'Music Club',
    'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
    'members': 70,
  },
  {
    'id': 'c6',
    'name': 'Coding Club',
    'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
    'members': 90,
  },
];

// ─────────────────────────────────────────────────────────────
// CREATE COUNCIL PAGE
// ─────────────────────────────────────────────────────────────

class CreateCouncilPage extends StatefulWidget {
  const CreateCouncilPage({super.key});

  @override
  State<CreateCouncilPage> createState() => _CreateCouncilPageState();
}

class _CreateCouncilPageState extends State<CreateCouncilPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _aboutController = TextEditingController();

  String? _logoUrl;
  bool _isLoading = false;

  // Admins: { id, name, avatar, designation }
  final List<Map<String, dynamic>> _selectedAdmins = [];

  // Clubs requested to join this council
  final List<Map<String, dynamic>> _requestedClubs = [];

  @override
  void dispose() {
    _nameController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  void _openAdminSearchModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _AdminSearchModal(
        alreadyAdded:
            _selectedAdmins.map((a) => a['id'] as String).toList(),
        onSelect: (user) {
          setState(() {
            if (!_selectedAdmins.any((a) => a['id'] == user['id'])) {
              _selectedAdmins.add({
                ...Map<String, dynamic>.from(user),
                'designation': '',
              });
            }
          });
        },
      ),
    );
  }

  void _removeAdmin(String id) {
    setState(() => _selectedAdmins.removeWhere((a) => a['id'] == id));
  }

  void _openClubSearchModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _ClubSearchModal(
        alreadyAdded: _requestedClubs.map((c) => c['id'] as String).toList(),
        onRequest: (club) {
          setState(() {
            if (!_requestedClubs.any((c) => c['id'] == club['id'])) {
              _requestedClubs.add(Map<String, dynamic>.from(club));
            }
          });
        },
      ),
    );
  }

  void _removeClub(String id) {
    setState(() => _requestedClubs.removeWhere((c) => c['id'] == id));
  }

  Future<void> _onSubmit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isLoading = true);

    // TODO: wire API call here
    await Future.delayed(const Duration(seconds: 1)); // simulate

    if (!mounted) return;
    setState(() => _isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Council created successfully!'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.of(context).pop();
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
          'Create Council',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
          children: [
            // ── Logo Picker ──────────────────────────────────
            _SectionLabel('Council Logo'),
            const SizedBox(height: 10),
            Center(
              child: GestureDetector(
                onTap: () {
                  // TODO: image picker
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white12,
                      width: 1.5,
                    ),
                  ),
                  child: _logoUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: CachedNetworkImage(
                            imageUrl: _logoUrl!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo_outlined,
                                color: Colors.white38, size: 28),
                            SizedBox(height: 6),
                            Text(
                              'Upload Logo',
                              style: TextStyle(
                                  color: Colors.white38, fontSize: 11),
                            ),
                          ],
                        ),
                ),
              ),
            ),

            const SizedBox(height: 28),

            // ── Council Name ─────────────────────────────────
            _SectionLabel('Council Name'),
            const SizedBox(height: 8),
            _InputField(
              controller: _nameController,
              hint: 'e.g. Student Council CSJMU',
              validator: (v) =>
                  (v == null || v.isEmpty) ? 'Council name is required' : null,
            ),

            const SizedBox(height: 20),

            // ── About ────────────────────────────────────────
            _SectionLabel('About'),
            const SizedBox(height: 8),
            _InputField(
              controller: _aboutController,
              hint: 'Describe what this council is about...',
              maxLines: 3,
              validator: (v) =>
                  (v == null || v.isEmpty) ? 'About is required' : null,
            ),

            const SizedBox(height: 28),

            // ── Council Admins ───────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _SectionLabel('Council Admins'),
                GestureDetector(
                  onTap: _openAdminSearchModal,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.person_add_outlined,
                            color: Colors.white70, size: 16),
                        SizedBox(width: 4),
                        Text(
                          'Add Admin',
                          style: TextStyle(
                              color: Colors.white70, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            if (_selectedAdmins.isEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white10),
                ),
                child: const Center(
                  child: Text(
                    'No admins added yet.\nSearch and add members as admins.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white38, fontSize: 13),
                  ),
                ),
              )
            else
              ...(_selectedAdmins.map((admin) => _AdminTile(
                    admin: admin,
                    onDesignationChanged: (val) {
                      setState(() => admin['designation'] = val);
                    },
                    onRemove: () => _removeAdmin(admin['id']),
                  ))),

            const SizedBox(height: 28),

            // ── Add Clubs ────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _SectionLabel('Add Clubs'),
                GestureDetector(
                  onTap: _openClubSearchModal,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.add, color: Colors.white70, size: 16),
                        SizedBox(width: 4),
                        Text(
                          'Search & Add',
                          style:
                              TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Requested clubs list
            if (_requestedClubs.isEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white10),
                ),
                child: const Center(
                  child: Text(
                    'No clubs added yet.\nSearch and send requests to clubs.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white38, fontSize: 13),
                  ),
                ),
              )
            else
              ...(_requestedClubs.map((club) => _RequestedClubTile(
                    club: club,
                    onRemove: () => _removeClub(club['id']),
                  ))),

            const SizedBox(height: 36),

            // ── Submit ───────────────────────────────────────
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _onSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.black,
                        ),
                      )
                    : const Text(
                        'Create Council',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// CLUB SEARCH MODAL
// ─────────────────────────────────────────────────────────────

class _ClubSearchModal extends StatefulWidget {
  final List<String> alreadyAdded;
  final ValueChanged<Map<String, dynamic>> onRequest;

  const _ClubSearchModal({
    required this.alreadyAdded,
    required this.onRequest,
  });

  @override
  State<_ClubSearchModal> createState() => _ClubSearchModalState();
}

class _ClubSearchModalState extends State<_ClubSearchModal> {
  final _searchController = TextEditingController();
  String _query = '';
  final Set<String> _requested = {};

  List<Map<String, dynamic>> get _filtered {
    return List<Map<String, dynamic>>.from(_dummyClubs).where((c) {
      final matchesQuery =
          c['name'].toString().toLowerCase().contains(_query);
      return matchesQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      maxChildSize: 0.92,
      minChildSize: 0.5,
      builder: (_, scrollController) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                'Search Clubs',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              // Search field
              TextField(
                controller: _searchController,
                autofocus: true,
                onChanged: (v) =>
                    setState(() => _query = v.toLowerCase().trim()),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Type club name...',
                  hintStyle: const TextStyle(color: Colors.white38),
                  prefixIcon:
                      const Icon(Icons.search, color: Colors.white38, size: 20),
                  filled: true,
                  fillColor: const Color(0xFF2A2A2A),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: _filtered.length,
                  itemBuilder: (_, index) {
                    final club = _filtered[index];
                    final isAdded =
                        widget.alreadyAdded.contains(club['id']) ||
                            _requested.contains(club['id']);

                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF242424),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: club['image'],
                              height: 46,
                              width: 46,
                              fit: BoxFit.cover,
                              errorWidget: (_, __, ___) => Container(
                                height: 46,
                                width: 46,
                                color: const Color(0xFF333333),
                                child: const Icon(Icons.groups,
                                    color: Colors.white24),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
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
                                Text(
                                  '${club['members']} members',
                                  style: const TextStyle(
                                    color: Colors.white38,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: isAdded
                                ? null
                                : () {
                                    setState(() =>
                                        _requested.add(club['id']));
                                    widget.onRequest(club);
                                  },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 7),
                              decoration: BoxDecoration(
                                color: isAdded
                                    ? Colors.white10
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                isAdded ? 'Requested' : 'Request',
                                style: TextStyle(
                                  color: isAdded
                                      ? Colors.white38
                                      : Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────
// REQUESTED CLUB TILE
// ─────────────────────────────────────────────────────────────

class _RequestedClubTile extends StatelessWidget {
  final Map<String, dynamic> club;
  final VoidCallback onRemove;

  const _RequestedClubTile({required this.club, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: club['image'],
              height: 44,
              width: 44,
              fit: BoxFit.cover,
              errorWidget: (_, __, ___) => Container(
                height: 44,
                width: 44,
                color: const Color(0xFF2A2A2A),
                child: const Icon(Icons.groups, color: Colors.white24),
              ),
            ),
          ),
          const SizedBox(width: 12),
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
                const Text(
                  'Request sent',
                  style: TextStyle(color: Colors.white38, fontSize: 12),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(Icons.close, color: Colors.white38, size: 20),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// DUMMY USERS for admin search
// ─────────────────────────────────────────────────────────────

const _dummyUsers = [
  {
    'id': 'u1',
    'name': 'Anurag Chauhan',
    'username': 'anurag30',
    'avatar': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
  },
  {
    'id': 'u2',
    'name': 'Priya Sharma',
    'username': 'priya_s',
    'avatar': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
  },
  {
    'id': 'u3',
    'name': 'Rahul Verma',
    'username': 'rahul_v',
    'avatar': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
  },
  {
    'id': 'u4',
    'name': 'Neha Singh',
    'username': 'neha_singh',
    'avatar': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
  },
  {
    'id': 'u5',
    'name': 'Abhay Pratap',
    'username': 'abhay_2003',
    'avatar': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
  },
];

// ─────────────────────────────────────────────────────────────
// ADMIN SEARCH MODAL
// ─────────────────────────────────────────────────────────────

class _AdminSearchModal extends StatefulWidget {
  final List<String> alreadyAdded;
  final ValueChanged<Map<String, dynamic>> onSelect;

  const _AdminSearchModal({
    required this.alreadyAdded,
    required this.onSelect,
  });

  @override
  State<_AdminSearchModal> createState() => _AdminSearchModalState();
}

class _AdminSearchModalState extends State<_AdminSearchModal> {
  final _searchController = TextEditingController();
  String _query = '';
  final Set<String> _selected = {};

  List<Map<String, dynamic>> get _filtered {
    return List<Map<String, dynamic>>.from(_dummyUsers).where((u) {
      return u['name'].toString().toLowerCase().contains(_query) ||
          u['username'].toString().toLowerCase().contains(_query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      maxChildSize: 0.92,
      minChildSize: 0.5,
      builder: (_, scrollController) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40, height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Add Admin',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _searchController,
                autofocus: true,
                onChanged: (v) =>
                    setState(() => _query = v.toLowerCase().trim()),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search by name or username...',
                  hintStyle: const TextStyle(color: Colors.white38),
                  prefixIcon: const Icon(Icons.search,
                      color: Colors.white38, size: 20),
                  filled: true,
                  fillColor: const Color(0xFF2A2A2A),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: _filtered.length,
                  itemBuilder: (_, index) {
                    final user = _filtered[index];
                    final isAdded = widget.alreadyAdded.contains(user['id']) ||
                        _selected.contains(user['id']);

                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF242424),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(22),
                            child: CachedNetworkImage(
                              imageUrl: user['avatar'],
                              height: 44,
                              width: 44,
                              fit: BoxFit.cover,
                              errorWidget: (_, __, ___) => Container(
                                height: 44, width: 44,
                                color: const Color(0xFF333333),
                                child: const Icon(Icons.person,
                                    color: Colors.white24),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user['name'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  '@${user['username']}',
                                  style: const TextStyle(
                                      color: Colors.white38, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: isAdded
                                ? null
                                : () {
                                    setState(() =>
                                        _selected.add(user['id']));
                                    widget.onSelect(user);
                                    Navigator.of(context).pop();
                                  },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 7),
                              decoration: BoxDecoration(
                                color: isAdded
                                    ? Colors.white10
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                isAdded ? 'Added' : 'Select',
                                style: TextStyle(
                                  color: isAdded
                                      ? Colors.white38
                                      : Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────
// ADMIN TILE — shows selected admin with designation input
// ─────────────────────────────────────────────────────────────

class _AdminTile extends StatelessWidget {
  final Map<String, dynamic> admin;
  final ValueChanged<String> onDesignationChanged;
  final VoidCallback onRemove;

  const _AdminTile({
    required this.admin,
    required this.onDesignationChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: CachedNetworkImage(
              imageUrl: admin['avatar'],
              height: 44,
              width: 44,
              fit: BoxFit.cover,
              errorWidget: (_, __, ___) => Container(
                height: 44, width: 44,
                color: const Color(0xFF2A2A2A),
                child: const Icon(Icons.person, color: Colors.white24),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Name + designation field
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  admin['name'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  '@${admin['username']}',
                  style: const TextStyle(
                      color: Colors.white38, fontSize: 12),
                ),
                const SizedBox(height: 8),
                // Designation input
                TextFormField(
                  initialValue: admin['designation'],
                  onChanged: onDesignationChanged,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                  decoration: InputDecoration(
                    hintText: 'Designation (e.g. President)',
                    hintStyle: const TextStyle(
                        color: Colors.white24, fontSize: 13),
                    filled: true,
                    fillColor: const Color(0xFF262626),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.white24),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Remove
          GestureDetector(
            onTap: onRemove,
            child: const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(Icons.close, color: Colors.white38, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;
  final String? Function(String?)? validator;

  const _InputField({
    required this.controller,
    required this.hint,
    this.maxLines = 1,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white38, fontSize: 14),
        filled: true,
        fillColor: const Color(0xFF1A1A1A),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.white24),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
      ),
    );
  }
}