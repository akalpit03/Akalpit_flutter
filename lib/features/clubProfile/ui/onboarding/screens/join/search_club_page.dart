import 'package:akalpit/features/clubProfile/ui/single_club_profile.dart';
import 'package:flutter/material.dart';
import 'widgets/category_chip.dart';

class SearchClubPage extends StatelessWidget {
  const SearchClubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search for a Club',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// ================= Search Bar =================
          TextField(
            decoration: InputDecoration(
              hintText: 'Search club by name or club ID',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.black,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// ================= Category Section =================
          const Text(
            'Search by Category',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 10),

          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                CategoryChip(title: 'Comedy'),
                CategoryChip(title: 'Education'),
                CategoryChip(title: 'Gaming'),
                CategoryChip(title: 'Music'),
                CategoryChip(title: 'see more'),
              ],
            ),
          ),

          const SizedBox(height: 24),

          /// ================= Dummy Search Result =================
          const Text(
            'Search Result',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 12),

          const _ClubResultCard(),
        ],
      ),
    );
  }
}

/// ===========================================================
/// Category Chip Widget
/// ===========================================================

/// ===========================================================
/// Club Result Card
/// ===========================================================
class _ClubResultCard extends StatelessWidget {
  const _ClubResultCard();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ClubProfilePage(isGuest: true,),
          ),
        );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Profile Pic
              const CircleAvatar(
                radius: 26,
                backgroundColor: Colors.grey,
                child: Icon(Icons.group, color: Colors.white),
              ),

              const SizedBox(width: 14),

              /// Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Club Name
                    const Text(
                      'Akalpit Writers Club',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 4),

                    /// About
                    Text(
                      'A community for writers, poets and thinkers.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 8),

                    /// Club ID
                    Text(
                      'Club ID: AKP-CLUB-001',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(height: 6),

                    /// Category Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.blueGrey.shade200,
                        ),
                      ),
                      child: const Text(
                        'Literature',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
