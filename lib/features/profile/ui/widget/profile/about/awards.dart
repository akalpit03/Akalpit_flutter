import 'package:akalpit/features/profile/ui/widget/profile/about/awards_page.dart';
import 'package:flutter/material.dart';

class ProfileAwardsCarousel extends StatelessWidget {
  const ProfileAwardsCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final awards = [
      {
        'title': 'Best Innovator',
        'name': 'Innovation Excellence',
        'givenBy': 'Akalpit',
        'event': 'Innovation Summit 2024',
        'emoji': '🏆',
      },
      {
        'title': 'Top Contributor',
        'name': 'Community Impact',
        'givenBy': 'Akalpit',
        'event': 'Community Meet',
        'emoji': '🥇',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// ================= Header =================
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'My Awards',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProfileAwardsPage(),
                  ),
                );
              },
              child: const Text('See more'),
            ),
          ],
        ),

        const SizedBox(height: 10),

        /// ================= Carousel =================
        SizedBox(
          height: 260,
          child: PageView.builder(
            controller: PageController(viewportFraction: 0.60),
            itemCount: awards.length,
            itemBuilder: (context, index) {
              final award = awards[index];

              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SizedBox(
                      width: constraints.maxWidth, // ✅ SAME WIDTH FOR BOTH
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          /// ================= Award Card =================
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                              border: Border.all(
                                color: Colors.white,
                                width: 1.2,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  award['emoji']!,
                                  style: const TextStyle(fontSize: 30),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  award['title']!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  award['name']!,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.white70,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Given by ${award['givenBy']}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white54,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// ================= Joint Bottom Section =================
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(16),
                              ),
                              border: Border.all(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.verified,
                                  color: Colors.green,
                                  size: 18,
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    award['event']!,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
