import 'package:akalpit/features/institutions/UI/adminside/bookings/components/bookingsPageAppbar.dart';
import 'package:akalpit/features/institutions/UI/adminside/bookings/sponsorsRequestPage.dart';
import 'package:flutter/material.dart';
 

// ─────────────────────────────────────────────────────────────
// ADMIN BOOKINGS PAGE
// ─────────────────────────────────────────────────────────────

class AdminBookingsPage extends StatefulWidget {
  const AdminBookingsPage({super.key});

  @override
  State<AdminBookingsPage> createState() => _AdminBookingsPageState();
}

class _AdminBookingsPageState extends State<AdminBookingsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<Map<String, dynamic>> bookings;

  final List<String> _tabs = [
    'All',
    'Pending',
    'Confirmed',
    'Completed',
    'Cancelled',
  ];

  // Count pending sponsoring requests for badge
  int get _pendingSponsorCount => dummySponsoringRequests
      .where((r) => r['status'] == 'Pending')
      .length;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    bookings = List<Map<String, dynamic>>.from(
      dummyAdminBookings.map((b) => Map<String, dynamic>.from(b)),
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

  void _updateStatus(String id, String newStatus) {
    setState(() {
      final index = bookings.indexWhere((b) => b['id'] == id);
      if (index != -1) bookings[index]['status'] = newStatus;
    });
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
          'Bookings',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          // Sponsoring requests notification button
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const SponsoringRequestsPage(),
                  ),
                );
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.campaign_outlined,
                      color: Colors.white, size: 26),
                  if (_pendingSponsorCount > 0)
                    Positioned(
                      top: -4,
                      right: -4,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.redAccent,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$_pendingSponsorCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
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
            itemBuilder: (_, i) => AdminBookingCard(
              booking: list[i],
              onAccept: () => _updateStatus(list[i]['id'], 'Confirmed'),
              onReject: () => _updateStatus(list[i]['id'], 'Cancelled'),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// ADMIN BOOKING CARD
// ─────────────────────────────────────────────────────────────

class AdminBookingCard extends StatelessWidget {
  final Map<String, dynamic> booking;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const AdminBookingCard({
    super.key,
    required this.booking,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    final status = booking['status'] as String;
    final isPending = status == 'Pending';
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
                // Order ID
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking['id'],
                        style: const TextStyle(
                          color: Colors.white38,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
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

          // ── Info Grid ────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User
                _InfoRow(
                  icon: Icons.person_outline,
                  label: 'User',
                  value: booking['userName'],
                ),
                const SizedBox(height: 8),

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

                // Persons (if applicable)
                if (persons != null) ...[
                  _InfoRow(
                    icon: Icons.people_outline,
                    label: 'Persons',
                    value: '$persons',
                  ),
                  const SizedBox(height: 8),
                ],

                // Items / Amenities
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
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 11),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Total cost
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Amount',
                        style:
                            TextStyle(color: Colors.white54, fontSize: 13)),
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
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ── Accept / Reject (only for Pending) ───────────────
          if (isPending) ...[
            Divider(color: Colors.white.withOpacity(0.06), height: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: onReject,
                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(vertical: 11),
                        decoration: BoxDecoration(
                          color: Colors.redAccent.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Colors.redAccent.withOpacity(0.3)),
                        ),
                        child: const Center(
                          child: Text(
                            'Reject',
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: onAccept,
                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(vertical: 11),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: const Color(0xFF10B981)
                                  .withOpacity(0.4)),
                        ),
                        child: const Center(
                          child: Text(
                            'Accept',
                            style: TextStyle(
                              color: Color(0xFF10B981),
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ] else
            const SizedBox(height: 14),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// INFO ROW HELPER
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
          child: Text(
            value,
            style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}