import 'package:flutter/material.dart';

class AppSideDrawer extends StatelessWidget {
  const AppSideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Chats',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color.fromARGB(255, 89, 99, 97), // WhatsApp teal
      ),
      body: ListView.separated(
        itemCount: 2,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(
              radius: 26,
              backgroundColor: Color.fromARGB(255, 155, 168, 160), // teal/green
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: Text(
              'Chat User ${index + 1}',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: const Text(
              'Last message preview goes here...',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:   [
                Text(
                  '10:45 AM',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 6),
                CircleAvatar(
                  radius: 9,
                  backgroundColor: Color(0xFF25D366),
                  child: Text(
                    '2',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            onTap: () {
              // Navigate to chat screen
            },
          );
        },
      ),
    );
  }
}
