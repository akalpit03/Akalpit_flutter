import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/profile/ui/viewmodel/profileviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ProfileExperienceTimeline extends StatelessWidget {
  const ProfileExperienceTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProfileViewModel>(
      distinct: true,
      converter: ProfileViewModel.fromStore,
      builder: (context, vm) {
        final experiences = vm.profile?.experiences ?? [];

        // Empty state
        if (experiences.isEmpty) {
          return const Text(
            "No experience added yet.",
            style: TextStyle(color: Colors.grey),
          );
        }

        return Column(
          children: List.generate(experiences.length, (index) {
            final exp = experiences[index];
            final isLast = index == experiences.length - 1;

            final startYear = exp.startDate?.year.toString() ?? '';
            final endYear =
                exp.endDate != null ? exp.endDate!.year.toString() : 'Present';

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ===== Timeline indicator =====
                Column(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.blueGrey,
                        shape: BoxShape.circle,
                      ),
                    ),
                    if (!isLast)
                      Container(
                        width: 2,
                        height: 50,
                        color: Colors.blueGrey,
                      ),
                  ],
                ),

                const SizedBox(width: 12),

                // ===== Content =====
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          exp.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (exp.organization.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              exp.organization,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        const SizedBox(height: 4),
                        Text(
                          '$startYear - $endYear',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        );
      },
    );
  }
}
