import 'package:akalpit/features/services/list.dart';
import 'package:flutter/material.dart';
import './sidedrawer.dart';

import 'package:cached_network_image/cached_network_image.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> services = const [
    {'title': 'Restaurants', 'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png'},
    {'title': 'Hotels', 'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png'},
    {'title': 'Beauty Spa', 'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png'},
    {'title': 'Home Decor', 'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png'},
    {'title': 'Wedding Planning', 'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png'},
    {'title': 'Education', 'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png'},
    {'title': 'Hospitals', 'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png'},
  ];

  List<Map<String, String>> get filteredServices {
    final query = _searchController.text.toLowerCase().trim();

    /// 🔍 Filter ONLY education
    if (query == 'education') {
      return services.where((e) => e['title'] == 'Education').toList();
    }

    return services;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, drawer: const ServicesSideDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text('Services'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          /// 🔍 Search + Breadcrumbs
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Breadcrumbs
               
                /// Search
                TextField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search (try: education)',
                    hintStyle: const TextStyle(color: Colors.white54),
                    prefixIcon: const Icon(Icons.search, color: Colors.white70),
                    filled: true,
                    fillColor: Colors.grey.shade900,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
  const Text('gorakhpur', style: TextStyle(color: Colors.white)),
          /// 🧾 List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredServices.length,
              itemBuilder: (context, index) {
                final service = filteredServices[index];
                return ServiceCard(
                  title: service['title']!,
                  image: service['image']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String title;
  final String image;

  const ServiceCard({
    super.key,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🖼 Image Section
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: CachedNetworkImage(
              imageUrl: image,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                height: 180,
                color: Colors.grey.shade800,
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                height: 180,
                color: Colors.grey.shade800,
                child: const Center(
                  child: Icon(Icons.broken_image, color: Colors.white, size: 40),
                ),
              ),
            ),
          ),

          /// 📄 Lower Body
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  '120+ Services Available',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 12),

                /// 🔘 Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  onPressed: () {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => ServiceProvidersPage(),
    ),
  );
},

                    child: const Text(
                      'View List',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
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
