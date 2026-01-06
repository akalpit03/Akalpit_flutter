import 'package:akalpit/features/clubProfile/ui/mainPages/clubProfilePage.dart';
import 'package:akalpit/features/clubsection/ui/viewmodel/clubStateViewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:akalpit/core/store/app_state.dart';

import 'package:akalpit/features/clubProfile/ui/onboarding/screens/create/verify.dart';
import 'package:akalpit/features/clubProfile/services/states/clubs.dart';

class StatusList extends StatelessWidget {
  const StatusList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: StoreConnector<AppState, ClubScreenViewModel>(
        converter: ClubScreenViewModel.fromStore,
        distinct: true,
        builder: (context, vm) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: vm.followingClubs.length + 1,
            itemBuilder: (context, index) {
              /// FIRST CARD (My Club OR Create Club)
              if (index == 0) {
                if (vm.myClub != null) {
                  return _MyClubStatusCard(club: vm.myClub!);
                } else {
                  return const _CreateClubStatusCard();
                }
              }

              /// OTHER CLUBS
              final Club club = vm.followingClubs[index - 1];
              return _OtherClubStatusCard(club: club);
            },
          );
        },
      ),
    );
  }
}

class _CreateClubStatusCard extends StatelessWidget {
  const _CreateClubStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const VerifyClubPage(),
          ),
        );
      },
      child: const  _BaseStatusCard(
        imageUrl: null,
        title: 'Create your Club flow',
      ),
    );
  }
}

class _MyClubStatusCard extends StatelessWidget {
  final Club club;

  const _MyClubStatusCard({
    super.key,
    required this.club,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
        context,
        MaterialPageRoute(
        builder: (_) => ClubHomePage(clubId: club.id),
        ),
        );
      },
      child: _BaseStatusCard(
        imageUrl: club.image,
        title: club.clubName,
      ),
    );
  }
}

class _OtherClubStatusCard extends StatelessWidget {
  final Club club;

  const _OtherClubStatusCard({
    super.key,
    required this.club,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (_) => ClubHomePage(clubId: club.id),
        //   ),
        // );
      },
      child: _BaseStatusCard(
        imageUrl: club.image,
        title: club.clubName,
      ),
    );
  }
}

class _BaseStatusCard extends StatelessWidget {
  final String? imageUrl;
  final String title;

  const _BaseStatusCard({
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 14),
      child: Column(
        children: [
          Container(
            height: 170,
            width: 130,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(14),
            ),
            clipBehavior: Clip.hardEdge,
            child: imageUrl != null && imageUrl!.isNotEmpty
                ? Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return _fallbackIcon();
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      );
                    },
                  )
                : _fallbackIcon(),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  Widget _fallbackIcon() {
    return const Center(
      child: Icon(
        Icons.group,
        size: 36,
        color: Colors.white,
      ),
    );
  }
}
