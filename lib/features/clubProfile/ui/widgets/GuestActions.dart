import 'package:akalpit/core/store/app_state.dart';
 import 'package:akalpit/features/clubProfile/services/gettingClub/viewmodel.dart';
import 'package:akalpit/features/clubProfile/services/membership/membershipViewmodel.dart';
import 'package:akalpit/features/clubProfile/ui/onboarding/screens/join/club_joining_status_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class GuestActions extends StatelessWidget {
  const GuestActions({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ClubViewModel>(
      distinct: true,
      converter: ClubViewModel.fromStore,
      builder: (context, clubVm) {
        final club = clubVm.club;
        if (club == null) return const SizedBox.shrink();

        if (club.isMember) return const SizedBox.shrink();

        return StoreConnector<AppState, ClubMembershipViewModel>(
          distinct: true,
          converter: ClubMembershipViewModel.fromStore,
          builder: (context, membershipVm) {
            final hasRequested = membershipVm.myRole == "requested";

            /// 🔐 PRIVATE CLUB
            if (club.privacy == "private") {
              return _button(
                context,
                text: hasRequested ? "Request Sent" : "Request to Join Club",
                enabled: !membershipVm.isLoading,
                // If requested, show a different color style
                isSecondary: hasRequested, 
                onPressed: () {
                  if (hasRequested) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RequestStatusPage(),
                      ),
                    );
                  } else {
                    membershipVm.requestToJoinClub(club.id);
                  }
                },
              );
            }

            /// 🌍 PUBLIC CLUB
            return _button(
              context,
              text: membershipVm.isLoading ? "Joining..." : "Join Club",
              enabled: !membershipVm.isLoading,
              onPressed: () => membershipVm.joinClub(club.id),
            );
          },
        );
      },
    );
  }

  Widget _button(
    BuildContext context, {
    required String text,
    bool enabled = true,
    bool isSecondary = false, // Added parameter for style
    required VoidCallback onPressed,
  }) {
    final theme = Theme.of(context);
    
    // Choose colors based on whether it's a primary action or "Request Sent"
    final bgColor = isSecondary 
        ? theme.colorScheme.surfaceVariant 
        : theme.colorScheme.primary;
    final textColor = isSecondary 
        ? theme.colorScheme.onSurfaceVariant 
        : Colors.white;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        height: 44,
        child: ElevatedButton(
          onPressed: enabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: bgColor,
            disabledBackgroundColor: bgColor.withOpacity(0.6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              // Add a subtle border for the secondary button
              side: isSecondary 
                  ? BorderSide(color: theme.colorScheme.outline.withOpacity(0.2)) 
                  : BorderSide.none,
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}