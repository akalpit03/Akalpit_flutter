import 'package:flutter/material.dart';

class StatusList extends StatelessWidget {
  const StatusList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 8,
        itemBuilder: (context, index) {
          if (index == 0) {
            /// My Status
            return _MyStatusCard();
          }

          /// Other Status
          return _StatusCard(
            name: 'Club Name $index',
          );
        },
      ),
    );
  }
}

/// =====================
/// My Status Card
/// =====================
class _MyStatusCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 14),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 170,
                width: 130,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.person, size: 36, color: Colors.white),
              ),
              Positioned(
                bottom: 6,
                right: 6,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            'Create your Club',
            style: TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

/// =====================
/// Other Status Card
/// =====================
class _StatusCard extends StatelessWidget {
  final String name;

  const _StatusCard({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 14),
      child: Column(
        children: [
          Container(
            height: 170,
            width: 130,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            name,
            style: const TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
