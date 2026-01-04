import 'package:akalpit/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AkalpitEditorPage extends StatelessWidget {
  const AkalpitEditorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.cardBackground,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "Publish",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: const [
            // Title
            TextField(
              decoration:   InputDecoration(
                hintText: "Title",
                hintStyle: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
                border: InputBorder.none,
              ),
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
              maxLines: null,
            ),

            const SizedBox(height: 16),

            // Body
             TextField(
              decoration:   InputDecoration(
                hintText: "Tell your story...",
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                border: InputBorder.none,
              ),
              style: const TextStyle(
                fontSize: 16,
                height: 1.6,
              ),
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
          ],
        ),
      ),
    );
  }
}
