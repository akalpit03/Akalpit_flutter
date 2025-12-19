import 'package:akalpit/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ClubSettingsPage extends StatelessWidget {
  const ClubSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionTitle("Posts and Club"),
          _settingsCard(
            context,
            title: "Rules",
            onTap: () {},
          ),
          _settingsCard(
            context,
            title: "Policies",
            onTap: () {},
          ),
          _settingsCard(
            context,
            title: "Description",
            onTap: () {},
          ),

          const SizedBox(height: 24),

          _sectionTitle("Events"),
          _settingsCard(
            context,
            title: "Manage Participation",
            onTap: () {},
          ),
          _settingsCard(
            context,
            title: "Manage Volunteers",
            onTap: () {},
          ),
          _settingsCard(
            context,
            title: "View Analytics",
            onTap: () {},
          ),
          _settingsCard(
            context,
            title: "Handle Requests (Event-wise)",
            onTap: () {},
          ),

          const SizedBox(height: 24),

          _sectionTitle("Teams"),
          _settingsCard(
            context,
            title: "Set Permissions",
            onTap: () {},
          ),
          _settingsCard(
            context,
            title: "See Requests",
            onTap: () {},
          ),
          _settingsCard(
            context,
            title: "Collaboration",
            onTap: () {},
          ),

          const SizedBox(height: 24),

          _sectionTitle("About"),
          _settingsCard(
            context,
            title: "Transfer Club",
            isDestructive: true,
            onTap: () {},
          ),
          _settingsCard(
            context,
            title: "Set Privacy Status",
            onTap: () {},
          ),
        ],
      ),
    );
  }

  /// SECTION TITLE
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  /// SETTINGS CARD
  Widget _settingsCard(
    BuildContext context, {
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            color: isDestructive ? Colors.red : Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
