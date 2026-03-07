import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/profile/services/viewmodels/profileviewmodel.dart';
import 'package:akalpit/features/profile/ui/widget/profile/about/awards.dart';
import 'package:akalpit/features/profile/ui/widget/profile/about/experience.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:akalpit/features/profile/services/models/userProfileModel.dart';

class ProfileAboutTab extends StatelessWidget {
  final UserProfileModel? profile;
  const ProfileAboutTab({super.key, this.profile});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProfileViewModel>(
      distinct: true,
      converter: ProfileViewModel.fromStore,
      builder: (context, vm) {
        final profileModel = profile ?? vm.profile;

        if (profileModel == null) {
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
                profileModel.bio.isNotEmpty
                    ? profileModel.bio
                    : "No description added yet.",
                style: const TextStyle(color: Colors.white54),
              ),

              // ===== Hobbies =====
              if (profileModel.hobbies.isNotEmpty) ...[
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
                  children: profileModel.hobbies.map((hobby) {
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
              ProfileExperienceTimeline(profile: profileModel),

              const SizedBox(height: 30), // extra bottom breathing space
            ],
          ),
        );
      },
    );
  }
}
