import 'package:akalpit/features/services/institution.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ServiceProvidersPage extends StatelessWidget {
  const ServiceProvidersPage({super.key});

  final List<Map<String, dynamic>> providers = const [
    {
      'name': 'Bright Future Academy',
      'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
      'rating': 4.5,
      'address': 'MG Road, New Delhi',
      'days': 'Sun - Tue',
      'time': '9 AM - 10 PM',
    },
    {
      'name': 'EduSmart Classes',
      'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
      'rating': 4.2,
      'address': 'Sector 18, Noida',
      'days': 'Mon - Sat',
      'time': '8 AM - 9 PM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Service Providers',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        itemCount: providers.length,
        itemBuilder: (context, index) {
          return ServiceProviderCard(provider: providers[index]);
        },
      ),
    );
  }
}

class ServiceProviderCard extends StatelessWidget {
  final Map<String, dynamic> provider;

  const ServiceProviderCard({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Top Image ───────────────────────────────────────────
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: provider['image'],
                  height: 170,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(
                    height: 170,
                    color: const Color(0xFF2A2A2A),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white30,
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                  errorWidget: (_, __, ___) => Container(
                    height: 170,
                    color: const Color(0xFF2A2A2A),
                    child: const Center(
                      child: Icon(Icons.broken_image,
                          color: Colors.white24, size: 40),
                    ),
                  ),
                ),

                // Gradient over image
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),
                ),

                // Rating badge
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.65),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star_rounded,
                            color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          provider['rating'].toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Info Body ───────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                Text(
                  provider['name'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.2,
                  ),
                ),

                const SizedBox(height: 10),

                // Address + Availability row
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined,
                        color: Colors.white38, size: 15),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        provider['address'],
                        style: const TextStyle(
                            color: Colors.white54, fontSize: 13),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                // Days + Time
                Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined,
                        color: Colors.white38, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      provider['days'],
                      style:
                          const TextStyle(color: Colors.white54, fontSize: 13),
                    ),
                    const SizedBox(width: 14),
                    const Icon(Icons.access_time_rounded,
                        color: Colors.white38, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      provider['time'],
                      style:
                          const TextStyle(color: Colors.white54, fontSize: 13),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // Divider
                Divider(color: Colors.white.withOpacity(0.07), height: 1),

                const SizedBox(height: 14),

                // Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => InstitutionPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'View Services',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
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