import 'package:akalpit/features/institutions/UI/adminside/bookings/components/bookingsPageAppbar.dart';
import 'package:flutter/material.dart';
 

// ─────────────────────────────────────────────────────────────
// USER BOOKINGS PAGE
// ─────────────────────────────────────────────────────────────

class UserBookingsPage extends StatefulWidget {
  const UserBookingsPage({super.key});

  @override
  State<UserBookingsPage> createState() => _UserBookingsPageState();
}

class _UserBookingsPageState extends State<UserBookingsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _tabs = [
    'All',
    'Pending',
    'Confirmed',
    'Completed',
    'Cancelled',
  ];

  late List<Map<String, dynamic>> bookings;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    bookings = List<Map<String, dynamic>>.from(
      dummyUserBookings.map((b) => Map<String, dynamic>.from(b)),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _filtered(String tab) {
    if (tab == 'All') return bookings;
    return bookings.where((b) => b['status'] == tab).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          'My Bookings',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.white,
          indicatorWeight: 2,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white38,
          labelStyle: const TextStyle(
              fontWeight: FontWeight.w600, fontSize: 13),
          tabAlignment: TabAlignment.start,
          tabs: _tabs.map((t) => Tab(text: t)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabs.map((tab) {
          final list = _filtered(tab);
          if (list.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.inbox_outlined,
                      color: Colors.white12, size: 56),
                  const SizedBox(height: 12),
                  Text(
                    'No $tab bookings',
                    style: const TextStyle(
                        color: Colors.white38, fontSize: 14),
                  ),
                ],
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
            itemCount: list.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (_, i) => UserBookingCard(booking: list[i]),
          );
        }).toList(),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// USER BOOKING CARD
// ─────────────────────────────────────────────────────────────

class UserBookingCard extends StatelessWidget {
  final Map<String, dynamic> booking;
  const UserBookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final status = booking['status'] as String;
    final items = List<String>.from(booking['items'] as List);
    final persons = booking['persons'];

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking['id'],
                        style: const TextStyle(
                          color: Colors.white38,
                          fontSize: 11,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        booking['serviceName'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        booking['institutionName'],
                        style: const TextStyle(
                            color: Colors.white54, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                StatusBadge(status: status),
              ],
            ),
          ),

          const SizedBox(height: 12),
          Divider(color: Colors.white.withOpacity(0.06), height: 1),
          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date
                _InfoRow(
                  icon: Icons.calendar_today_outlined,
                  label: 'Date',
                  value: booking['date'],
                ),
                const SizedBox(height: 8),

                // Created at
                _InfoRow(
                  icon: Icons.access_time_outlined,
                  label: 'Booked on',
                  value: booking['createdAt'] ?? '-',
                ),
                const SizedBox(height: 8),

                // Persons
                if (persons != null) ...[
                  _InfoRow(
                    icon: Icons.people_outline,
                    label: 'Persons',
                    value: '$persons',
                  ),
                  const SizedBox(height: 8),
                ],

                // Items
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.checklist_outlined,
                        color: Colors.white38, size: 15),
                    const SizedBox(width: 8),
                    const SizedBox(
                      width: 56,
                      child: Text('Items',
                          style: TextStyle(
                              color: Colors.white38, fontSize: 12)),
                    ),
                    Expanded(
                      child: Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: items
                            .map((item) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.06),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(item,
                                      style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 11)),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Total
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Amount',
                        style: TextStyle(
                            color: Colors.white54, fontSize: 13)),
                    Text(
                      '₹${booking['totalCost'].toStringAsFixed(0)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// INFO ROW
// ─────────────────────────────────────────────────────────────

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white38, size: 15),
        const SizedBox(width: 8),
        SizedBox(
          width: 56,
          child: Text(label,
              style:
                  const TextStyle(color: Colors.white38, fontSize: 12)),
        ),
        Expanded(
          child: Text(value,
              style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                  fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }
}