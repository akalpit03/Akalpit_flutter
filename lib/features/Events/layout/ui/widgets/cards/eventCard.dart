import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Card(
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(16),
      //   side: BorderSide(color: Colors.grey.shade300, width: 1), // Border around the card
      // ),
      elevation: 3,
      margin: const EdgeInsets.symmetric(  vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ================= Image Section =================
          Container(
            height: screenHeight * 0.35, // half screen height approx
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://res.cloudinary.com/dmxskf3hq/image/upload/v1757363826/uploads/ysrx2zcokdft4ishsxwb.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // ================= Event Title & Club =================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Event Name Goes Here',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'Club Name • Venue Name',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ================= Middle Section: Event Details =================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dates & Price
                Row(
                  children: const [
                    Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                    SizedBox(width: 4),
                    Text('12 Dec 2025 - 15 Dec 2025', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    SizedBox(width: 12),
                    Icon(Icons.monetization_on_outlined, size: 14, color: Colors.grey),
                    SizedBox(width: 4),
                    Text('₹200', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 6),

                // About & Participants
                Row(
                  children: const [
                    Icon(Icons.info_outline, size: 14, color: Colors.grey),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'About: Some description of the event goes here.',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: const [
                    Icon(Icons.people_outline, size: 14, color: Colors.grey),
                    SizedBox(width: 4),
                    Text('Participants: 24', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 8),

                // Event Type & Audience Charge (Oval tags)
                Row(
                  children: const [
                    _Tag(label: 'Cultural', color: Colors.blueAccent),
                    SizedBox(width: 8),
                    _Tag(label: 'Free', color: Colors.green),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ================= Bottom Section: Buttons =================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade800,
                      minimumSize: const Size.fromHeight(40),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Participate'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.green),
                      minimumSize: const Size.fromHeight(40),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Preview', style: TextStyle(color: Colors.green)),
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

// ================= Oval Tag Widget =================
class _Tag extends StatelessWidget {
  final String label;
  final Color color;

  const _Tag({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }
}
