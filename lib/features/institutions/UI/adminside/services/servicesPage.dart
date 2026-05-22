import 'package:akalpit/features/institutions/UI/adminside/services/createServices.dart';
import 'package:akalpit/features/institutions/UI/adminside/services/displaySingleService.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
 

// ─────────────────────────────────────────────────────────────
// DUMMY DATA
// ─────────────────────────────────────────────────────────────

final _dummyAds = [
  {
    'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
    'label': '🎓 Admissions Open 2025 — Apply Now!',
  },
  {
    'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
    'label': '🏋️ Sports Complex — Now Fully Renovated',
  },
  {
    'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
    'label': '🏨 Hostel Bookings Open for 2025-26',
  },
];

final List<Map<String, dynamic>> dummyServices = [
  {
    'id': 'svc_01',
    'name': 'Sports Complex',
    'category': 'Sports & Fitness',
    'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
    'rating': 4.7,
    'startingPrice': 200.0,
    'amenities': [
      {'name': 'Basketball Court', 'price': 500.0},
      {'name': 'Swimming Pool', 'price': 300.0},
      {'name': 'Gymnasium', 'price': 200.0},
      {'name': 'Locker Room', 'price': 100.0},
      {'name': 'Equipment Kit', 'price': 150.0},
    ],
  },
  {
    'id': 'svc_02',
    'name': 'University Hostel',
    'category': 'Accommodation',
    'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
    'rating': 4.2,
    'startingPrice': 1500.0,
    'amenities': [
      {'name': 'Single Room', 'price': 1500.0},
      {'name': 'Double Room', 'price': 1000.0},
      {'name': 'Meals (3x)', 'price': 500.0},
      {'name': 'WiFi Access', 'price': 200.0},
      {'name': 'Laundry', 'price': 100.0},
    ],
  },
  {
    'id': 'svc_03',
    'name': 'Seminar Hall',
    'category': 'Events & Venues',
    'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
    'rating': 4.5,
    'startingPrice': 3000.0,
    'amenities': [
      {'name': 'Hall A (200 seats)', 'price': 3000.0},
      {'name': 'Hall B (100 seats)', 'price': 1500.0},
      {'name': 'Projector & Screen', 'price': 500.0},
      {'name': 'Mic & Sound System', 'price': 700.0},
      {'name': 'Catering (per head)', 'price': 150.0},
    ],
  },
  {
    'id': 'svc_04',
    'name': 'Botanical Garden',
    'category': 'Outdoor',
    'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
    'rating': 4.8,
    'startingPrice': 100.0,
    'amenities': [
      {'name': 'Garden Entry', 'price': 100.0},
      {'name': 'Photography Permit', 'price': 300.0},
      {'name': 'Guided Tour', 'price': 200.0},
    ],
  },
  {
    'id': 'svc_05',
    'name': 'Admissions Counselling',
    'category': 'Academic',
    'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
    'rating': 4.6,
    'startingPrice': 500.0,
    'amenities': [
      {'name': '1:1 Session (60 min)', 'price': 500.0},
      {'name': 'Course Brochure Pack', 'price': 100.0},
      {'name': 'Mock Interview', 'price': 400.0},
    ],
  },
];

// ─────────────────────────────────────────────────────────────
// INSTITUTION HOME PAGE
// ─────────────────────────────────────────────────────────────

class InstitutionHomePage extends StatefulWidget {
  final bool isAdmin;

  const InstitutionHomePage({super.key, this.isAdmin = true});

  @override
  State<InstitutionHomePage> createState() => _InstitutionHomePageState();
}

class _InstitutionHomePageState extends State<InstitutionHomePage> {
  final PageController _adController = PageController();
  int _currentAd = 0;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  late List<Map<String, dynamic>> _services;

  @override
  void initState() {
    super.initState();
    _services = List<Map<String, dynamic>>.from(
      dummyServices.map((s) => Map<String, dynamic>.from(s)),
    );
    _startAdTimer();
  }

  void _startAdTimer() {
    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      final next = (_currentAd + 1) % _dummyAds.length;
      _adController.animateToPage(
        next,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      setState(() => _currentAd = next);
      _startAdTimer();
    });
  }

  @override
  void dispose() {
    _adController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filtered {
    if (_searchQuery.isEmpty) return _services;
    return _services.where((s) {
      return s['name'].toString().toLowerCase().contains(_searchQuery) ||
          s['category'].toString().toLowerCase().contains(_searchQuery);
    }).toList();
  }

  void _deleteService(String id) {
    setState(() => _services.removeWhere((s) => s['id'] == id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Column(
          children: const [
            Text(
              'CSJMU University', // TODO: pull from Redux
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              'Kanpur, Uttar Pradesh',
              style: TextStyle(color: Colors.white38, fontSize: 11),
            ),
          ],
        ),
      ),
      floatingActionButton: widget.isAdmin
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const CreateServicePage(),
                  ),
                );
              },
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              icon: const Icon(Icons.add),
              label: const Text(
                'Add Service',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            )
          : null,
      body: ListView(
        children: [
          // ── Ad Banner ────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SizedBox(
                    height: 155,
                    child: PageView.builder(
                      controller: _adController,
                      onPageChanged: (i) => setState(() => _currentAd = i),
                      itemCount: _dummyAds.length,
                      itemBuilder: (_, i) {
                        final ad = _dummyAds[i];
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImage(
                              imageUrl: ad['image']!,
                              fit: BoxFit.cover,
                              placeholder: (_, __) => Container(
                                  color: const Color(0xFF1A1A1A)),
                              errorWidget: (_, __, ___) =>
                                  Container(color: const Color(0xFF1A1A1A)),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.7),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 12,
                              left: 14,
                              right: 14,
                              child: Text(
                                ad['label']!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Dot indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_dummyAds.length, (i) {
                    final isActive = i == _currentAd;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: isActive ? 18 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: isActive ? Colors.white : Colors.white24,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ── Search ───────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              onChanged: (v) =>
                  setState(() => _searchQuery = v.toLowerCase().trim()),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search services...',
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

          const SizedBox(height: 20),

          // ── Services Label ───────────────────────────────────
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Our Services',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // ── Services List ────────────────────────────────────
          if (_filtered.isEmpty)
            const Padding(
              padding: EdgeInsets.all(32),
              child: Center(
                child: Text('No services found.',
                    style: TextStyle(color: Colors.white38)),
              ),
            )
          else
            ...(_filtered.map((service) => _ServiceCard(
                  service: service,
                  isAdmin: widget.isAdmin,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ServiceDetailPage(
                          service: service,
                          isAdmin: widget.isAdmin,
                        ),
                      ),
                    );
                  },
                  onDelete: () => _deleteService(service['id']),
                ))),

          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// SERVICE CARD
// ─────────────────────────────────────────────────────────────

class _ServiceCard extends StatelessWidget {
  final Map<String, dynamic> service;
  final bool isAdmin;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _ServiceCard({
    required this.service,
    required this.isAdmin,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final amenities =
        List<Map<String, dynamic>>.from(service['amenities'] as List);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 14),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(18)),
                  child: CachedNetworkImage(
                    imageUrl: service['image'],
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(
                      height: 160,
                      color: const Color(0xFF2A2A2A),
                    ),
                    errorWidget: (_, __, ___) => Container(
                      height: 160,
                      color: const Color(0xFF2A2A2A),
                      child: const Icon(Icons.image_outlined,
                          color: Colors.white12, size: 40),
                    ),
                  ),
                ),
                // Category chip
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.65),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      service['category'],
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                // Admin menu
                if (isAdmin)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: PopupMenuButton<String>(
                      icon: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.more_vert,
                            color: Colors.white, size: 18),
                      ),
                      color: const Color(0xFF2A2A2A),
                      onSelected: (val) {
                        if (val == 'edit') {
                          // TODO: navigate to edit service
                        } else if (val == 'delete') {
                          onDelete();
                        }
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
                  ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        service['name'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded,
                              color: Colors.amber, size: 15),
                          const SizedBox(width: 3),
                          Text(
                            '${service['rating']}',
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Amenities preview
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: amenities
                        .take(3)
                        .map((a) => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.06),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                a['name'],
                                style: const TextStyle(
                                    color: Colors.white54, fontSize: 11),
                              ),
                            ))
                        .toList()
                      ..addAll(amenities.length > 3
                          ? [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.06),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  '+${amenities.length - 3} more',
                                  style: const TextStyle(
                                      color: Colors.white38,
                                      fontSize: 11),
                                ),
                              )
                            ]
                          : []),
                  ),

                  const SizedBox(height: 10),

                  // Starting price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Starting from ',
                              style: TextStyle(
                                  color: Colors.white38, fontSize: 12),
                            ),
                            TextSpan(
                              text:
                                  '₹${service['startingPrice'].toStringAsFixed(0)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 7),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          isAdmin ? 'View' : 'Book Now',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}