import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/profile/services/models/friends/friends.dart';
import 'package:akalpit/features/profile/services/profileActions.dart';
import 'package:akalpit/features/profile/services/viewmodels/friendsviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:akalpit/features/profile/ui/profile_page.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _FriendsPageProps>(
      distinct: true,
      converter: (store) {
        final vm = FriendsViewModel.fromStore(store);
        final currentUserId = store.state.authState.userId ?? '';
        return _FriendsPageProps(
          viewModel: vm,
          currentUserId: currentUserId,
        );
      },
      onInit: (store) => store.dispatch(FetchMyFriendsAction()),
      builder: (context, props) {
        final vm = props.viewModel;
        final currentUserId = props.currentUserId;

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'My Friends',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
          ),
          body: _buildBody(context, vm, currentUserId),
        );
      },
    );
  }

  Widget _buildBody(
      BuildContext context, FriendsViewModel vm, String currentUserId) {
    if (vm.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (vm.error != null) {
      return Center(child: Text("Error: ${vm.error}"));
    }

    if (vm.friends.isEmpty) {
      return const Center(
        child: Text(
          "No friends found",
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: vm.friends.length,
      separatorBuilder: (_, __) => Divider(
        height: 1,
        color: Colors.grey.shade300,
      ),
      itemBuilder: (context, index) {
        final friend = vm.friends[index];
        final otherUser = friend.getOtherUser(currentUserId);

        return _FriendTile(
          friendUser: otherUser,
          onProfileTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ProfilePage(userId: otherUser.id),
              ),
            );
          },
          onRemove: vm.removeFriend != null
              ? () => vm.removeFriend!(friend.id)
              : null,
        );
      },
    );
  }
}

/// Props container
class _FriendsPageProps {
  final FriendsViewModel viewModel;
  final String currentUserId;

  _FriendsPageProps({
    required this.viewModel,
    required this.currentUserId,
  });
}

/// WhatsApp Style List Tile
class _FriendTile extends StatelessWidget {
  final FriendUser friendUser;
  final VoidCallback onProfileTap;
  final VoidCallback? onRemove;

  const _FriendTile({
    required this.friendUser,
    required this.onProfileTap,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onProfileTap,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Avatar
            CircleAvatar(
              radius: 26,
              backgroundColor: Colors.blueGrey.shade100,
              backgroundImage: friendUser.imageUrl != null &&
                      friendUser.imageUrl!.isNotEmpty
                  ? NetworkImage(friendUser.imageUrl!)
                  : null,
              child: friendUser.imageUrl == null ||
                      friendUser.imageUrl!.isEmpty
                  ? Text(
                      friendUser.displayName.isNotEmpty
                          ? friendUser.displayName[0]
                              .toUpperCase()
                          : '?',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.blueGrey,
                      ),
                    )
                  : null,
            ),

            const SizedBox(width: 14),

            /// Name + Username
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    friendUser.displayName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    "@${friendUser.username}",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            /// Remove Button (minimal look)
            if (onRemove != null)
              TextButton(
                onPressed: onRemove,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
                  minimumSize: Size.zero,
                  tapTargetSize:
                      MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  "Remove",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
