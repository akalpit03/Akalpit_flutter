import 'package:akalpit/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileBookItem extends StatelessWidget {
  final String title;
  final int chapters;
  final String imageUrl;

  const ProfileBookItem({
    super.key,
    required this.title,
    required this.chapters,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.black12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 📘 Book Cover (Larger)
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imageUrl,
              width: 90,              // ⬅️ Increased size
              height: 130,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 14),

          /// 📄 Book Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Book Title
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 6),

                /// Chapters
                Text(
                  '$chapters Chapters',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.scaffoldBackground,
                  ),
                ),

                const SizedBox(height: 12),

                /// ▶️ Start Reading Button (Smaller)
                SizedBox(
                  width: 130, // ⬅️ Less than half width
                  height: 36,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: const Text(
                      'See Events',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
