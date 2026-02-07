import 'package:akalpit/features/clubProfile/ui/mainPages/posts/floating_button_actions/createPost/create_post.dart';
import 'package:akalpit/features/clubProfile/ui/mainPages/posts/inform_admins.dart';
import 'package:akalpit/features/clubProfile/ui/mainPages/posts/post_body.dart';
import 'package:flutter/material.dart';

class ClubPostsPage extends StatelessWidget {
  final String clubId;
  final bool isAdmin;

  const ClubPostsPage({
    super.key,
    required this.clubId,
    required this.isAdmin,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SampleFeedPage(),

      /// 👇 Floating button only for Admin
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              backgroundColor: Colors.white,
              elevation: 4,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CreateClubPostPage(
                      clubId: clubId,
                    ),
                  ),
                );
              },
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            )
          : null,

      /// 👇 Bottom button only for NON-admins
      bottomNavigationBar: !isAdmin
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 231, 224, 224),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => InformAdminsPage(
                            clubId: clubId,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Inform Admins",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
