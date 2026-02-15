import 'package:akalpit/features/profile/services/profileActions.dart';
import 'package:akalpit/features/profile/services/viewmodels/requestspage.dart';
import 'package:akalpit/features/profile/ui/requests/requestCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:akalpit/core/store/app_state.dart';
 
import 'package:akalpit/features/profile/ui/profile_page.dart';

class FriendsIncomingRequestsPage extends StatelessWidget {
  const FriendsIncomingRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      onInit: (store) {
        store.dispatch(FetchIncomingRequestsAction());
      },
      converter: (store) => ViewModel.fromStore(store),
      builder: (context, vm) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Friend Requests",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
          ),
          body: _buildBody(context, vm),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, ViewModel vm) {
    if (vm.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (vm.error != null) {
      return Center(child: Text("Error: ${vm.error}"));
    }

    if (vm.requests.isEmpty) {
      return const Center(
        child: Text(
          "No incoming requests",
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: vm.requests.length,
      itemBuilder: (context, index) {
        final request = vm.requests[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: FriendRequestCard(
            request: request,
            onAccept: () => vm.accept(request.id),
            onReject: () => vm.reject(request.id),
            onProfileTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      ProfilePage(userId: request.requester.id),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
