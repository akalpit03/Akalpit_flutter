import 'package:flutter/material.dart';

class StoryList extends StatelessWidget {
  const StoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: 8,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey.shade300,
                  child: const Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(height: 6),
                Text(
                  'Story ${index + 1}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
