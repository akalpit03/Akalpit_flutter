import 'package:akalpit/features/institutions/UI/adminside/bookings/components/bookingsPageAppbar.dart';
import 'package:flutter/material.dart';
 

// ─────────────────────────────────────────────────────────────
// SPONSORING REQUESTS PAGE
// ─────────────────────────────────────────────────────────────

class SponsoringRequestsPage extends StatefulWidget {
  const SponsoringRequestsPage({super.key});

  @override
  State<SponsoringRequestsPage> createState() =>
      _SponsoringRequestsPageState();
}

class _SponsoringRequestsPageState extends State<SponsoringRequestsPage> {
  late List<Map<String, dynamic>> requests;

  @override
  void initState() {
    super.initState();
    requests = List<Map<String, dynamic>>.from(
      dummySponsoringRequests.map((r) => Map<String, dynamic>.from(r)),
    );
  }

  void _updateStatus(String id, String newStatus) {
    setState(() {
      final index = requests.indexWhere((r) => r['id'] == id);
      if (index != -1) requests[index]['status'] = newStatus;
    });
    // TODO: wire API
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
          'Sponsoring Requests',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: requests.isEmpty
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.campaign_outlined,
                      color: Colors.white12, size: 56),
                  SizedBox(height: 12),
                  Text('No sponsoring requests',
                      style:
                          TextStyle(color: Colors.white38, fontSize: 14)),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
              itemCount: requests.length,
              separatorBuilder: (_, __) => const SizedBox(height: 14),
              itemBuilder: (_, i) => SponsoringRequestCard(
                request: requests[i],
                onApprove: () =>
                    _updateStatus(requests[i]['id'], 'Approved'),
                onReject: () =>
                    _updateStatus(requests[i]['id'], 'Rejected'),
              ),
            ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// SPONSORING REQUEST CARD
// ─────────────────────────────────────────────────────────────

class SponsoringRequestCard extends StatelessWidget {
  final Map<String, dynamic> request;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  const SponsoringRequestCard({
    super.key,
    required this.request,
    required this.onApprove,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    final status = request['status'] as String;
    final isPending = status == 'Pending';

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Club logo placeholder
                Container(
                  height: 46,
                  width: 46,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.groups,
                      color: Colors.white24, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request['clubName'],
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        request['eventName'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
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
                // Description
                Text(
                  request['description'],
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 13,
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 14),

                // Details grid
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.04),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      _DetailRow(
                        icon: Icons.event_outlined,
                        label: 'Event Date',
                        value: request['eventDate'],
                      ),
                      const SizedBox(height: 8),
                      _DetailRow(
                        icon: Icons.person_outline,
                        label: 'Contact',
                        value:
                            '${request['contactName']} · ${request['contactRole']}',
                      ),
                      const SizedBox(height: 8),
                      _DetailRow(
                        icon: Icons.access_time_outlined,
                        label: 'Submitted',
                        value: request['submittedOn'],
                      ),
                      const SizedBox(height: 8),
                      _DetailRow(
                        icon: Icons.currency_rupee_outlined,
                        label: 'Requested',
                        value:
                            '₹${(request['requestedAmount'] as double).toStringAsFixed(0)}',
                        valueStyle: const TextStyle(
                          color: Color(0xFF10B981),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // Actions
                if (isPending)
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: onReject,
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.redAccent.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color:
                                      Colors.redAccent.withOpacity(0.3)),
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
                          onTap: onApprove,
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xFF10B981)
                                  .withOpacity(0.15),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: const Color(0xFF10B981)
                                      .withOpacity(0.4)),
                            ),
                            child: const Center(
                              child: Text(
                                'Approve',
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
                  )
                else
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        status == 'Approved'
                            ? '✓ Request Approved'
                            : '✕ Request Rejected',
                        style: TextStyle(
                          color: status == 'Approved'
                              ? const Color(0xFF10B981)
                              : Colors.redAccent,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
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
// DETAIL ROW
// ─────────────────────────────────────────────────────────────

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final TextStyle? valueStyle;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white38, size: 14),
        const SizedBox(width: 8),
        SizedBox(
          width: 72,
          child: Text(label,
              style:
                  const TextStyle(color: Colors.white38, fontSize: 12)),
        ),
        Expanded(
          child: Text(
            value,
            style: valueStyle ??
                const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}