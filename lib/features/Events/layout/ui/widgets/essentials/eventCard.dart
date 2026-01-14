import 'package:akalpit/features/Events/activities/ui/daylist.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ui'; // For BackdropFilter

class EventCard extends StatelessWidget {
  final dynamic event;

  const EventCard({super.key, required this.event});

  // Helper for Date Formatting
  String _formatDate(String? dateStr, {bool includeYear = false}) {
    if (dateStr == null) return "TBA";
    try {
      final DateTime date = DateTime.parse(dateStr);
      return DateFormat(includeYear ? 'dd MMM yyyy' : 'dd MMM').format(date);
    } catch (e) {
      return dateStr;
    }
  }

  // --- Image Viewer Function ---
  void _showPoster(BuildContext context, String imageUrl, String name) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Text(name, style: const TextStyle(fontSize: 16)),
                leading: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: InteractiveViewer(
                  // Allows zooming
                  panEnabled: true,
                  minScale: 0.5,
                  maxScale: 4,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.broken_image, size: 100),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text("Pinch to zoom",
                  style: TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 1. Safe Data Extraction
    final String banner = event['banner'] ?? '';
    final String name = event['name'] ?? 'Untitled Event';
    final String venue = event['venue'] ?? 'TBA';
    final String about = event['about'] ?? '';
    final num fee = event['participationFee'] ?? 0;
    final num prize = event['prizePool'] ?? 0;
    final num days = event['numberOfDays'] ?? 1;
    final String type = event['eventType'] ?? 'Other';
    final String status = event['status'] ?? 'published';

    final String start = _formatDate(event['startDate']);
    final String regDeadline =
        _formatDate(event['lastRegistrationDate'], includeYear: true);
final String eventId = event['_id']?.toString() ?? 'unknown';
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ================= CLICKABLE HEADER =================
          GestureDetector(
            onTap: () => _showPoster(context, banner, name),
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Hero(
                    // Hero animation for smooth transition
                   tag: "event_banner_$eventId",
                    child: Image.network(
                      banner.isNotEmpty
                          ? banner
                          : 'https://via.placeholder.com/400x225',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Overlay Gradient
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.6)
                        ],
                      ),
                    ),
                  ),
                ),
                // Hint to click
                const Positioned(
                  top: 12,
                  right: 12,
                  child: CircleAvatar(
                    backgroundColor: Colors.black45,
                    radius: 16,
                    child:
                        Icon(Icons.fullscreen, color: Colors.white, size: 18),
                  ),
                ),
                Positioned(
                  bottom: 12,
                  left: 16,
                  child: _GlassBadge(
                      label: type.toUpperCase(), color: Colors.blueAccent),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title & Prize
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(name,
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                    if (prize > 0)
                      Text("₹$prize",
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.greenAccent,
                          )),
                  ],
                ),
                const SizedBox(height: 12),

                // Info Grid
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _InfoItem(
                        label: "STARTS",
                        value: start,
                        icon: Icons.calendar_month),
                    _InfoItem(
                        label: "FEE",
                        value: fee == 0 ? "Free" : "₹$fee",
                        icon: Icons.confirmation_number),
                    _InfoItem(
                        label: "DAYS", value: "$days Days", icon: Icons.timer),
                  ],
                ),

                const Divider(height: 32, color: Colors.white10),

                // Registration Urgency
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.event_busy,
                          color: Colors.redAccent, size: 16),
                      const SizedBox(width: 8),
                      Text("Deadline: $regDeadline",
                          style: const TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 12)),
                    ],
                  ),
                ),

                const SizedBox(height: 16),
                Text(about,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white60, fontSize: 13, height: 1.5)),
                const SizedBox(height: 24),

                // Buttons
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>   EventSchedulePage(eventId: eventId),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    child: const Text("Participate Now",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white)),
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

// Support Widgets
class _InfoItem extends StatelessWidget {
  final String label, value;
  final IconData icon;
  const _InfoItem(
      {required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 12, color: Colors.white38),
            const SizedBox(width: 4),
            Text(label,
                style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white38,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(
                fontSize: 13,
                color: Colors.white,
                fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _GlassBadge extends StatelessWidget {
  final String label;
  final Color color;
  const _GlassBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(label,
          style: TextStyle(
              color: color, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }
}
