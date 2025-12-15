import 'package:flutter/material.dart';

class ProfileAwardsPage extends StatelessWidget {
  const ProfileAwardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final awards = [
      {
        'title': 'Best Innovator',
        'name': 'Innovation Excellence',
        'givenBy': 'Akalpit',
        'emoji': '🏆',
      },
      {
        'title': 'Top Contributor',
        'name': 'Community Impact',
        'givenBy': 'Akalpit',
        'emoji': '🥇',
      },
      {
        'title': 'Certified Leader',
        'name': 'Leadership Program',
        'givenBy': 'Akalpit',
        'emoji': '🎖',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Awards'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: awards.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final award = awards[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Text(
                    award['emoji']!,
                    style: const TextStyle(fontSize: 30),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          award['title']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(award['name']!),
                        const SizedBox(height: 4),
                        Text(
                          'Given by ${award['givenBy']}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
