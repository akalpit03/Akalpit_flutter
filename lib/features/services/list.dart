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
      'time': '9 AM - 10 PM'
    },
    {
      'name': 'EduSmart Classes',
      'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
      'rating': 4.2,
      'address': 'Sector 18, Noida',
      'days': 'Mon - Sat',
      'time': '8 AM - 9 PM'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text('Service Providers'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 8,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Image
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: CachedNetworkImage(
                  imageUrl: provider['image'],
                  height: 90,
                  width: 90,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    height: 90,
                    width: 90,
                    color: Colors.grey.shade800,
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 90,
                    width: 90,
                    color: Colors.grey.shade800,
                    child: const Icon(Icons.broken_image, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              /// Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      provider['name'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),

                    /// Rating
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          provider['rating'].toString(),
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    /// Address
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.location_on_outlined, color: Colors.white54, size: 18),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            provider['address'],
                            style: const TextStyle(color: Colors.white54),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    /// Availability
                    Row(
                      children: [
                        const Icon(Icons.calendar_today_outlined, color: Colors.white54, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          provider['days'],
                          style: const TextStyle(color: Colors.white54),
                        ),
                        const SizedBox(width: 10),
                        const Icon(Icons.access_time, color: Colors.white54, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          provider['time'],
                          style: const TextStyle(color: Colors.white54),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// Button
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
      builder: (context) => InstitutionPage(),
    ),
  );
},
              child: const Text(
                'View Services',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
