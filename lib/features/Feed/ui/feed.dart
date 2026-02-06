import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:akalpit/features/editor/editor.dart';
import 'package:akalpit/features/Feed/ui/sidedrawer/sideDrawer.dart';
import 'package:akalpit/features/Feed/ui/widgets/appbar.dart';
import 'package:akalpit/features/Feed/ui/widgets/feed_body.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  Future<void> _showDeviceTokenModal(BuildContext context) async {
    try {
      final token = await FirebaseMessaging.instance.getToken();

      if (token == null || token.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Device token not available"),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Device Token"),
          content: SingleChildScrollView(
            child: SelectableText(token),
          ),
          actions: [
            TextButton.icon(
              icon: const Icon(Icons.copy),
              label: const Text("Copy"),
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: token));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Device token copied to clipboard"),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
            TextButton(
              child: const Text("Close"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error fetching token: $e"),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FeedAppBar(),
      drawer: const AppSideDrawer(),

      body: Column(
        children: [
          // Main feed
          const Expanded(child: FeedBody()),

          // Button to show token modal
          Padding(
            padding: const EdgeInsets.all(12),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.vpn_key),
                label: const Text("Show Device Token"),
                onPressed: () => _showDeviceTokenModal(context),
              ),
            ),
          ),
        ],
      ),

      // Floating action button to create a post
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AkalpitEditorPage(),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.edit),
      ),
    );
  }
}
