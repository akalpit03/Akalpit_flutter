import 'package:flutter/material.dart';

class ActiveUsersList extends StatelessWidget {
  const ActiveUsersList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: 2,
        itemBuilder: (context, index) {
          final bool isOnline = index % 2 == 0; // demo logic

          return Padding(
            padding: const EdgeInsets.only(right: 14),
            child: Column(
              children: [
                Stack(
                  children:   [
                   const CircleAvatar(
                      radius: 30,
                      backgroundImage: const NetworkImage(
                        "https://res.cloudinary.com/du4hokehj/image/upload/v1767472929/uploads/olv2bluis67ob0czmzye.png",
                      ), // replace with user image
                    ),

                    // Online indicator
                    if (isOnline)
                      const Positioned(
                        bottom: 2,
                        right: 2,
                        child: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.green,
                          child:   Icon(
                            Icons.check,
                            size: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'User ${index + 1}',
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
