import 'package:flutter/material.dart';

class ClubCategoryBottomSheet extends StatefulWidget {
  const ClubCategoryBottomSheet({super.key});

  @override
  State<ClubCategoryBottomSheet> createState() =>
      _ClubCategoryBottomSheetState();
}

class _ClubCategoryBottomSheetState extends State<ClubCategoryBottomSheet> {
  final TextEditingController searchCtrl = TextEditingController();

  final List<String> categories = [
    'Comedy',
    'Education',
    'Entertainment',
    'Films & Animation',
    'Gaming',
    'Fashion & Style',
    'Food / Cooking',
    'Health',
    'Music',
    'News & Politics',
    'Literature',
    'Gardening',
    'Technology',
    'Sports',
    'Art & Design',
    'Travel',
    'Photography',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = categories
        .where((c) =>
            c.toLowerCase().contains(searchCtrl.text.toLowerCase()))
        .toList();

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 12),

          /// Search
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: searchCtrl,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                hintText: 'Search category...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),

          const SizedBox(height: 12),

          /// List
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (_, index) {
                return ListTile(
                  title: Text(filtered[index]),
                  onTap: () {
                    Navigator.pop(context, filtered[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
