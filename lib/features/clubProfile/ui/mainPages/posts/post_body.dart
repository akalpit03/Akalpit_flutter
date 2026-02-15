import 'package:akalpit/features/clubProfile/services/clubactions/actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/clubProfile/services/clubactions/viewmodel.dart';
import 'package:akalpit/features/clubProfile/ui/mainPages/posts/widgets/announcementcard.dart';
import 'package:akalpit/features/clubProfile/ui/mainPages/posts/widgets/infopostcard.dart';
import 'package:akalpit/features/clubProfile/ui/mainPages/posts/widgets/postcard.dart';
 
class ClubFeedPage extends StatelessWidget {
  final String clubId;
  final String selectedDate;

  const ClubFeedPage({super.key, required this.clubId, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, ClubViewModel>(
        converter: (store) => ClubViewModel.fromStore(store),
        onInit: (store) {
          store.dispatch(FetchClubPostsByDateAction(clubId: clubId, date: selectedDate));
        },
        builder: (context, vm) {
          if (vm.isPostsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.posts.isEmpty) {
            return const Center(child: Text("No posts for this date 👀"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: vm.posts.length,
            itemBuilder: (context, index) {
              final post = vm.posts[index];

              switch (post.type) {
                case "Announcement":
                  return AnnouncementCard(post: post);
                case "Info":
                  return InfoPostCard(post: post);
                default:
                  return PostCard(post: post);
              }
            },
          );
        },
      ),
    );
  }
}
