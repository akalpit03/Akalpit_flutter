import 'package:akalpit/features/clubProfile/ui/mainPages/clubHomePage.dart';
import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String title;

  const CategoryChip({required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (_) => const ClubHomePage()),
        //         );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Text(
          title,
          style: const TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}
