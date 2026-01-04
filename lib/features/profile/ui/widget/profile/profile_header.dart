import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/profile/ui/viewmodel/profileviewmodel.dart';
import 'package:akalpit/features/profile/ui/widget/header/statItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ProfileHeader extends StatelessWidget {
  final Map<String, dynamic>? localProfile; // optional local profile

  const ProfileHeader({this.localProfile, super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProfileViewModel>(
      distinct: true,
      converter: ProfileViewModel.fromStore,
      builder: (context, vm) {
        // If localProfile exists, use it
        if (localProfile != null) {
          final profile = localProfile!; // cast to Map<String, dynamic>

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: profile['imageUrl'] != null
                          ? NetworkImage(profile['imageUrl'])
                          : null,
                      child: profile['imageUrl'] == null
                          ? const Icon(Icons.person, size: 40)
                          : null,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile['displayName'] ?? profile['name'] ?? "",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              StatItem(label: "Posts", value: "0"),
                              StatItem(label: "Events", value: "0"),
                              StatItem(label: "Friends", value: "0"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.person_add_outlined, size: 18),
                    label: const Text(
                      "Add Friend",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        // Otherwise fallback to Redux profile
        final profileModel = vm.profile;
        if (profileModel == null) return const SizedBox.shrink();

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: profileModel.imageUrl != null
                        ? NetworkImage(profileModel.imageUrl!)
                        : null,
                    child: profileModel.imageUrl == null
                        ? const Icon(Icons.person, size: 40)
                        : null,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profileModel.displayName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StatItem(label: "Posts", value: "0"),
                            StatItem(label: "Events", value: "0"),
                            StatItem(label: "Friends", value: "0"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.person_add_outlined, size: 18),
                  label: const Text(
                    "Add Friend",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
