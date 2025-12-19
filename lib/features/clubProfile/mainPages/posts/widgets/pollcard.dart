import 'package:akalpit/features/clubProfile/mainPages/posts/widgets/basecard.dart';
import 'package:akalpit/features/clubProfile/mainPages/posts/widgets/reactionsrow.dart';
import 'package:flutter/material.dart';

class PollCard extends StatelessWidget {
  const PollCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      headerIcon: Icons.poll,
      title: "Poll",
      subtitle: "Vote now",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Which event should we organize next?",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          _PollOption(text: "Hackathon", percent: 45),
          _PollOption(text: "Tech Talk", percent: 30),
          _PollOption(text: "Workshop", percent: 25),
          const SizedBox(height: 12),
          ReactionRow(),
        ],
      ),
    );
  }
}

class _PollOption extends StatelessWidget {
  final String text;
  final int percent;

  const _PollOption({
    required this.text,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$text  •  $percent%"),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: percent / 100,
            minHeight: 6,
          ),
        ],
      ),
    );
  }
}
