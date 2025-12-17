import 'package:akalpit/features/Events/layout/ui/widgets/essentials/calendar.dart';
import 'package:akalpit/features/Events/layout/ui/widgets/essentials/filterTag.dart';
import 'package:flutter/material.dart';
import 'package:akalpit/features/Events/layout/ui/pages/searchpage.dart';
import 'package:akalpit/features/Events/layout/ui/widgets/essentials/eventCard.dart';

class EventBody extends StatelessWidget {
  final bool isClub;

  const EventBody({
    super.key,
    required this.isClub, // default: normal usage
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        /// ================= Search Bar =================
        TextField(
          readOnly: true,
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

        /// ================= Club Calendar =================
        if (isClub) ...[
          const SizedBox(height: 12),
          const CalendarStrip(),
        ],

        const SizedBox(height: 12),

        /// ================= Filters =================
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: isClub
                ? const [
                    FilterTag(label: 'Upcoming'),
                    SizedBox(width: 8),
                    FilterTag(label: 'Ongoing'),
                    SizedBox(width: 8),
                    FilterTag(label: 'Past'),
                  ]
                : const [
                    FilterTag(label: 'Genre'),
                    SizedBox(width: 8),
                    FilterTag(label: 'City'),
                    SizedBox(width: 8),
                    FilterTag(label: 'Upcoming'),
                    SizedBox(width: 8),
                    FilterTag(label: 'Free'),
                    SizedBox(width: 8),
                    FilterTag(label: 'Paid'),
                  ],
          ),
        ),

        const SizedBox(height: 12),

        /// ================= Event Cards =================
        ...List.generate(
          6,
          (_) => const EventCard(),
        ),
      ],
    );
  }
}
