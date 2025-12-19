import 'package:flutter/material.dart';

class ReactionRow extends StatelessWidget {
  const ReactionRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        _Reaction(icon: "👍", count: 32),
        _Reaction(icon: "❤️", count: 18),
        _Reaction(icon: "👏", count: 12),
        _Reaction(icon: "😮", count: 6),
      ],
    );
  }
}

class _Reaction extends StatelessWidget {
  final String icon;
  final int count;

  const _Reaction({
    required this.icon,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 4),
          Text(count.toString()),
        ],
      ),
    );
  }
}
