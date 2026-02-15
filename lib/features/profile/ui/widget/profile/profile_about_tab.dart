import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/profile/services/viewmodels/profileviewmodel.dart';
import 'package:akalpit/features/profile/ui/widget/profile/about/awards.dart';
import 'package:akalpit/features/profile/ui/widget/profile/about/experience.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ProfileAboutTab extends StatelessWidget {
  const ProfileAboutTab({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProfileViewModel>(
      distinct: true,
      converter: ProfileViewModel.fromStore,
      builder: (context, vm) {
        final profile = vm.profile;

        if (profile == null) {
          return const SizedBox.shrink();
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== About =====
              const Text(
                'About',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              Text(
                profile.bio.isNotEmpty
                    ? profile.bio
                    : "No description added yet.",
                style: const TextStyle(color: Colors.white54),
              ),

              // ===== Hobbies =====
              if (profile.hobbies.isNotEmpty) ...[
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 12),
                const Text(
                  'Hobbies & Interests',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: profile.hobbies.map((hobby) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.15),
                        ),
                      ),
                      child: Text(
                        hobby,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],

              const SizedBox(height: 20),
              const Divider(),

              // ===== Awards =====
              const SizedBox(height: 10),
              const ProfileAwardsCarousel(),

              const SizedBox(height: 20),
              const Divider(),

              // ===== Experience =====
              const Text(
                'Experience',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              const ProfileExperienceTimeline(),

              const SizedBox(height: 30), // extra bottom breathing space
            ],
          ),
        );
      },
    );
  }
}
