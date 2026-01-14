import 'package:flutter/material.dart';

class ActivityDetailDummyPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const ActivityDetailDummyPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final activity = data['data'];
    final schedule = activity['scheduling'] as List;
    final awards = activity['awardsRecognition'] as List;
    final rules = activity['rulesGuidelines'] as List;
    final venue = activity['venueLogistics'];
    final contacts = activity['contactsSupport'] as List;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(activity['activityName'], 
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        actions: [
          _statusChip(activity['status']),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Venue & Location Header
            _sectionHeader("Location & Logistics", Icons.map_outlined),
            _buildVenueCard(venue),
            
            const SizedBox(height: 24),

            // 2. Timeline Schedule
            _sectionHeader("Event Timeline", Icons.history_toggle_off),
            const SizedBox(height: 12),
            ...schedule.map((s) => _buildTimelineItem(s)).toList(),

            const SizedBox(height: 24),

            // 3. Prizes & Awards
            _sectionHeader("Awards & Recognition", Icons.emoji_events_outlined),
            const SizedBox(height: 12),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: awards.length,
                itemBuilder: (context, i) => _buildAwardCard(awards[i]),
              ),
            ),

            const SizedBox(height: 24),

            // 4. Rules
            _sectionHeader("Rules & Guidelines", Icons.gavel_rounded),
            const SizedBox(height: 12),
            ...rules.map((r) => _buildRuleItem(r)).toList(),

            const SizedBox(height: 24),

            // 5. Contacts
            _sectionHeader("Support & Contacts", Icons.contact_support_outlined),
            const SizedBox(height: 12),
            ...contacts.map((c) => _buildContactTile(c)).toList(),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _sectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.blueAccent, size: 20),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _statusChip(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: status == "active" ? Colors.green.withOpacity(0.2) : Colors.orange.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: status == "active" ? Colors.green : Colors.orange),
      ),
      child: Text(status.toUpperCase(), style: TextStyle(color: status == "active" ? Colors.green : Colors.orange, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildVenueCard(Map<String, dynamic> venue) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(venue['venueName'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          Text(venue['address'] ?? '', style: const TextStyle(color: Colors.white54, fontSize: 12)),
          const Divider(height: 24, color: Colors.white10),
          Wrap(
            spacing: 8,
            children: (venue['resources'] as List).map((r) => Chip(
              label: Text(r, style: const TextStyle(fontSize: 10, color: Colors.white70)),
              backgroundColor: Colors.white.withOpacity(0.05),
              visualDensity: VisualDensity.compact,
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(Map<String, dynamic> item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            const CircleAvatar(radius: 6, backgroundColor: Colors.blueAccent),
            Container(width: 2, height: 50, color: Colors.white10),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${item['startTime']} - ${item['endTime']}", style: const TextStyle(color: Colors.blueAccent, fontSize: 12, fontWeight: FontWeight.bold)),
              Text(item['title'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              Text(item['description'] ?? '', style: const TextStyle(color: Colors.white38, fontSize: 12)),
              const SizedBox(height: 16),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildAwardCard(Map<String, dynamic> award) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.blueAccent.withOpacity(0.2), Colors.transparent]),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(award['title'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          Text("₹${award['amount']}", style: const TextStyle(color: Colors.greenAccent, fontSize: 18, fontWeight: FontWeight.bold)),
          const Spacer(),
          if (award['certificate']) const Text("📜 Certificate Included", style: TextStyle(color: Colors.white38, fontSize: 9)),
        ],
      ),
    );
  }

  Widget _buildRuleItem(Map<String, dynamic> rule) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, color: Colors.white24, size: 16),
          const SizedBox(width: 8),
          Expanded(child: Text("${rule['title']}: ${rule['description']}", style: const TextStyle(color: Colors.white70, fontSize: 13))),
        ],
      ),
    );
  }

  Widget _buildContactTile(Map<String, dynamic> contact) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(backgroundColor: Colors.blueAccent.withOpacity(0.1), child: Text(contact['name'][0], style: const TextStyle(color: Colors.blueAccent))),
      title: Text(contact['name'], style: const TextStyle(color: Colors.white, fontSize: 14)),
      subtitle: Text(contact['role'], style: const TextStyle(color: Colors.white38, fontSize: 12)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(icon: const Icon(Icons.phone, color: Colors.greenAccent, size: 20), onPressed: () {}),
          IconButton(icon: const Icon(Icons.email, color: Colors.blueAccent, size: 20), onPressed: () {}),
        ],
      ),
    );
  }
}