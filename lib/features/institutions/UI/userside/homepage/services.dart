 
import 'package:akalpit/features/institutions/UI/userside/homepage/list.dart';
import 'package:akalpit/features/institutions/UI/userside/sidedrawer.dart';
 
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
 
 

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  final TextEditingController _searchController = TextEditingController();
  final PageController _adController = PageController();
  int _currentAdIndex = 0;

  // ─── Ad Banners ───────────────────────────────────────────────
  final List<Map<String, String>> adBanners = const [
    {
      'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
      'label': '🔥 Special Offer Today!',
    },
    {
      'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
      'label': '🎉 New Restaurants Near You',
    },
    {
      'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
      'label': '💆 Spa & Wellness Deals',
    },
  ];

  // ─── Services Data ────────────────────────────────────────────
  final List<Map<String, dynamic>> serviceCategories = const [
    {
      'title': 'Education',
      'items': [
        {'name': 'ABC School', 'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png'},
        {'name': 'ABC College', 'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png'},
        {'name': 'XYZ Academy', 'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png'},
        {'name': 'City University', 'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png'},
      ],
    },
    {
      'title': 'Restaurants',
      'items': [
        {'name': 'Spice Garden', 'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png'},
        {'name': 'The Biryani House', 'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png'},
        {'name': 'Cafe Mocha', 'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png'},
        {'name': 'Royal Dine', 'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png'},
      ],
    },
    {
      'title': 'Hotels',
      'items': [
        {'name': 'Grand Palace', 'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png'},
        {'name': 'City Inn', 'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png'},
        {'name': 'Comfort Stay', 'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png'},
      ],
    },
    {
      'title': 'Beauty Spa',
      'items': [
        {'name': 'Glow Studio', 'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png'},
        {'name': 'Zen Spa', 'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png'},
        {'name': 'Luxe Salon', 'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png'},
      ],
    },
    {
      'title': 'Hospitals',
      'items': [
        {'name': 'City Hospital', 'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png'},
        {'name': 'Apollo Clinic', 'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png'},
        {'name': 'LifeCare', 'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png'},
      ],
    },
    {
      'title': 'Wedding Planning',
      'items': [
        {'name': 'Dream Weddings', 'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png'},
        {'name': 'Royal Events', 'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png'},
        {'name': 'The Wedding Co.', 'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png'},
      ],
    },
    {
      'title': 'Home Decor',
      'items': [
        {'name': 'Interior Hub', 'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png'},
        {'name': 'Deco Studio', 'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png'},
        {'name': 'Cozy Homes', 'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png'},
      ],
    },
  ];

  List<Map<String, dynamic>> get filteredCategories {
    final query = _searchController.text.toLowerCase().trim();
    if (query.isEmpty) return serviceCategories;

    return serviceCategories
        .where((cat) =>
            cat['title'].toString().toLowerCase().contains(query) ||
            (cat['items'] as List).any((item) =>
                item['name'].toString().toLowerCase().contains(query)))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _startAdTimer();
  }

  void _startAdTimer() {
    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      final nextIndex = (_currentAdIndex + 1) % adBanners.length;
      _adController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      setState(() => _currentAdIndex = nextIndex);
      _startAdTimer();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _adController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: const ServicesSideDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Services',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // ─── Search Bar ───────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search services...',
                hintStyle: const TextStyle(color: Colors.white38),
                prefixIcon: const Icon(Icons.search, color: Colors.white54),
                filled: true,
                fillColor: const Color(0xFF1C1C1C),
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // ─── Scrollable Body ──────────────────────────────────
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 24),
              children: [
                // ─── Ad Banner ──────────────────────────────────
                _AdBannerSection(
                  adBanners: adBanners,
                  controller: _adController,
                  currentIndex: _currentAdIndex,
                  onPageChanged: (i) => setState(() => _currentAdIndex = i),
                ),

                const SizedBox(height: 20),

                // ─── Service Categories ──────────────────────────
                ...filteredCategories.map((category) {
                  return _ServiceCategorySection(
                    title: category['title'] as String,
                    items: List<Map<String, String>>.from(
                      (category['items'] as List).map(
                        (e) => Map<String, String>.from(e as Map),
                      ),
                    ),
                    onSeeMore: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ServiceProvidersPage(),
                        ),
                      );
                    },
                    onItemTap: (item) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ServiceProvidersPage(),
                        ),
                      );
                    },
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// AD BANNER SECTION
// ─────────────────────────────────────────────────────────────────────────────

class _AdBannerSection extends StatelessWidget {
  final List<Map<String, String>> adBanners;
  final PageController controller;
  final int currentIndex;
  final ValueChanged<int> onPageChanged;

  const _AdBannerSection({
    required this.adBanners,
    required this.controller,
    required this.currentIndex,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Banner
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              height: 160,
              child: PageView.builder(
                controller: controller,
                onPageChanged: onPageChanged,
                itemCount: adBanners.length,
                itemBuilder: (context, index) {
                  final ad = adBanners[index];
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(
                        imageUrl: ad['image']!,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => Container(
                          color: const Color(0xFF1C1C1C),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white30,
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                        errorWidget: (_, __, ___) => Container(
                          color: const Color(0xFF1C1C1C),
                          child: const Icon(Icons.image,
                              color: Colors.white24, size: 40),
                        ),
                      ),
                      // Gradient overlay
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.75),
                            ],
                          ),
                        ),
                      ),
                      // Label
                      Positioned(
                        bottom: 14,
                        left: 14,
                        child: Text(
                          ad['label']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Dot indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(adBanners.length, (i) {
              final isActive = i == currentIndex;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: isActive ? 20 : 6,
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
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SERVICE CATEGORY SECTION
// ─────────────────────────────────────────────────────────────────────────────

class _ServiceCategorySection extends StatelessWidget {
  final String title;
  final List<Map<String, String>> items;
  final VoidCallback onSeeMore;
  final ValueChanged<Map<String, String>> onItemTap;

  const _ServiceCategorySection({
    required this.title,
    required this.items,
    required this.onSeeMore,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── Title Row ──────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
                GestureDetector(
                  onTap: onSeeMore,
                  child: const Text(
                    'See more',
                    style: TextStyle(
                      color: Color(0xFF888888),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ─── Horizontal Item List ────────────────────────────
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return _ServiceItemCard(
                  name: item['name']!,
                  image: item['image']!,
                  onTap: () => onItemTap(item),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SERVICE ITEM CARD
// ─────────────────────────────────────────────────────────────────────────────

class _ServiceItemCard extends StatelessWidget {
  final String name;
  final String image;
  final VoidCallback onTap;

  const _ServiceItemCard({
    required this.name,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(14),
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
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(14)),
              child: CachedNetworkImage(
                imageUrl: image,
                height: 95,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(
                  height: 95,
                  color: const Color(0xFF2A2A2A),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white24,
                      strokeWidth: 1.5,
                    ),
                  ),
                ),
                errorWidget: (_, __, ___) => Container(
                  height: 95,
                  color: const Color(0xFF2A2A2A),
                  child: const Center(
                    child: Icon(Icons.broken_image,
                        color: Colors.white24, size: 28),
                  ),
                ),
              ),
            ),

            // Name
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 7, 8, 0),
              child: Text(
                name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}