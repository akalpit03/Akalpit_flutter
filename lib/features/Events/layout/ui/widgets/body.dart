import 'package:flutter/material.dart';
import 'package:akalpit/features/Events/layout/ui/pages/searchpage.dart';
import 'package:akalpit/features/Events/layout/ui/widgets/cards/eventCard.dart';

class EventBody extends StatelessWidget {
  const EventBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        // ================= Full-width Search Bar =================
        TextField(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SearchPage()),
            );
          },
          decoration: InputDecoration(
            hintText: 'Search events...',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Colors.grey.shade900,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),

        const SizedBox(height: 12),

        // ================= Filter Tags =================
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _FilterTag(
                  label: 'Genre',
                  onTap: () {
                    // Navigate to genre search page
                  }),
              const SizedBox(width: 8),
              _FilterTag(
                  label: 'City',
                  onTap: () {
                    // Navigate to city filter page
                  }),
              const SizedBox(width: 8),
              _FilterTag(label: 'Upcoming', onTap: () {}),
              const SizedBox(width: 8),
              _FilterTag(label: 'Free', onTap: () {}),
              const SizedBox(width: 8),
              _FilterTag(label: 'Paid', onTap: () {}),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // ================= Event Cards =================
        ...List.generate(
          6,
          (_) => const EventCard(),
        ),
      ],
    );
  }
}

// ================= Filter Tag Widget =================
class _FilterTag extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _FilterTag({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 22, // 👈 more horizontal space
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: Colors.grey.shade500, // 👈 border line
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
