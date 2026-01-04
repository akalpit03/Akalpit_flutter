 
import 'package:akalpit/features/clubProfile/services/gettingClub/actions.dart';
import 'package:akalpit/features/clubProfile/services/gettingClub/viewmodel.dart';
 import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/clubProfile/ui/widgets/AboutSection.dart';
import 'package:akalpit/features/clubProfile/ui/widgets/ClubHeader.dart';
import 'package:akalpit/features/clubProfile/ui/widgets/GuestActions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ClubProfilePage extends StatelessWidget {
  final bool isGuest;
  final String clubId;

  const ClubProfilePage({
    super.key,
    required this.isGuest,
    required this.clubId,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ClubViewModel>(
      onInit: (store) {
        store.dispatch(GetClubAction(clubId));
      },
      converter: (store) => ClubViewModel.fromStore(store),
      builder: (context, vm) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Club Profile',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
          ),
          body: _buildBody(vm),
        );
      },
    );
  }

  Widget _buildBody(ClubViewModel vm) {
 
    if (vm.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (vm.error != null) {
      return Center(child: Text(vm.error!));
    }

    if (vm.club == null) {
      return const Center(child: Text("Club not found"));
    }

    return Column(
      children: [
 
        ClubHeader(club: vm.club!),const SizedBox(height: 20),
 AboutSection(club: vm.club!),
        const SizedBox(height: 20),

 
       const Expanded(
          child: Padding(
            padding:   EdgeInsets.symmetric(horizontal: 16),
            child:   GuestActions(),
              
          ),
        ),
      ],
    );
  }
}
