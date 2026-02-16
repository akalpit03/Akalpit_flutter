import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/Feed/ui/widgets/feedcard.dart';
import 'package:akalpit/features/posts/clubfeed/services/actions.dart';

import 'package:akalpit/features/posts/clubfeed/services/models/feedstory.dart';
import 'package:akalpit/features/posts/clubfeed/services/viewmodel.dart';
import 'package:akalpit/features/posts/story/ui/story_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class ProfilePostsTab extends StatefulWidget {
  final String clubId;
  final bool isAdmin;

  const ProfilePostsTab({
    super.key,
    required this.clubId,
    required this.isAdmin,
  });

  @override
  State<ProfilePostsTab> createState() => _ProfilePostsTabState();
}

class _ProfilePostsTabState extends State<ProfilePostsTab> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // 🔥 First Load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      StoreProvider.of<AppState>(context).dispatch(
        FetchFeedAction(
          clubId: widget.clubId,
        ),
      );
    });

    // _scrollController.addListener(_onScroll);
  }

  // void _onScroll() {
  //   final store = StoreProvider.of<AppState>(context);
  //   final state = store.state.feedState;

  //   if (_scrollController.position.pixels >=
  //       _scrollController.position.maxScrollExtent - 200) {
  //     if (!state.isFetchingMore &&
  //         state.meta?.hasNextPage == true) {
  //       store.dispatch(
  //         FetchMoreFeedAction(
  //           clubId: widget.clubId,
  //           page: (state.meta?.page ?? 1) + 1,
  //         ),
  //       );
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, FeedViewModel>(
      converter: (store) => FeedViewModel.fromStore(store),
      builder: (context, vm) {
        if (vm.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (vm.isEmpty) {
          return const Center(child: Text("No posts yet"));
        }

        return ListView.builder(
          controller: _scrollController,
          itemCount: vm.stories.length + (vm.isFetchingMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == vm.stories.length) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            final FeedStoryModel story = vm.stories[index];

            return FeedCard(
              storyId: story.storyId,
              username: story.author.username,
              title: story.title,
              imageUrl: story.image,
              createdAt: story.createdAt,
              onOpenPost: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => StoryScreen(
                      topicId: story.storyId,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
