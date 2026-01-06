import 'package:akalpit/core/constants/app_colors.dart';
import 'package:akalpit/features/clubProfile/ui/mainPages/teams/memberslist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/clubProfile/services/gettingClub/viewmodel.dart';
import 'package:akalpit/features/clubProfile/ui/mainPages/teams/TeamWidgets/admin_header.dart';
import 'package:akalpit/features/clubProfile/ui/mainPages/teams/TeamWidgets/members_card.dart';
import 'package:akalpit/features/clubProfile/ui/mainPages/teams/floatingButtonActions/AddMember.dart';

class ClubTeamPage extends StatelessWidget {
  final bool isAdmin;
  final String clubId;
  final dynamic owner;

  const ClubTeamPage({
    super.key,
    required this.isAdmin,
    required this.clubId,
    required this.owner,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ClubViewModel>(
      converter: (store) => ClubViewModel.fromStore(store),
      builder: (context, vm) {
        if (vm.isLoading) return const Center(child: CircularProgressIndicator());

        // Extract admins and owners correctly from the store data
        final List<dynamic> admins = ( []).where((m) {
          return m['role'] == 'admin' || m['role'] == 'owner';
        }).toList();

        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                /// 1. Owner Header
                AdminHeader(owner: owner),

                const SizedBox(height: 24),

                /// 2. Section Label for Admins
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Club Administrators",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                /// 3. Admin List
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: admins.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text("No admins found", style: TextStyle(color: Colors.grey)),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: admins.length,
                          itemBuilder: (context, index) {
                            // return MembersCard(member: admins[index]);
                          },
                        ),
                ),
                
                // Ensures content doesn't get cut off by the fixed bottom button
                const SizedBox(height: 100), 
              ],
            ),
          ),

          /// 4. Full-Width Bottom Action Bar
          bottomNavigationBar: _buildFullWidthMemberButton(context),

          /// 5. Floating Action Button
          floatingActionButton: isAdmin
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 15.0), 
                  child: FloatingActionButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AddPersonPage()),
                    ),
                    backgroundColor: Colors.white,
                    elevation: 4,
                    child: const Icon(Icons.person_add_alt_1, color: Colors.black),
                  ),
                )
              : null,
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      },
    );
  }

  Widget _buildFullWidthMemberButton(BuildContext context) {
    // Using SafeArea to ensure the button doesn't overlap with system nav bars (like on iPhone)
    return SafeArea(
      child: Material(
        color: AppColors.cardBackground, // Solid background
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => MembersListPage(clubId: clubId)));
          },
          child: Container(
            width: double.infinity,
            height: 65, // Standard action bar height
            alignment: Alignment.center,
            decoration: const BoxDecoration(
               border: Border(top: BorderSide(color: Colors.white10, width: 0.5))
            ),
            child:const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Icon(Icons.people_alt_rounded, color: Colors.white, size: 22),
                  SizedBox(width: 12),
                  Text(
                  "VIEW ALL CLUB MEMBERS",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward_rounded, size: 18, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}