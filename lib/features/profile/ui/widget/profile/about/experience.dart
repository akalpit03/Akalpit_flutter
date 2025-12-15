import 'package:flutter/material.dart';

class ProfileExperienceTimeline extends StatelessWidget {
  const ProfileExperienceTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    final experiences = [
      {
        'title': 'Flutter Developer – Penverse',
        'date': '2023 - Present',
      },
      {
        'title': 'Intern – Mobile Dev',
        'date': '2022 - 2023',
      },
      {
        'title': 'Freelancer',
        'date': '2021 - 2022',
      },
    ];

    return Column(
      children: List.generate(experiences.length, (index) {
        final isLast = index == experiences.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline indicator
            Column(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.blueGrey,
                    shape: BoxShape.circle,
                  ),
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 50,
                    color: Colors.blueGrey.shade300,
                  ),
              ],
            ),

            const SizedBox(width: 12),

            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      experiences[index]['title']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      experiences[index]['date']!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
