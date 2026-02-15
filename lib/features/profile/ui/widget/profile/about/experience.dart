import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/profile/services/viewmodels/profileviewmodel.dart';
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

        if (experiences.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              "No experience added yet.",
              style: TextStyle(color: Colors.grey),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(experiences.length, (index) {
            final exp = experiences[index];
            final isLast = index == experiences.length - 1;

            final startYear =
                exp.startDate != null ? exp.startDate!.year.toString() : '';
            final endYear =
                exp.endDate != null ? exp.endDate!.year.toString() : 'Present';

            return Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Timeline Indicator
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
                          height: 60,
                          color: Colors.blueGrey.withOpacity(0.4),
                        ),
                    ],
                  ),

                  const SizedBox(width: 14),

                  /// Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          exp.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
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

                        if (startYear.isNotEmpty)
                          Text(
                            '$startYear - $endYear',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),

                        if (exp.description.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              exp.description,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black87,
                                height: 1.4,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
