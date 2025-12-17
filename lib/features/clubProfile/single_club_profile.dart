import 'package:akalpit/features/clubProfile/onboarding/join/club_joining_status_page.dart';
import 'package:flutter/material.dart';

class ClubProfilePage extends StatefulWidget {
  const ClubProfilePage({super.key});

  @override
  State<ClubProfilePage> createState() => _ClubProfilePageState();
}

class _ClubProfilePageState extends State<ClubProfilePage> {
  /// Change later with real logic
  bool isGuest = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Club Profile',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          /// ================= HEADER SECTION =================
          const _ClubHeader(),

          const SizedBox(height: 20),

          /// ================= BODY SECTION =================
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: isGuest
                  ? const _GuestActions()
                  : const Center(
                      child: Text(
                        'Following state UI will be added later',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= HEADER =================
class _ClubHeader extends StatelessWidget {
  const _ClubHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(24),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Club Image
          CircleAvatar(
            radius: 36,
            backgroundColor: Colors.grey.shade300,
            child: const Icon(Icons.groups, size: 32),
          ),

          const SizedBox(width: 14),

          /// Club Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            
              children: const [
                Text(
                  'Akalpit Tech Club',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black45
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'XYZ University',
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
                SizedBox(height: 4),
                Text(
                  'Coordinator: John Doe',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),

          /// Follow Button ✅ (THIS IS FINE)
          // ElevatedButton(
          //   onPressed: () {
          //     // follow logic later
          //   },
          //   style: ElevatedButton.styleFrom(
          //     padding: const EdgeInsets.symmetric(
          //       horizontal: 16,
          //       vertical: 10,
          //     ),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(20),
          //     ),
          //   ),
          //   child: const Text('Follow'),
          // ),
        ],
      ),
    );
  }
}

/// ================= GUEST ACTIONS =================
class _GuestActions extends StatelessWidget {
  const _GuestActions();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// Join as Team
        SizedBox(
          width: double.infinity,
          height: 46,
          child: OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const RequestStatusPage(),
                ),
              );
            },
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Join as Team',
            style: TextStyle(color: Colors.white),),
          ),
        ),

        const SizedBox(height: 14),

        /// Become a Member
        SizedBox(
          width: double.infinity,
          height: 46,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const RequestStatusPage(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Become a Member'),
          ),
        ),
      ],
    );
  }
}
