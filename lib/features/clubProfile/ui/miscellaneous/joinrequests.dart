import 'package:akalpit/features/profile/services/profileActions.dart';
import 'package:akalpit/features/profile/ui/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/clubProfile/services/membership/membershipViewmodel.dart';

class ClubJoinRequestsPage extends StatelessWidget {
  final String clubId;

  const ClubJoinRequestsPage({
    super.key,
    required this.clubId,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ClubMembershipViewModel>(
      onInit: (store) => ClubMembershipViewModel.fromStore(store)
          .getPendingJoinRequests(clubId),
      converter: (store) => ClubMembershipViewModel.fromStore(store),
      builder: (context, vm) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Join Requests',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
          ),
          body: _buildBody(context, vm),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, ClubMembershipViewModel vm) {
    if (vm.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (vm.error != null) {
      return Center(child: Text("Error: ${vm.error}"));
    }

    if (vm.pendingRequests.isEmpty) {
      return const Center(
        child: Text(
          "No pending requests",
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: vm.pendingRequests.length,
      itemBuilder: (context, index) {
        final request = vm.pendingRequests[index];

        final String membershipId = request['_id'];
        final String userId = request['userId']?['_id'] ?? '';
        final String username =
            request['userId']?['username'] ?? 'Unknown User';
        final String requestedAt = request['requestedAt'] ?? '';

        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: _RequestCard(
            username: username,
            requestedAt: requestedAt,
            onProfileTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(userId: userId),
                ),
              );
            },
            onAccept: () => vm.acceptJoinRequest(membershipId),
            onReject: () => vm.rejectJoinRequest(membershipId),
          ),
        );
      },
    );
  }
}

class _RequestCard extends StatelessWidget {
  final String username;
  final String requestedAt;
  final VoidCallback onProfileTap;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const _RequestCard({
    required this.username,
    required this.requestedAt,
    required this.onProfileTap,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            /// Avatar (Clickable to go to Profile)
            GestureDetector(
              onTap: onProfileTap,
              child: CircleAvatar(
                radius: 26,
                backgroundColor: Colors.blueGrey.shade100,
                child: Text(
                  username.isNotEmpty
                      ? username.substring(0, 1).toUpperCase()
                      : '?',
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.blueGrey),
                ),
              ),
            ),

            const SizedBox(width: 14),

            /// User Info (Clickable to go to Profile)
            Expanded(
              child: InkWell(
                onTap: onProfileTap,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Requested on ${requestedAt.split('T')[0]}', // Simple Date formatting
                      style:
                          TextStyle(fontSize: 13, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            ),

            /// Actions
            Column(
              children: [
                _ActionButton(
                    label: 'Accept', color: Colors.green, onTap: onAccept),
                const SizedBox(height: 6),
                _ActionButton(
                    label: 'Reject', color: Colors.red, onTap: onReject),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton(
      {required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
              fontSize: 13, fontWeight: FontWeight.w600, color: color),
        ),
      ),
    );
  }
}
