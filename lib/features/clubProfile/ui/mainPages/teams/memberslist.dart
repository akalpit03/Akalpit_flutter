import 'package:akalpit/core/constants/app_colors.dart';
import 'package:akalpit/features/clubProfile/services/membership/membershipViewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:akalpit/core/store/app_state.dart';
 
import 'package:akalpit/features/clubProfile/ui/mainPages/teams/TeamWidgets/memberCards.dart';

class MembersListPage extends StatelessWidget {
  final String clubId;

  const MembersListPage({super.key, required this.clubId});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ClubMembershipViewModel>(
      // 1. Trigger the fetch action when the page is initialized
      onInit: (store) => ClubMembershipViewModel.fromStore(store).getClubMembers(clubId),
      
      // 2. Convert the store to your ViewModel
      converter: (store) => ClubMembershipViewModel.fromStore(store),
      
      builder: (context, vm) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "All Members",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: AppColors.cardBackground,
            elevation: 0.5,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Column(
            children: [
              /// Search Bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  onChanged: (value) {
                    // You could implement local filtering or a search action here
                  },
                  decoration: InputDecoration(
                    hintText: "Search members...",
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: AppColors.cardBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              /// Loading and List Logic
              Expanded(
                child: vm.isLoading && vm.members.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : vm.members.isEmpty
                        ? const Center(child: Text("No members found"))
                        : RefreshIndicator(
                            onRefresh: () async => vm.getClubMembers(clubId),
                            child: ListView.builder(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              itemCount: vm.members.length,
                              itemBuilder: (context, index) {
                                // 3. Use the real data from the ViewModel
                                return MemberCard(member: vm.members[index]);
                              },
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