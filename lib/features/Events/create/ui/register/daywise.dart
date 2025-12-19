import 'package:akalpit/features/Events/create/ui/register/daywise/awards_form.dart';
import 'package:akalpit/features/Events/create/ui/register/daywise/contact_information_form.dart';
import 'package:akalpit/features/Events/create/ui/register/daywise/rules_form.dart';
import 'package:akalpit/features/Events/create/ui/register/daywise/scheduling_form.dart';
import 'package:akalpit/features/Events/create/ui/register/daywise/venue_form.dart';
import 'package:flutter/material.dart';
 

class DayWiseEventPage extends StatelessWidget {
  const DayWiseEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Day-wise Event Details",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _EventActionButton(
            emoji: "🗓️",
            title: "Scheduling",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SchedulingPage(),
                ),
              );
            },
          ),
          _EventActionButton(
            emoji: "🏆",
            title: "Awards & Recognition",
            onTap: () {
               Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AwardsPage(),
                ),
              );
            },
          ),
          _EventActionButton(
            emoji: "📜",
            title: "Rules & Guidelines",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const RulesPage(),
                ),
              );
            },
          ),
          // _EventActionButton(
          //   emoji: "👥",
          //   title: "Participation Details",
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (_) => const AwardsPage(),
          //       ),
          //     );
          //   },
          // ),
          _EventActionButton(
            emoji: "📍",
            title: "Venue & Logistics",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const VenueLogisticsPage(),
                ),
              );
            },
          ),
          _EventActionButton(
            emoji: "☎️",
            title: "Contacts & Support",
            onTap: () {
             Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ContactsPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// ================= ACTION BUTTON CARD =================
class _EventActionButton extends StatelessWidget {
  final String emoji;
  final String title;
  final VoidCallback onTap;

  const _EventActionButton({
    required this.emoji,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Text(
                emoji,
                style: const TextStyle(fontSize: 26),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
