import 'package:akalpit/features/profile/ui/widget/profile/bookwidget/bookwidget.dart';
import 'package:flutter/material.dart';
 

class ProfileBooksTab extends StatelessWidget {
  const ProfileBooksTab({super.key});

  @override
  Widget build(BuildContext context) {
    final books = [
      {
        'title': 'Event Name goes here',
        'chapters': 12,
        'image':
            'https://dummyimage.com/300x450/cccccc/000000&text=EVENT1',
      },
      {
        'title': 'Understanding UI/UX Design',
        'chapters': 8,
        'image':
            'https://dummyimage.com/300x450/bbbbbb/000000&text=EVENT2',
      },
      {
        'title': 'Building Scalable Apps',
        'chapters': 15,
        'image':
            'https://dummyimage.com/300x450/aaaaaa/000000&text=EVENT3',
      },
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: books
          .map(
            (book) => ProfileBookItem(
              title: book['title'] as String,
              chapters: book['chapters'] as int,
              imageUrl: book['image'] as String,
            ),
          )
          .toList(),
    );
  }
}
