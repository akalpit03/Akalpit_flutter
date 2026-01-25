import 'package:flutter/material.dart';

class InstitutionPage extends StatefulWidget {
  const InstitutionPage({super.key});

  @override
  State<InstitutionPage> createState() => _InstitutionPageState();
}

class _InstitutionPageState extends State<InstitutionPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> services = [
    'Consultation',
    'Training Program',
    'Workshops',
    'Online Classes',
    'Certifications',
  ];

  final Map<String, int> quotationCart = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f',
              ),
              radius: 18,
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'ABC Institution',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {},
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Services'),
            Tab(text: 'Quotation'),
            Tab(text: 'About'),
            Tab(text: 'Gallery'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // _servicesTab(),
          _quotationTab(),
          _aboutTab(),
          _galleryTab(),
        ],
      ),
    );
  }

  /// SERVICES TAB
  Widget _servicesTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: services.length,
      itemBuilder: (context, index) {
        return Card(
          color: const Color(0xFF1C1C1E),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            title: Text(
              services[index],
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: const Text(
              'Starting from ₹999',
              style: TextStyle(color: Colors.grey),
            ),
            trailing: ElevatedButton(
              onPressed: () {
                setState(() {
                  quotationCart.update(services[index], (v) => v + 1,
                      ifAbsent: () => 1);
                });
              },
              child: const Text('Add'),
            ),
          ),
        );
      },
    );
  }

  /// QUOTATION TAB
  Widget _quotationTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: quotationCart.isEmpty
          ? const Center(
              child: Text(
                'No services added for quotation',
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListView(
              children: quotationCart.entries.map((entry) {
                return Card(
                  color: const Color(0xFF1C1C1E),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text(entry.key,
                        style: const TextStyle(color: Colors.white)),
                    subtitle: Text('Quantity: ${entry.value}',
                        style: const TextStyle(color: Colors.grey)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              if (entry.value > 1) {
                                quotationCart[entry.key] = entry.value - 1;
                              }
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.add, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              quotationCart[entry.key] = entry.value + 1;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
    );
  }

  /// ABOUT TAB (OYO STYLE)
  Widget _aboutTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _aboutTile(Icons.call, 'Call Institution'),
        _aboutTile(Icons.location_on, 'Get Directions'),
        _aboutTile(Icons.schedule, 'Working Hours'),
        _aboutTile(Icons.info_outline, 'Institution Details'),
      ],
    );
  }

  Widget _aboutTile(IconData icon, String title) {
    return Card(
      color: const Color(0xFF1C1C1E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        trailing:
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
      ),
    );
  }

  /// GALLERY TAB
  Widget _galleryTab() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f',
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
