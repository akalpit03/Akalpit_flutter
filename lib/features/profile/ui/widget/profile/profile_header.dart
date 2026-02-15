import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/profile/services/models/userProfileModel.dart';
import 'package:akalpit/features/profile/services/viewmodels/profileviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ProfileHeader extends StatelessWidget {
  final UserProfileModel? profile;
  final bool isSelf;

  const ProfileHeader({
    super.key,
    this.profile,
    required this.isSelf,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProfileViewModel>(
      distinct: false,
      converter: ProfileViewModel.fromStore,
      builder: (context, vm) {
        final profileModel = profile ?? vm.profile;

        if (profileModel == null) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            children: [
              /// Avatar
              CircleAvatar(
                radius: 48,
                backgroundImage: profileModel.imageUrl != null &&
                        profileModel.imageUrl!.isNotEmpty
                    ? NetworkImage(profileModel.imageUrl!)
                    : null,
                child: (profileModel.imageUrl == null ||
                        profileModel.imageUrl!.isEmpty)
                    ? const Icon(Icons.person, size: 40)
                    : null,
              ),

              const SizedBox(height: 14),

              /// Name
              Text(
                profileModel.displayName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),

              /// Username
              if (profileModel.username != null &&
                  profileModel.username!.isNotEmpty)
                Text(
                  "@${profileModel.username}",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),

              /// Location
              if (profileModel.location != null &&
                  profileModel.location!.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.location_on,
                        size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      profileModel.location!,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),

              const SizedBox(height: 20),

              /// Stats + Follow Button
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Stats Section
                  Flexible(
                    fit: FlexFit.loose,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSmallStat(
                            "Posts", profileModel.totalPosts),
                        _buildSmallStat(
                            "Events", profileModel.totalParticipations),
                        _buildSmallStat(
                            "Friends", profileModel.totalFriends),
                      ],
                    ),
                  ),

                  /// Follow Button
                  if (!isSelf)
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: IntrinsicWidth(
                        child: SizedBox(
                          height: 34,
                          child: _buildCompactFriendButton(
                              vm, profileModel),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSmallStat(String label, int value) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildCompactFriendButton(
    ProfileViewModel vm,
    UserProfileModel profile,
  ) {
    final friendship = profile.friendship;

    String text;
    Color color;
    VoidCallback? onPressed;

    if (friendship == null) {
      text = "Follow";
      color = Colors.black;
      onPressed = () {};
    } else if (friendship.isFriend) {
      text = "Unfollow";
      color = Colors.red;
      onPressed = () {};
    } else if (friendship.status == "pending") {
      if (friendship.isRecipient) {
        text = "Accept";
        color = Colors.green;
        onPressed = () {};
      } else {
        text = "Cancel";
        color = Colors.grey;
        onPressed = () {};
      }
    } else {
      text = "Follow";
      color = Colors.black;
      onPressed = () {};
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        elevation: 0,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
