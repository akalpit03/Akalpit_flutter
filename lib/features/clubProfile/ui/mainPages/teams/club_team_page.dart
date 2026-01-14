import 'package:akalpit/core/constants/app_colors.dart';
import 'package:akalpit/features/clubProfile/services/membership/membershipViewmodel.dart';
import 'package:akalpit/features/clubProfile/ui/mainPages/teams/TeamWidgets/memberCards.dart';
import 'package:akalpit/features/clubProfile/ui/mainPages/teams/memberslist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:akalpit/core/store/app_state.dart';
// Import your NEW ViewModel
 import 'package:akalpit/features/clubProfile/ui/mainPages/teams/TeamWidgets/admin_header.dart';
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
    // 1. Switch to ClubMembershipViewModel
    return StoreConnector<AppState, ClubMembershipViewModel>(
      // 2. Fetch admins specifically when this page opens
      onInit: (store) => ClubMembershipViewModel.fromStore(store).getClubAdmins(clubId),
      converter: (store) => ClubMembershipViewModel.fromStore(store),
      builder: (context, vm) {
        
        // 3. Use the admins list directly from the ViewModel/State
        final List<dynamic> admins = vm.admins;

        return Scaffold(
          // Use RefreshIndicator so users can pull to refresh the admin list
          body: RefreshIndicator(
            onRefresh: () async => vm.getClubAdmins(clubId),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  /// 1. Owner Header
                  AdminHeader(owner: owner),

                  const SizedBox(height: 24),

                  /// 2. Section Label
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

                  /// 3. Admin List with Loading State
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: vm.isLoading && admins.isEmpty
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 40),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : admins.isEmpty
                            ? const Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Text("No admins found", style: TextStyle(color: Colors.grey)),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: admins.length,
                                itemBuilder: (context, index) {
                                  return MemberCard(member: admins[index]);
                                },
                              ),
                  ),
                  
                  const SizedBox(height: 100), 
                ],
              ),
            ),
          ),

          bottomNavigationBar: _buildFullWidthMemberButton(context),

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

  // ... (Keep your _buildFullWidthMemberButton exactly as it is)
  Widget _buildFullWidthMemberButton(BuildContext context) {
    return SafeArea(
      child: Material(
        color: AppColors.cardBackground,
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => MembersListPage(clubId: clubId)));
          },
          child: Container(
            width: double.infinity,
            height: 65,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Colors.white10, width: 0.5))
            ),
            child: const Row(
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