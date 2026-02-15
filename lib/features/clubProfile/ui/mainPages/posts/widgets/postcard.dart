import 'package:akalpit/features/clubProfile/services/models/post_data.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final ClubPost post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(post.title),
        subtitle: Text(post.content),
      ),
    );
  }
}
